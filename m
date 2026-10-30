Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380761;
	b=1v2/Sy+FCHKOe4l960tVI1zqXaOLqe0z+9oYH/zjmaPXhH7i2K1n3pqkNCHRNLP2gw0j
	 MX0snJC+sxWly2dyhR4nhRXT7p2tBITs/Z63hvmmX/meogR5XoZpgxwyeGkB3CZBOwtiw
	 553K709juWFDc8phoubzJwHjtl3+D8qGOV88+LoqB9BNNwHqbsLaglp0kJAcm7YHLlcea
	 AFIWpZWM6XO37MNXII1YH91CvnZk1IyX2mrovyOTs6qr1/wD15CIEc/igNDyQFGny1abS
	 GHK4//KKdTLfu8M1OU1I8hnYGIPST95SHXNSj1BMAAWlJxGw5yo9D9bGMCOOxRRoATA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xNCuizie4/rA3iBJi7WKXbiS7VvUpnFkAzErMyUnySM=;
	b=Q5XQXSQ+soQpz/Z4bAW68/FbfuRqoluUpNYJuujcCBnK5KJWXIu+mMbJgiFEZjd0bbHQ
	 /jAEA7Zi9WKZXpgI4/FaBBPVRFysChJaToRHQo1NI3E3UCjvopcgXPf7WRGnfdAEzEgK3
	 k2pIi+NpAWVHqQgNolYSkzeiGbBio3W3xFfKaLp9JtLS31orsd+IOFtRcQy2GFYNkGOCf
	 6i0U5JBTND9+AHgZcG10iLTpAEXBkQsJd0lyIdd9hH7FMV3ssIXv6p2u/pQhf+mZ8u4L7
	 nd7mOa83wtcBpuK9qWZWxYEQTXvZQTCGxgsGB0uHg4WZyiAbkxvLf7s1wtCFTOeF5tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Z33qYUXG;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C01606A31D
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 17:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C01606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Z33qYUXG
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6610595e9.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1793380759; x=1793985559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xNCuizie4/rA3iBJi7WKXbiS7VvUpnFkAzErMyUnySM=;
        b=Z33qYUXG5DyX3rqCy3fsjys7dNbph6Tlrn0KcQHI8PrZQwrbPfRATYczfGDPZZ9ObU
         C2R31LAtSBTQTtFeYwIGk8dhgv/v9SiMmXeVN/79cd6yvmyD/wuDGu8VBhdqyN/yq6cm
         djDHZs8kWTn4cW952RtXzYp63D2usjcwtD/go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380759; x=1793985559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNCuizie4/rA3iBJi7WKXbiS7VvUpnFkAzErMyUnySM=;
        b=VijV0WUmb1Sm7XkJ47Jszt+HdEtesmeKTGD0WZSUPWZyrKWErtOZJF8KoAnFbfCxEt
         5wirFcTu72jHc2+35VRrcVfwAdRIzVgBczUul5V6Nyl9mHL0NKfutnN8eb9qnzUiC5Io
         Cn9OYkHEDsAinESnGLFnJWvWkfQpTW5gbwxog11zCioWkHSwiqHH2BdwmxVk+b9MVxSb
         zOVLwgYEoZ6KQlhUZ4dc8IJqJxmEbnlilegymXRfidi+ekor++MgqlGWZIQ2GcXLpMxN
         S5bMwCgGWBbZipsnfuC01t8sST1ztZiJxfsQu7rEgEgsMRb6AB5Y75SrRFccAf08hwPD
         9Cpg==
X-Forwarded-Encrypted: i=1; AKwUvBxk9YEMdkMjafUwihdHDQ4gx3P2/IXhRSrzDe8S/hx3zPr3SjMx3CEit+c0UFwyt14uuttcR+Sa3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYICweFFgkcHRfFdDGBRaoCB/JxY3GSu3hirxkzMwiqGzpTcXcbv
	CaFqxLHe8BfX3/KpeGW+n9JEe1+MqK4bheg5GabS0F8imdvUi8KTZRdRh0jgzdmIZm4=
X-Gm-Gg: AYBFou1hj8HzpPqKfboqe9Xa83KHUwZfu0ScgkqU72lNrS4OrkPavQd6i5RI+RW2Z/N
	0fJDVy9yMHlG+hyFui6/CWXw4ZSbOs0ZFQzJlcVltYkjdKrwrxVKi++wjEtCObj0sxWWFkoEpl6
	JRObIFMETkKNvkOUvS/kjRvTWdQicOrTd/PbWlkjo2LxyIE/gDPpkvTWol9ZUytWDdBYaLXvrL/
	ZTKzabvcE75LnYI8W2LIhaSdptx/kT7aLlpRUlOVMOu7BRJOtmhwVV5vNqXiEj93XXV4zJNX4jh
	agPxheVg7Hf/hMtd5vp2Eyq40H1QXIBlchnnHsnGblgCngmGP3KoZqEjf55KzcplWSZPXDQ6qD7
	0vkZgsQCW7r6Coqv5Nt7bqWfD75KyAumDscjfwJVk1QzBbvRKIyvRRS/OpuB+gwHG+xS5wPcQ1L
	V7TyuRnZ8HAwmktzgprKqLiVDd2pK5d6u33NVa+oKV0eUNIl96ChbO6fHUM6hskbze5Fga5vCry
	WygmZpZantIB88l1j5pQE/QpOC0IEh5wYjp8026pGpYRpBZzHOABnSUZZgiKxzeSv+i6CdgotYv
	3v4T1mOflebh66C0WYlHXmiHREmjSkwjua2ZmeRBO4FIZXSBe9G/n52W3WiLjhWv145C8GqRwkI
	0MqZqZEzcoWgKRwwa7KmOHfvdrS4M79+Mu4e4+dVW0W0BYa5OFln0RQqNgSs9pCnvoljG1WYcaL
	TcvXeFqRiRfDNj8s74byVnAq1OhQ==
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4ac150b38dbmr70600135e9.1.1793380759329;
        Fri, 30 Oct 2026 10:19:19 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf368bff7sm74252355e9.2.2026.10.30.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:19:18 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: dario.binacchi@amarulasolutions.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pm@vger.kernel.org,
	coresight@lists.linaro.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [REGRESSION] cpuidle: psci: boot stall/hang on i.MX8MP
Date: Fri, 30 Oct 2026 18:19:09 +0100
Message-ID: <20261030171910.2822677-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Hi Ulf,

on an i.MX8M Plus Dual board (Engicam i.Core MX8M Plus), mainline
c339f4010dea sometimes stalls for ~0.9 s at boot, or hangs until the
watchdog resets the board, right after:

  [    0.806123] ledtrig-cpu: registered to indicate activity on CPUs

On a good boot the next message comes ~11 ms later.

About 1 boot out of 3 stalls or hangs. With cpuidle.off=1, or
with commit 65705b18162b ("cpuidle: psci: Move initialization a bit
earlier in the boot sequence") reverted, 10 out of 10 boots are fine.

I haven't dug into it much. The stall seems to be in
pl330_driver_init(), so my guess is that it is related to the AMBA bus
reading the ID registers of the CoreSight ETMs while a CPU is already
in cpu_pd_wait, but I may well be wrong.

Any idea?

#regzbot introduced: 65705b18162b

Thanks,
Dario
