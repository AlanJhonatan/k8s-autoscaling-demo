import type { Request, Response } from 'express';

export const heavyWork = (req: Request, res: Response) => {
  const start = Date.now();
  let result = 0;
  for (let i = 0; i < 1e7; i++) {
    result += Math.sqrt(Math.random() * Math.random());
  }
  const end = Date.now();
  res.json({
    message: 'Heavy work finished',
    duration: `${end - start}ms`,
    result: result.toFixed(2)
  });
};
