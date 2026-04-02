import { Router } from 'express';
import { healthCheck } from '../controllers/health.js';
import { heavyWork } from '../controllers/heavy.js';

const router = Router();

router.get('/health', healthCheck);
router.get('/heavy', heavyWork);

export default router;
