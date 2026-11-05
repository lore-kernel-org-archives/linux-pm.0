Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866388;
	b=F+wFNcF+JxmdGTgqUfS0yATgHCoQy0/ROvvUy9q+V1g1jta8jCxMV/ERA+XRsESpOcTU
	 9vhaD2W+zGnF+Wnp6jnCuiDh5G10dMqCRvSsV6k1ExVnyy/r+kHzuF1ibiDllzycfVuJz
	 OzaRn3uvV+aq/J9sjuSoLwgYkXXUCp0qNFcIdIEfVU/U40lZI/AUyPqiSumQ/M72lFqrA
	 LN+eQ9Fdo2VZAs1mECof6JQQlurnbF5zxqghESeBoAHKAtGDyvW3RZHbmo9g2grkxvQM7
	 ewTrU/OCcAxj/ZPPWR0Wq669w8VFeXMonUFMvhW9VVmqq5wJqwV7dGZSmTIKH/Kx13A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9dHqEQDspEWpNSsGAH3iVlCCP1/Qrk4vRtH/AtYlCt0=;
	b=KJm/9+2VSYzCMqZCQv9bdDzBOyqOTXrOxHF2tKMFEg4e4x3XrsmPs43trvVUW7MYon3f
	 Fz+/T63g39EF98jgtQZdQ2hArFdoZmuD8HddDxo/druy83snlGrTFy50q32ns/HzTOxqC
	 GJKVH5lRhIXnFCB7uRJgy/DV18FxugaSHqkBhFOIFpqwygxBTIqGWooe3/ELJwzvTCR7m
	 94/xiDNvDFNTE5olDE1vT9b/buKCD/DVJ58oTi9giCSKXKz1VrGBrpqtFfPOcW52GrViT
	 b9DhZPQCgouyi6Y7ALkVsbUNgvwYKc3RXP4aaapcRfdaVJum3ztNQMXaZuuKD272l0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gszowiG2;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE4606A31B
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 08:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFE4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gszowiG2
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df54150dfso1051363f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793866386; x=1794471186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9dHqEQDspEWpNSsGAH3iVlCCP1/Qrk4vRtH/AtYlCt0=;
        b=gszowiG2ccQVtUg1EsYV87agHiRL09NHFwH6O/IOTo3qFvWgpHNPasdcYKX81gAJrH
         7HXtUnEC6c47sLD2gMa2wUNO0I+U0YyWbIUPQjOAiakkPBDpupTR2VqjfAqgiGTkC6aC
         RLVQXRHKUz37McSjaCsqhHlr6qnYE16VSE5kX540qPAjiPjm0W4zvSTqZ3d3q47j5qrd
         qGuX5My9myNkSTPYJI1O+T2uGDg1rN5Pxf7nfcbnHMCEG8RBjr3MVYQwTx5t9wSRX6qv
         4yvglYXy38lMf22Ua0id4PivbWTUrdmVSyJb/Mjx0wNfF046lRBGgVCgyk5Cls5Y+H9t
         t8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866386; x=1794471186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9dHqEQDspEWpNSsGAH3iVlCCP1/Qrk4vRtH/AtYlCt0=;
        b=VR1arqqQeJf6ev0ZlM/32Nkrg+MK5Vmz/Oo22FPHSHB9plqsSY0iXZlgqQ2Gb9M7FH
         M5hchSAUCy+E7emjp9rbr5U524XTfZf6evo8KyWyDY0D7ejfYUA9k7AoOuJFYNbyU3RY
         CVATvFoYJPAIYOxX7QtJAXJvWSYDu1pnJxB0OFNfRdttnQXePC57Yh9JMDqtGuIudr/I
         wojbjw9uJnrxNkbSuRyQvQ1M0oP2uUekLvaWaFdYV/obFwJKuXMHm1ZcY4z5cBqe9dOv
         61g51cbQoQs6bK+bR+m3NZp1gu+2uYi79RwHT6/UxBlyOPNAVMwfboNec7BZYsJ9gz3+
         zrIA==
X-Forwarded-Encrypted: i=1; AKwUvBxGb95uwLm5whFSuc3pRt9aGKpdRVnOLWA11riB+7kdmY7YVIp1NxaRZYUXrh3GiG7oi9FW+lPoAg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KS0YI4Cf2hEbJfKk9DnbKlBA3OWgtZmht1+igtOFohSmjfo09
	PvPRrOAtNT38T5SOGTUnbGnEqgfkoUjEphHEaYfl09szNPsD5I/pvder
X-Gm-Gg: AYBFou3FRarvgCCFqAPHYLeNv2L/3KQccB24CH0uZd9uCXHe3Bvx0aan2JRkfIIxKvN
	VAjoPaWHbcdxXU3PMBYfipqkl6lxVqtabVpJ6MYuhIHWytQWAhdMujFLfXMwhZ9A2oqjumXSSiu
	QQjlQ5LB+dBid0Uqd+siRbUJyn/V6vsp3H73iDssVsjcs4xBeGZNftALKycVGdrXYDBzG7xZFAt
	36nDnvFSF8xdPqj7MhsewEcL/7aspXxV6vmze1ahtKzy2Whn3ZnhCofJiGgkKAhIlWAWsEQ1KPC
	a6+KcN9I2E9cC7Wx6cxLkOx5E6lOeotW3SMC1auxW5L++RHgu/40zPKS0z/reI2SSqCA+dhd0iB
	P0QYknGVbpQIMlHuvQpYBeOoANwT/IFKmhqPhvEaWkdL4c4oMsNfHm/ua1o7xAd6YOLrgzH4C0z
	rkyHflTH4x6vk70MKon4X1XP5YpMZsqKVBimZR6XcpHbxV6CBqCnAEFjkMSHHynmgyZwaI8vyoq
	IgmEn6Td6p52ZnYYX8Nopqs4d1QQ4phMRu7iw840hnSzkST5Cl2r2IO69kyPhVyFQQp8heutM7k
	1mC1Xg7wjdpFzJXXZTg=
X-Received: by 2002:a05:600c:4e50:b0:4a1:7d9b:d4ae with SMTP id 5b1f17b1804b1-4ac16fa3523mr419543105e9.5.1793866386076;
        Thu, 05 Nov 2026 00:13:06 -0800 (PST)
Received: from fedora ([2.35.201.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22f4sm79093385e9.13.2026.11.05.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:13:05 -0800 (PST)
From: Francesco Nigro <nigro.fra@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mike Galbraith <efault@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms behind another task on the preferred CPU while allowed CPUs are idle
Date: Thu,  5 Nov 2026 09:12:45 +0100
Message-ID: <20261105081245.81773-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-11-05 at 09:41 +0530, K Prateek Nayak wrote:
> Hello Francesco,

Hi Prateek,

thanks a lot for looking into this, and for the patch.

This is a corporate machine, so I can't promise I will be able to boot
a patched kernel on it, but I will try.

> Since you say ITMT disabled actually solves this issue, I suspect there is a
> race between the idle balancer moving the delayed task to a preferred CPU vs
> a wakeup that also lands on the same CPU.

perf sched shows a race like that, but the task moved is the running
one, by active balance. One example (perf sched timehist, trimmed; ms):

    .654334  [6]  worker 482   awakened: migration/7
    .654337  [6]  worker 482   blocks
    .654338  [7]  worker 481   preempted while running
    .654341  [7]  migration/7  migrated: worker 481 cpu 7 => 6
    .654341  [2]  waker        awakened: worker 482
    .655572  [6]  worker 482   ran 1.006 after 0.224 sch delay

Does your change cover the active balance path too?

> So at this point, I would have expected B to have already been
> moved by a newidle / idle balance.

Not here: in 270 of 286 waits of 0.5 ms or more, neither worker left
CPU 6, and CPUs 4, 5 and 7 were idle for at least 98 % of the wait.

Trace summary and excerpt:
https://github.com/franz1981/itmt-delay-dequeue-repro/tree/827b6b2

Thanks,
Franz
