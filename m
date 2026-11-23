Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400515;
	b=KYKvUn1te4C5z2IAvwcqPEpcyjvsSCAjwSM+S7T8gE68M0vwgw9sXIbdvBBIrve/r0Ga
	 +nZ+QSBn7tqU7qD5/aD29Z/Rjl42iIT5b/qV1tTBSFh9u6IIhhJif357Ia1Fs3qqwHei8
	 QMpa0gXVoR+iHb+TuZ5phkrVnklA7e5PlRIqufX9ohl3izlPxC/AWdpbVeSZ+T5gggr0O
	 PNzOtaF1207t51MRHVjcsPZz5cCuIW7EG3eayWgJUdnRZgTL8z2AKh3SVHU7Umpx4z9rI
	 dS4W1qdvpu7BKmnda3mXFq9iq1IevXBUHwhkcXFpR7vX+Nnu5gQnnHpQZPuqQxWM4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=qIzih0fB8OsJOrwE3j+2DEEIY6AuLHwswwUsz0vhlXY=;
	b=MHLAIxz5ORavUnqZw57Jsj1OJjZTz/Sb9p52wbceuS2sirR8cRU29EPYukWAbFJx/RjO
	 Phd8h3wVTIJprhnNZHjontzic7cmwmNPCF/+JeeXE0j2duJJ9R37r3RRhDMEyfEAY6MJb
	 lluA462mh8Lh7C6Ppc7XftaWGNv9k9MWx4vzMWyfUq28Ju8vjRiGIT+1mISW5ePTvO8dv
	 jQ3q5PfVL72DSgP2SNaklBHM2V6RnuU36JaHazo9lmq+t7kVbIySPHRGahoyDpQnH/0K/
	 pZ2g9PwWJlnhWYtOeiz3a+Npr2lQ/Mm71cFrnCq7JWGryLAREGjigRdngDBclpjJWAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJX1ACZT;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F62606A320
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F62606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJX1ACZT
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so1312745b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 18:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400515; x=1796005315; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIzih0fB8OsJOrwE3j+2DEEIY6AuLHwswwUsz0vhlXY=;
        b=yJX1ACZTcjUxpbbTP++wMkoJseMfzO51Y+2EPD5i307atFEoeY/ALtI5UbP0KOCvb5
         all9+T7MQYo++0GGm/j9jYIuoNUMZsZu7J+Cbi1HRruaCWSH1uWeAxgwE2kXCX42DjTm
         sJQMtG3zMYp8fJbvjKhAUcYJHP3g7p4anaE3jcfrfhIcIiUMqlkjsm13w/6cJqBc5rdB
         Z4iu1gl7pxdlH9ybYhwDLjErhpuKjpwsHCX0BKSyirhHcKA0+DDe0DeXXW9AMEDiKP2Z
         SKaHqIb0ysTbPlChu4o0ia4wsBAYk4cblIAw2RDRwdnqKjz554z4+H1JqcAOBhhOLwOG
         4n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400515; x=1796005315;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIzih0fB8OsJOrwE3j+2DEEIY6AuLHwswwUsz0vhlXY=;
        b=rmwhfZx7k8pSLUjfSoFbONCuBr6MZi921rfzyPfdNaR3qWLYsk2Zk9yGLtpG5k8oPZ
         hZDOSVEWOcU2vvMDIya3M9mg1gM44VNFekiKRcXc9kcOh7oVGfphUtgWCfnzZdqO6q7C
         MiGfIe/cgpv+ah/gEPLm8RBMWpQdBdfz6OPrnt97x8f4zCaYtSBaTR5oaq9bwx9hVV7D
         +GNyNXY0Af6gHv/VKiVTlA4tTs16HgZoNCUo3T2dqGiOVKN0QFo8eKy2uiTFlqjhvP7b
         z5zrLBi8Opt0NxaHuRi30rCQuOeTD5gWCINHztNEMh8+WOZy62LBs3Q2wV7WY8f7v7bj
         rMZQ==
X-Forwarded-Encrypted: i=1; AL+hErEUXQuUqW5eCm3YIKZbtPEzNRNeaUJXTDwKtpoURetk44w0fTtEB1IyWaTB2qLsH8jHa592mM5aZw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8RZIH7tIcHk4VjDKyT79yCrxFCYHp7ds8+6unbUWwfD4RiWnhy
	dEG1MpXU6tlr14mG311lkvvC7HfZtNNx/3Uyf3WbxkmEXDf4V5EJxN54
X-Gm-Gg: AZFdTZdrNPjecmzmwkuKGs4cxy/gHCNdPiyVp1cCLGuqvhSiuDQtfSImB2bg7TicFBK
	bR4v82G+zZuKzihDq/6/pRAXAk6tVGX6nrNiLsqTXAV4VifsnwYpxxhyOtLPNRUGyGJTAz4nh96
	Z8dOLtYXl2pupNF+wcndN7ee35akdGBd9KqgjI6YoufpSOPGZcyXBY0GBWMgIT1lHnNo9LmzoAl
	616ylt2dovz3FQJfRHWEl7S1n3CzaV/Ps2KXmTIhA/7pvK4mwd9PP3bpL+WZRLf/+s/L0tbi+Dl
	YOw4VroYULo05e5Gaf6Yr36WZ901Z4rA1fHNKb8SW5MDjw1yCl35tZwbeu79ZgWhOp0upVLi4kR
	tzMPQ1+ntJIHq9NStaqbfp0e5s95FI7Mi98PEmmuEfEqaccq+vk/NUZqVDnsd+KugnxIvtjQ8QW
	Ihc+4EVCKie7LofzxHqRoEWshf0CgBb+a+yb0K7erXGZCpUrdTjMcvUbEXcXsPUvKKj2Nb5FbSl
	CWNG9FHP5IpZz286ndOcTSXJNkvSLtrV23fn6rIRCk0s6HngGy6OLSFU327X5GC8luNL3nSfCVo
	pSzhprORLnlJC+S65WGMqKYBrdtXJr1tYYJuNJsb8fSZkGRskD7qEZGif8LukhsrVjympCf7S5t
	D3lNEbZecLazVGShEV2gv0RfetSCnb9uzo2NrNNqZ8JcNig==
X-Received: by 2002:a05:6a00:2888:b0:89f:db59:193c with SMTP id d2e1a72fcca58-8c87bac50abmr8010706b3a.9.1795400514607;
        Sun, 22 Nov 2026 18:21:54 -0800 (PST)
Received: from [127.0.1.1] ([74.176.208.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm4674426b3a.31.2026.11.22.18.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:21:54 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Rafael J. Wysocki <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3: release the IRQ handlers before
 the zones are freed
Date: Mon, 23 Nov 2026 10:21:46 +0800
Message-ID: <179540050658.417371.217605576878858750@gmail.com>
In-Reply-To: <20261122144813.GB3898744@ragnatech.se>
References: <20261117145348.1092528-1-shunsheng1218@gmail.com>
 <20261119022926.1493582-1-shunsheng1218@gmail.com>
 <20261122144813.GB3898744@ragnatech.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Niklas,

The explicit devm_free_irq() calls are needed because of the current devres
registration order. rcar_gen3_thermal_request_irqs() runs before the loop
that calls devm_thermal_of_zone_register(). On teardown, devres therefore
unregisters the zones before freeing the IRQ handlers. During that interval,
rcar_gen3_thermal_irq() can still call thermal_zone_device_update() through
tsc->zone, which is not cleared when the zone is unregistered.

Masking the source and freeing the IRQs in ->remove() closes that window;
free_irq() also waits for a threaded handler that is already running.

Requesting the IRQs after the zones would make the automatic release order
correct. But probe currently uses the return value of
rcar_gen3_thermal_request_irqs() to select priv->ops.set_trips before zone
registration, and rcar_gen3_thermal_init() enables the source depending on
that callback. Reordering would therefore need changes to probe setup and
failure handling, rather than just moving one call. I kept this revision
focused on teardown.

I have shortened the two comments as suggested. I will hold off on v3 until
we have agreed on the approach.

Thanks,
Yaohan
