Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163272;
	b=XGFFSHUDE/RmEgA3hNaYfGvpZjyxi+olVguoAvJCO08UjSkndrGKWBRoVCKc0R8Smm+Z
	 vD7o0JOHt+gPqsyq91DTNAo9oJh2zK2G2qnUUY/6q/lP45OH5HzqhIrnwOGEiPJpxYKRJ
	 meqCYASoMbAjOJlok5x5hzJNetmPPg13GrLaezTwTgup8chLuDHXafM4hCFfOjhX11HV6
	 Sqzf2Z1hJGIbIlS+PRkIz2JgY3ibjiJTNU+hb14dOvM4Nm1+XnFiDwnkGSvLswFxsz2wC
	 jIIZmA8Xx5orZ2UJIqDXf+1/fn9KRQszQ8G0C9Dcu5tUMWZQJydiCHY4bXLPABiJ99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163272;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=9EVz50obAhjsYPeTDicab+zb3sNmelcAO2oj1dxcUDE=;
	b=oyOTxynJ/U/36ZjNrk/R5fluLmkGS81qOjzTWPYBB/W7H3Fs4h0FXLokPc/S9JRbh5z8
	 m59Gr3rpo7RlZHpT8ZAJVSp7fHljkUGXPw5bIiDGvG1e52nIZIp91w9mNW7LRZs6DA2iC
	 7W/e42nr9YIXyehPwLCtck7pOsa/Ajvqk2IM2YTHD4ViAa/fbvnxHznSeoMGS2fZbh7Si
	 TC71cwMwwm7grTKhyH/VXK2tPM2BW/bryJiCJNA5RJBoSAc2f2lH8lkfVNhf/qc/j+CDx
	 HA344OVNh5B6Cva0vMsAIRd1twdbZFqeOaJUWZblTj/LLVsBHjFqlu6s3G4OGyFhDrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cTEyU2TD;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C197606A320;
	Fri, 20 Nov 2026 08:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C197606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=cTEyU2TD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1C4694E41684;
	Fri, 20 Nov 2026 08:27:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCB226017D;
	Fri, 20 Nov 2026 08:27:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5828B11BC0FCE;
	Fri, 20 Nov 2026 09:27:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795163269; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9EVz50obAhjsYPeTDicab+zb3sNmelcAO2oj1dxcUDE=;
	b=cTEyU2TDlVbsaA3wIhmbgcZhWApax+ThYFh5jkqWEeHG9F1D3JSnc0D+GrthqfMIqdG9Y4
	86OtrjBvHcNFWWwRfB0IakXx0nTFC+4n80CKVEX3+sdcLl29G0srYBG3in+x9EotN9KMep
	A1HRt4f5XLRpvwlmHr3U8ACPBlcEdZN7pto3OprQ2Bbxs8BKJnW1qPW0hSYVQE5zYDES2n
	LDpDIaYGd8Iv2H00xLD8jnntKYc5x8IpVAhjmKS1BTSkHRbf2eB86l+KqQCHEspgP2F3a3
	yPTEkiQAEiS5LOBFWa17pHevhEhzsgF+3ccbiBZp4cIvRNQy43pMxhpe3rcrLA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,  Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>,  Lukasz
 Luba <lukasz.luba@arm.com>,  Eduardo Valentin <edubezval@gmail.com>,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thermal/drivers/armada: request the overheat IRQ
 before enabling the source
In-Reply-To: <20261120042728.420697-1-shunsheng1218@gmail.com> (Yaohan Li's
	message of "Fri, 20 Nov 2026 12:27:28 +0800")
References: <87o6bldqjo.fsf@bootlin.com>
	<20261120042728.420697-1-shunsheng1218@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 09:27:46 +0100
Message-ID: <87o6bjc3gd.fsf@bootlin.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 12:27:28 +08, Yaohan Li <shunsheng1218@gmail.com> wrote:

> armada_thermal_probe() requests the overheat interrupt before it registers
> the thermal zones.  Devres releases resources in the reverse order, so the
> zones are unregistered first and the interrupt is freed afterwards: a
> handler that is still running, or that fires in the window between the
> two, passes a zone that has already been destroyed to
> thermal_zone_device_update().
>
> Request the interrupt after the zone loop instead.  The handler is then
> freed before the zones it updates, and the interrupt is only requested
> when a critical trip point was found, which is the only case in which the
> driver has an overheat source to enable.
>
> The interrupt stays optional, as before: apart from -EPROBE_DEFER, an
> unavailable or invalid IRQ number does not fail the probe, it only leaves
> the device without overheat interrupt handling.
>
> The source has to be enabled after the handler is registered, so
> armada_configure_overheat_int() only programs the thresholds now and
> armada_thermal_probe() enables the source once the request has succeeded.
> A failed request then cannot leave an interrupt enabled that nobody
> handles.
>
> The zones are now registered while the source is still masked, so the
> driver masks it at probe time on the variants that describe the overheat
> interrupt as a DFX cause: a firmware that left it enabled would otherwise
> raise an interrupt that nobody handles until the request below.  The mask
> is released when the request succeeds.
>
> ->remove() masks the source and sets a shutdown flag so that the poll loop
> gives up instead of keeping the removal blocked until the sensor cools
> down.
>
> Fixes: 879d7362d1d0 ("thermal: armada: add overheat interrupt support")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
