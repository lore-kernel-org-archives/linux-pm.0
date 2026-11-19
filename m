Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105522;
	b=KngliKR2UtfAWbG3uyCV7hBMWueEKcJSZgbACY4J8qjKqvMnlE8dxB1STaW1845qkjth
	 1pbPPzJcczfSTPeAA1oWVgAR+5uTNka+lBle7sD5S+yZmdhfpaYa2JvD2Blj9jb5O4QT8
	 EmCYcFaD74+QltYRaHlUg81N0ZoCKfW5P19JVlAtOpzQu6Pktmkl0nj9notdKCa2WyTU1
	 71YwCaSPqd+buAFDGQPZDjTdhd9QIKqBBQnwSh7v5o696ID436BTXFbDO2IglB48b/rMu
	 zsNWzXrYXHY6Kj1+bcH9J6gB0mqZUThRiPp/yGoksG3kmHye/9nb5ZI+j0w7N22YPmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105522;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=gfp4rLgPDU9xrXi30in7XLHuCQXVvs2qLK4OaDXqTDg=;
	b=BOy/U1I/2KYcHxnkbXLQpPbSxJ2WOZwf8oUw2HCGl9esOsUtRy2eSl2Smuq3GR5rggkO
	 YSGbp0YJ7kf55dbeGsZitjg/0kcr2SaLr9+VDpDTHGs2IMKVhvdpyREU1k1CNK262Yk3C
	 HZLiyC5mN7iUThuO0akmFEP28dbZYifuuS5aP4m2uN0y6nT4MBBefR4K7JikmvpX7YsfU
	 Plo/33zCnTmKN93ICoq8G0KCv9Kl1luiVzMT22udU2BscAP+SpU9ZOIxypFdq7ABPnmOG
	 KqF6GJFrLBoJNNenYBVupETvGiDNQtKzhQP+e9ewybrUn5X2HXe2d7DirVuQFh/5C4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=H+AUFgBw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PUOYyAoH;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12927606CA2A
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12927606CA2A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=H+AUFgBw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PUOYyAoH
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 00133EC0956
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:25:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 19 Nov 2026 11:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795105520;
	 x=1795191920; bh=gfp4rLgPDU9xrXi30in7XLHuCQXVvs2qLK4OaDXqTDg=; b=
	H+AUFgBwSH3S7IdLDX0FTp/AgngSAlROS+5TED1eiau0K65RnV344LZFZ52yayb5
	fqo5AcXsJ2adTT6YFt1iO3CDSVkQrYYyrOiG71JH/Jtynyf/srMFCdD8f5ildlgQ
	eywLJsD3fHa7mv/gUOy/RnfQHMcaQPQ1TBo7cAcoliiTtB0TddCPHvtwQ+jvNokm
	lMPdvSaeXaJt4+71YSzO2Nl0IIHpcVVVQHey/3Cah7X9jzvu54K7vWHDqkyFMpNi
	kRxkWrM0nyJiMS0zHPW3DxydoVHoC8ePVSwzpIGJsEeRKtmObhs7dTwJNIgs/xix
	k1TM2tgViReuTSH3L1m6fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795105520; x=
	1795191920; bh=gfp4rLgPDU9xrXi30in7XLHuCQXVvs2qLK4OaDXqTDg=; b=P
	UOYyAoHB+7PLo/0CqQkBy9ehi3Xn8hK5Bcc1o56YshKAaWCgDGjOBXIPwv3PuS3L
	C7EFC8MRa4KRmeMzhLyRi8pZgY9Y0kN0rklGowor8KWIKCLkhz56SdLkhnYgdSe8
	n63ko2zdlBVW9pK4MsN2QaKMhMEZErWq48LsZK0JeCFXBWaaWvjelg0hs9ztQNBp
	xHKZ7RNf9kwAnAkBxOHc8wTi0kod38jMs0CKtbG4ml/vHA+98oYpUjm1JU/2Xgln
	fJC//RfUvaHNN0021wJwzs/N/kznu01/3rfDmj3RHoVO7WoebAtTtltTaLGzpuuV
	0UyTTZzTD7EWnbnrkDAGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795105520; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:OLDrqqiXizrv1KUIUyd9QPy/E7CF4AmvHzlJ8aHkxQ2++uA
	kxm+W7eHQp6PK09ZKFillewnRslzwJsjuOrGaoGDDttnB2LX4pJFZJAMRUFUAItD
	mWto3qb78/79rzyxTMDzK3cbayCV+m+PUfvA2O0sKN7z5VIAPS3/R1lP+ogvmXrb
	zPdHkgF1RIbWMQPvn0LaBm9VezPEkeQXf1dg6eYbEcCyc7BxP8idgkn1CgAv+iFQ
	NyPRIyetJ6lG3ttOze8ot1ZSdQ8UK6xdhdSED1mLCTA0oG9lzLjEJgs0xBLdoauk
	/vHx0thcr64608yvqWNwh6mwEQdoiMTKoqEj1jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wh65AxyCEGfJisw04BahunQyCMB7dnGs+wbCI8VGSow=:KhNqVQSDEXtcBHbf2f5TkuW2U2Bm5jlK6EqTiYoBN+Q=;
X-ME-Sender: <xms:8CL_aglUKmfbzezA4HyGB8mx1Xr8zHXCAz8iKHwvpwuH9VCHijcBTg>
    <xme:8CL_aruwtjF265fwI0wMedNP2dWzV50TkkT8zCK0xkGvjMLY00FV-MvEzq7DnIkFm
    sZszUEqTVZpvNhjwwLjFpA22gWjWOKFxJM6_GBg5eY2qWOlQ3vbz7xW>
X-ME-Received: <xmr:8CL_arpcwDMql4cpvQxG3Nea2eLCExtOiQKzueEel4XsngUesqWXXNAMie0w_TJgrNHkKAUTm-VXTutrTm0reWPXXD4BNXU>
X-ME-Proxy-Cause: dmFkZTGleqIvb3Ms7+F/oKhrfcU0ejd0oWtxpIQbVHQmcSDjYmbghqUUzoIptLr5MoGJ+/
    vlvXr5VimGZ7E2QQex9UB3w3s4YeQ879Dc+9Pw8TG+P5ZwZwqNC02KJ/jrIp1CkVSKUM4S
    X0frEs1/jpJ6ttBj4RzsHQf6ouGQzt3zni3opSPXmKlCdO58RQfTW3r10zRxq7l3HRQQvS
    fJdY10r8THaDvrZ/JtB3BCKROEGbZvw97P1ncERFPlOBtBbPE1Rf1XBlY979Vdk2XGrK0D
    jYeAIhuk1QwFCM/PLFZ6NgzpuV09VKeqzUl7hcNPhN2Z7Oq/Zt4932i8zySDdm9Nu1JppX
    77EE9JYQ/q96+nxkB6ISI6haCZJXzdMKYpbo42h9CZUD9a0Huvm8LNFxennc/oxDNzy+pD
    b/xgilwoC/iyZ4ELZwY6VzrXwfwg05TUGFFPnSyZMsV8b4Ue7Eh2LpmapTkq0bQRJbFi6d
    pgIQmRgZ8u0+OM9+SQBbQJD/IswdThTZQPxp5NRO30dB1SmmgWI0ygs1sTX926sxa3b+Za
    gdRHRGuHjbnBzteORWy8OP5mgu/Sdvu8teNkQIwjtRXSoqDb6l010qX3RVbyS5Jhzk8mEI
    Fs2iaWV7yIY5UrfQA96zTUklRfmROGKRcOTzhA6oWni8OMK2QPSakh+ASM/A
X-ME-Proxy: <xmx:8CL_ahcC4GCBaLc4nqu4Zs39YnRh7iFnXFo67fUAgsIaOUfSoDqN1g>
    <xmx:8CL_ajnHxihxNI4I4LHyAgbowpBo-FWfsRudykNqid7H96lnaMUHwA>
    <xmx:8CL_aoZG2jxypn8pgCP1Bfasuhj6bCOo_zBmgiikVynRh_nu3iAAXA>
    <xmx:8CL_ao4BX4Ib64Qghfr9K8Wk4usSp4lfxJ5a5XD3frQ1RsFxA9fopQ>
    <xmx:8CL_aiIuVFZ1FQVZcsibMq2v1ZcDmfbfXDmB8qpKo77M6vuPiwYuiMiJ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 11:25:19 -0500 (EST)
Date: Thu, 19 Nov 2026 17:25:17 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Message-ID: <20261119162517.GD2300348@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
 <179508711555.3615492.10674834361832600268@gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179508711555.3615492.10674834361832600268@gmail.com>

Hi Yaohan,

Thanks for your explanation.

On 2026-11-19 19:18:35 +0800, Yaohan Li wrote:
> Hi Niklas,
> 
> thanks for the review.  The code changes you asked for are in my tree, and I
> would like to check the testing question with you before posting a v3.
> 
> The delayed work is now disabled before the interrupt source is masked, so
> the handler cannot queue new work after the cancellation, and a work that is
> already running cannot re-enable the source behind the mask.  The shared
> interrupt is unregistered with devm_free_irq() rather than waited for with
> synchronize_irq(): the line stays registered for its other users, and they
> can raise it again after synchronize_irq() returns.  The RCAR_THERMAL_MAX_IRQ
> comment, the loop variable and the two comments in rcar_thermal_remove() are
> as you suggested, and the shutdown flag is gone.
> 
> On testing: there is no R-Car hardware here, so what I have is a controlled
> ordering test on a KASAN kernel, 17 checks, all passing.

Is it possible to share the test-cases? And are they relatively simple 
to run? I do have hardware to test on, and I would be happy to run some 
test and see stuff fail without this patch and that this work solves it.

> It uses the real
> delayed work, workqueue, wait and signal machinery and a simulated interrupt
> line shared by two handlers.  It shows that a work queued after
> cancel_delayed_work_sync() still runs while the same queue attempt after
> disable_delayed_work_sync() is rejected, that a running work undoes a mask
> written before the cancellation, and that after synchronize_irq() another
> user of the line can invoke our handler again while devm_free_irq() ends
> that.
> 
> What the test does not do is run rcar_thermal's own ->remove().  It
> re-implements the removal ordering, because exercising the driver would need
> a real platform device, MMIO and a thermal zone, so the behaviour of the
> interrupt status registers on real hardware remains unverified.
> 
> I can send the v3 with these changes if that is useful; if you would rather
> see a different shape for the removal sequence, I will rework that first.
> 
> Thanks,
> Yaohan

-- 
Kind Regards,
Niklas Söderlund
