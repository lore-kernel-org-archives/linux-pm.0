Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735352;
	b=JqQRpJwNOXyTKhQ22J4yJw4XfEh3Gz5KoIYQPqsj/KjeSIFNud9hf6DpT0tsD/lmPxVh
	 f9i0fkWznVO+Y7NVQVRSsuAn2dcWE11u8jRBLy7aRO2HIPwiGeX+JWAyDPtgAHoSHtGfE
	 dhAUkTQ9NJeINPxiqJWMwWRqRGPORex9LxmdsuYTSoAUuA6/XH7MYSptjP5CFMLbBJiY1
	 DUCSQdeC3YGaf+0bwXKir3x8OxCMvyvO+7mI7XN/I7YwuAjNc5CY0L5pBo3DHAM2PmQYC
	 NEUxdLu7Q30pOkKm5jxd8HJPfZpPpSwGvJ6FkQ+xkKI9vonvqL80rcoPxSkllJdEUfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
	b=ygoPjW3rhS7QLOmdzQso0Ol1wuxWhF7p+Hk4KbhUC7KmQeUB6EXdBkC+h7kls8qUEOo+
	 Tk11vOEbyo4Luo/0SHB4+TTJNJ4BZI31H+FGb/fvIh5Na2ivnGslBta64XO6vU+wDNjRn
	 Sg38SOEfJahLenI0SM3AwVVttMaClv2G8NNYmDIQwxyWANScp5dS5rrhUdqyJhGsV3Eqp
	 eHvryUd/P2ZD2PLhOFv4o//aO3lD7pbigFJ6zBTbdggcV6By0tI/uUDi3qL2l3B0cqY2i
	 JDXwQy0krvuKaRg/e30Q2VSk+/mvuxxJxZQb/8Cub6bIY/adNl/VdFvYYfjgIhIpMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91C606A326
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE91C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aGZ2Et9X
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a1947498bso5137871eec.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 11:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793735351; x=1794340151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=aGZ2Et9XRSoW7cbdfG5lGqV1+6xNkMS1R5B1w4VS3Ui4cwG+dA7ZizFdMHeq/+0/U2
         BilbKO1Fm20PtDD+HMuAm41zwNmvgYD1/eu5ZYOqs0KvvAzMehsm4uvfUZwfY7oaLBib
         FeozBa5ngKAi8pE181aL5qQbAJrKKuOySBVyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735351; x=1794340151;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P0AC+ymgXYnQmZ+rTAXF3fAS8FaKmkjFTCnbuMJ/sUM=;
        b=fNwLbhtXyuporrnAd2BhC3s3SaPU+q1CDgAWQYaNRXjWKrB8w5wvzUDRA9ikI85e3Z
         5tQ9QDbzDgOvDV4FIuBFgltrrBIyABSMsR8n6Fj1ZQiqu0DcWX3wLUiAT/pnOWQR82dg
         mBrHxiJUD7soAyMVgQNAMPLCXLb0Bvp885sm8jWaPiiiHr9qkOHyFox47M2lIK7vI3eR
         4cJzIRsp/6bZt0cKYihCEmHzu6zo7S7OjmzbOxABWE6Nvk333gcetr+7enPByPAvoK4l
         DT0xQNkZx2C0J982NALvWe7ZBt8KZMuOrPYgj8xtD17aTn3zaRz4Yow+Fe3bJ5krNTCD
         /+EA==
X-Forwarded-Encrypted: i=1; AKwUvByXYdY8FhErLimPYlQrtC0hOVNZXNvLoLdjWcYy+7mKOkewRajJ5IzpBqAEqs7Zwo2rzwMxJZ2ELw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9YKEdRHb1XPzG8RZ0EgOHwlbc6NBb+cis1uoZH6Hg5yViNXYa4
	wb4jtYbR9izxrwLYlloqvlZx7Zhj9BRtPcysJACM4jl8iVl5a686unsz2XvCHVST/A==
X-Gm-Gg: AYBFou33URysfPgxYGQXHmi9IY1fPUWrUApwIUeseh0i57666xxh/BnRGdma9BuXjoA
	SktuNDi19sGk5eVGvRBetIJrb5zgbHpuBWtw726RiZaDlr8l9URxYxxjya5laoro5FXZoS9ielx
	1o17qEiKzJllCgg1VYNRUAA5IUii2kGUw4gZdrVhELZM78v0OZfL+5C3Ij4tUqbVX/jCT7eWs88
	m2zfXuQXlUpMoKgfWrLxC/7PvUOC9SA/eYsGgFyH+xci8LeRix8Ukcoc/Q7txFlWR2dMdu41PQ8
	hM2qY0rKAoH6sFSkfCe7jXRr4oDFrY+xmuFYK4Xd9A4dGLFZvl0QVWdwibDwkoNsHXGv51xyjAi
	g4v471TJGCsWsTFjVc5RS3pvmIqOKuNI6n+KixVkPovnikvymG8m5p7dd7JckL4xt2aKzfCaI/J
	+7+DLSxlS42QspF8pT7TR0DEwZuh8k3cjY9uaY1962h/ZgLCDZofl2z417zWYEu/CqgqLVFoS8Y
	eM3TxME/ZdgWvHIFoEFN+bQvvESZx3OqJfzW2xvBSBz0wTU7ToEQHpD1gmD9nlkA6h1YVA4ZDq4
	F/7xELwNjB6MTZ11hxqHK9BE02MSzCC1Fp05YQKymx60cCzJngq++W/zTVCaK1fYwMnp
X-Received: by 2002:a05:7301:4203:b0:36a:50f4:ed0d with SMTP id 5a478bee46e88-36a50f4ef92mr16355856eec.25.1793735350827;
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a54ccsm382104eec.4.2026.11.03.11.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:49:10 -0800 (PST)
Date: Tue, 3 Nov 2026 11:49:08 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Stanley Jhu <stanleyjhu@google.com>, Jens Axboe <axboe@kernel.dk>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
 already active
Message-ID: <auo6tLmH0R4_TRG6@google.com>
References: <20261029040001.2100001-1-stanleyjhu@google.com>
 <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8125a75a-ea47-49f8-90e4-7f7c83db90e2@acm.org>

Hi Bart,

On Thu, Oct 29, 2026 at 09:22:23AM -0700, Bart Van Assche wrote:
> On 10/29/26 12:08 AM, Stanley Jhu wrote:
> > 2. The first runtime resume fails in the driver callback, and
> >     blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
> >     blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
> >     commands can enter the queue (intended since
> >     commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
> >     runtime active in blk_post_runtime_resume()")).
> 
> q->rpm_status should be changed back to RPM_SUSPENDED if a runtime
> resume fails. The changes made my this patch don't look right to me.

Pardon me if I'm misreading/misunderstanding, but I believe your
suggestion is essentially to unwind the quoted commit 6e1fcab00a23,
which might reintroduce a deadlock.

Brian
