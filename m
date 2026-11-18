Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994200;
	b=iS7znJFwSvj6khw3LgjDE8JKYKFToqWN2GTCIRLpvdRkcld1SyCBXXu7RfAef8oTf5Ye
	 VmVvdGZzsA+1i3N6drBmN9Fs7mHss/Dv79uS+Waf8ggsa3F049l/LRKg4sl7P4c+g/NI5
	 WcxAvCzbcg5w7zXn6rD57aY8lzQd9Z5cZZftTyKemeo1GzwBf1H0M3ewJSxvm5hj5rd7J
	 1tHKieHFmirNawwXjpVxIsPcTnfKZZBvMD6LVsXZs9Z0gWVZ14mkwz2yq4XJbbyM6Q2wZ
	 n/QCzarkDA/uCrrrJj40tIsiI423BxzPiJxmYhHlBU2cvUpgPxwrNfCKeD0AvDpb/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994200;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=voptK8eT+WsHOSo6pPGL3uudEvaomLPBqr7xSbzHqQQ=;
	b=Of4XzWWV9EcknVeVh3oizJfszw+LLqGC6mSup/oBTKNXAbLxQzmkZi/15Gq4k+F2h9vP
	 oeDjXrd+q/1mrPliknRMnp0BMKTCV7wEZL8Grp46hfTJZe5rmoQ+EdQlvEILtR9NPIWnI
	 ZEyLm3TwonBdjm2NWGF9ZwVR0NnLEANOP9aPd7TZljG7VnL5oBcQqQqFy50XMIM2aaegs
	 4CLllogsKqj6bzu6mZeaVJSpJSCUho49UC0bRVq9q2SzNt8AHSXCjsJWzHpKI5AqsyPJD
	 0ZO2G+91/9JuYAZZq2BDW3Iuz1JuPtMuDZMOhQp26kfCDyyvFeknHasFUiwBVDVxaYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="K/kCWAmA";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A78606A320
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 09:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A78606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K/kCWAmA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0E5D61A16A7;
	Wed, 18 Nov 2026 09:29:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCC355FE9B;
	Wed, 18 Nov 2026 09:29:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FD9011BC0D09;
	Wed, 18 Nov 2026 10:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794994197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=voptK8eT+WsHOSo6pPGL3uudEvaomLPBqr7xSbzHqQQ=;
	b=K/kCWAmAi5/EAT9d0c7bVZS4fvoWoMIOM11w4Djgw4sCdjz90Jb4IDEf+jwv6+XU+8voc+
	JcHIxWdL+RWUxSAkbmMjBNqPVZDQ/vT8fqTt8ANikMzGJIkeKiFCeK9yMZJByJgaz4dx16
	g/AXBEnk849LmR/iC2LR/0tMAkX2zC7vKh94FIK1WkiRRM3fjSFgrW+s5YpcO9ZN+I/Ba5
	v6CpKaKD86pBeZ8y8ThA7dqD1j4/RDEVem1dA+r4Q3DXB9tzxFUxj6Z/h950ySVy/wdC5A
	CQSC/v89vQb57dDi4kztGXBxA8hnmX5kIEuGSFxCM2+eMFNMB1/EM8CgqJIOyg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org,  daniel.lezcano@kernel.org,  rui.zhang@intel.com,
  lukasz.luba@arm.com,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  edubezval@gmail.com
Subject: Re: [PATCH] thermal/drivers/armada: free the overheat IRQ before
 the zones are gone
In-Reply-To: <20261118072339.1259719-1-shunsheng1218@gmail.com> (Yaohan Li's
	message of "Wed, 18 Nov 2026 15:23:39 +0800")
References: <20261118072339.1259719-1-shunsheng1218@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 18 Nov 2026 10:29:54 +0100
Message-ID: <87ld6qjxm5.fsf@bootlin.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 18/11/2026 at 15:23:39 +08, Yaohan Li <shunsheng1218@gmail.com> wrote:

> The overheat interrupt is requested before the thermal zones are
> registered, so devres releases the zones first and the interrupt
> afterwards.  armada_overheat_isr_thread() calls
> thermal_zone_device_update() on priv->overheat_sensor, which by then has
> been unregistered and freed, and thermal_zone_device_update() locks the
> zone mutex unconditionally.
>
> The handler also polls the sensor once per second until the temperature
> drops below the threshold.  If that poll is still running when the
> device goes away, free_irq() waits for it and the removal is blocked for
> as long as the sensor stays hot.
>
> The same handler runs while priv->overheat_sensor is still NULL, because
> the interrupt is requested before the zones exist and a spurious
> interrupt in that window passes a NULL zone to
> thermal_zone_device_update().
>
> Move the teardown into armada_thermal_quiesce_irq(), which disables the
> interrupt, frees it and tells the poll loop to give up, and call it from
> ->remove().  The same helper is called from the probe rollback once the
> interrupt has been requested: the driver core does not run ->remove()
> for a probe that fails, while devres still frees the zones and the
> private data of an interface whose handler is registered.
>
> Read the zone once at the top of the thread and bail out when it is not
> published yet or the driver is shutting down, and reuse that pointer for
> both thermal_zone_device_update() calls.
>
> Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Your solution is over-engineered. For a case simple like that, you would
need to just move the IRQ registration (not the get_irq()) after the
zones registration.

Maybe you need a shutdown boolean as well, but clearly not all the extra
complexity you are trying to add.

Thanks,
Miqu=C3=A8l
