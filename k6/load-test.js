import { sleep } from 'k6';
import http from 'k6/http';

export const options = {
    stages: [
        { duration: '30s', target: 10 }, // slow,
        { duration: '1m', target: 50 },  // heavy load
        { duration: '30s', target: 0 },  // cool down
    ]
}

export default function () {
    http.get('http://k8s-demo.local/heavy');
    sleep(1);
}