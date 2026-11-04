Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830005;
	b=5YCymF78dqTxErmdEfGqQ8kAjAb/i43ZBbBQgxJf2RFLI/Vl3nN/Ia06PWYtxviShzLm
	 YOGkMhehRu9IygvSMHa9KkhO59w0r3zNBIDwvPcWwfocSRcoSoEUzvrKCqzldbV7I9+1O
	 IFB4qIpQOl9sOK9pdYQrUdA+67E1sGKGKhm+Po4HH9Zrw6rk9/SgB9jTdzVqgak6lcA5h
	 6MNeoavTG4Y6wf/VwIE7NWmgd8SH2E3kjCL6HTTTOaRIQMeuhxsaMyQLPydmtjbcFC5vu
	 TPbgXywT9BEpAzThUczFoSnyQi9yF97BOoFPXjM1KRzJuywC/7xKXZ8NVi6Q4K20R4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=APyAEXSG9B0KEvsmlIgqb108CR+kX9ZzkkBiV+80GpM=;
	b=RFbbrxFWOXWTnCx24Gx1IRPn6sgaqesLeq2jsM7ufRu3nBnw+4HN9UivAixaqv/wG9zp
	 tmbWjt1dXhILkqtEA90gywX96VBy9/gi7L0CJl+DAjMe88mQm2lOki2jnsPi1IgJI9qdC
	 iH/+Vp5gJH9QLQXurGyLKn+MfiAAb7krpecr6nlhOafGmh4rlLgjNWuGMVVGKQpOIk/Hj
	 6yKZQOSsVC3aFagsFy6GvFJWx2HPzzSdpiuRNWP29St+gqbi860B9xROio8ds/GNJrGrj
	 DrltE1L74/FANaeGglTBdbARVOC1gSYDYdlJrsVhwoscPbj0Q5xp8JJgnmwU8j0fxmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nE1J3IvH;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D38606A33A
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 22:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D38606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nE1J3IvH
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso8168355e9.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830003; x=1794434803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=APyAEXSG9B0KEvsmlIgqb108CR+kX9ZzkkBiV+80GpM=;
        b=nE1J3IvHMoQNzkY6NWqRvTSMsazSaZ3o2FOqE6Vkft2ehjTHn8aLnOYg8vT1EO270t
         eN2FAdZlBp8+YwE8ukzqk0r9FrwOxyhmziNfpWj2ioOMKExpHNcgFJE5otJ9L0caAtyh
         yau15/gp49jgw9swqjV53ow9czN9NUQdqeNf3T27Xa35gyFtoWXqTSc7pSL6GR08oAkM
         b2DGAmy7a6UHSRwQp8Ohc3POW7QyBy4QRZZG0yMg1lf6J+mPIwmySw/yfAkqbiw4sbce
         xBEOCYYleBJo/LjnRGx2+5aVtfNFXjhIGVB9Xv354q4SsV8Pa4rFQcR5uwVdllR7FUZH
         auUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830003; x=1794434803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=APyAEXSG9B0KEvsmlIgqb108CR+kX9ZzkkBiV+80GpM=;
        b=gQ+P6YYccKDTSlrEVAZ+Y2GTcsugInfJu4zZLmdhx0gPoLkWD0gjs0LN6YCnSRb/BD
         n7sSiMPDhe4eDwAzvhCSMAZiDYiFeBh9pDcdRIg7NypGM+KX0VszQdhHYySYd6eEcG1Z
         OINfH1qaBwH//DGo/Iu0zR7TAb0agO9zHoI/fWIKl1ENkwWUNbNM+QWYSYCfBX5I2kED
         N0kAuGZDKdjJKlKJd/6dcB52P821NNF/G6QCnhmYmSJc0YZr5ogiC4/cAdgHswGPt5HR
         y1dJ0mm0oJgfo5XwX4Fvik1KQ8C8N+ccPN80/aSolAPNF2is53Qqx7X5aOpWu3aRyE1q
         RCQg==
X-Forwarded-Encrypted: i=1; AKwUvBxkr8JF3TrogDzxkPoKWVF4zOs4cb+5cT9CCex250RAdIjaPIvie7PfLjsuQ6rcX21AbE/VK1ekPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z95qp/Jc9dkgh4WFIRR6sge3TMPux95zNIobGC7u6YqonYRmGCj
	ZPn5e+PSBrYvsJUSKnL+F8JXQ4dTHxy7+gt4YELaqqzYxyJ+Eu4eFUrL
X-Gm-Gg: AYBFou0vpQj3H5sQngyWIuAuRGl8g1YBb+tA411r9bBudQCKqYDCWJN1b9SIRMDk1V9
	/iogd3Zl+hPEALUdTH6zWQXmt3aG/Wkj2lL5GkLaYBr5uaxHhlOsI0LjmUm74ouBFnyBSbZ69H4
	FiLD2HonvcabZHE3aiLYUjPeGHohK53XEPHX7LifOlVF9JITh5YJCSJbLZOoOO0pgCeoedJewXl
	kWHuq9qTRI3OcnKA38vhQe0wNdX3yNKbmZQruimQ+cxLBd13i/mD6w9l4D+ZdRA26ILzO+xWBw1
	5nzpmHkhHO6cGk33YfDl5fR22SMwa/Z1q0nkAnokEvZXXgDPfQgZkJgaz/vhbgTQJRDKIaqxs7/
	AGOe9RzP5SlAuFEznnY0oO5cZ3kR5/6K8lsCpiMzBEqWdQ6HVMXPaTVg9ox224F826+1/UZoz29
	rNbWg+cRB4+5AjxnZtHcULG1zwT0ZJzJT8htK1HtnaTJhuPQQNCONByl24EW3+Ib9bCcSs9mZ0z
	xowCoCfUTw+n7feffPxbafivYwvkfMjafSH+ansViCYXISVSpT59M6p+Go2YOiqqCi3LWpwNx5i
	yenA9uAwhPP3Avt0jG6F
X-Received: by 2002:a05:600c:470a:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4ac16acfe61mr380977515e9.5.1793830002799;
        Wed, 04 Nov 2026 14:06:42 -0800 (PST)
Received: from fedora ([2.35.201.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56fca22f4sm24879935e9.13.2026.11.04.14.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:06:41 -0800 (PST)
From: Francesco Nigro <nigro.fra@gmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms behind another task on the preferred CPU while allowed CPUs are idle
Date: Wed,  4 Nov 2026 23:06:22 +0100
Message-ID: <20261104220622.3542344-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <32db09358aecb92c55c8c1295fa71b6a73306999.camel@gmx.de>
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <25edb6cd36cb77b82b40826b97232438f1443516.camel@gmx.de> <20261103233352.2282883-1-nigro.fra@gmail.com> <32db09358aecb92c55c8c1295fa71b6a73306999.camel@gmx.de>
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

On Wed, 2026-11-04 at 04:13 +0100, Mike Galbraith wrote:
> In your specific case, dunno.  In general, absolutely.

I checked with boost on too, on the same box and kernel. I ran
asym_min and tbench on CPUs 4-7, without SMT siblings, with clocks
pinned and boost off, and with boost on and the full frequency
range, DELAY_DEQUEUE on.

With boost on, 0.82-1.09 % of asym_min wakeups per run waited at
least 0.5 ms with ITMT on, and none with ITMT off.

tbench throughput was the same with ITMT on or off in every setting
(within 1 %), and so was the busy CPUs' clock (within 0.2 %).
According to these new runs, with boost on ITMT gives no throughput
advantage and still causes the long stalls.

As a side note, I agree about DELAY_DEQUEUE: disabling it reduced
tbench throughput at full load, with ITMT on or off.

Scripts and raw output:
https://github.com/franz1981/itmt-delay-dequeue-repro/tree/1400f15

Tool use as in the report.

Thanks,
Franz
