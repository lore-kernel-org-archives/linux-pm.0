Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356553;
	b=dIT2WgUUeVy4XrmMrZF5bh1vLTQl8CK3oCl7aZxqK/uOlbxRKBqK3DaIAJKZ9W96Q/ug
	 415FgoYQxkDyIm3TSMOg+/LhWHmn7s+YufwW3Wr2FWgefU2dCOyMMAd+qZ8eLm+Gdy4TB
	 8sBoQzB9/YI6+7Vse0zfeD4flixpuHV6IDPu4UH4+h0JIIWF4jU1n48AHaDrDbFGpGa7e
	 3Uvj9xJwlxw34IYH7Vo2OLOY/gTH/7gA+BgJJbrFBxLM6Wo+RWALnAn4xugSjgIJLCFlr
	 FkvPLRB09vVlkIOPXWXUuaI/Q/viClrGdudmBgUvaYmRCnMnfdthX69JcTH/6PZwLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=SWWxER46zTj/3BX2HRutr4IQ7wsQb8IMS5bTO8V/C44=;
	b=mq34h28jsQTz8mB8+jEWP6nkmBEFAVRI4j7NOnlyShrFGbmG8CSEPtQ2lzaUbWnR+GsD
	 7ma1943gErnwcCOUNveeMcZVJ8w51OrXfPgUTAkFdrpUFCQMJAcIdMxmhRsxrLMeU/YRS
	 g+Rg4UlLX7XXjbHCH/h8XEqizdjVqtMuMoZpBK10ogmjsg66aAXWCKDkh1gHlWrpg4KZH
	 Lx6EcdBb2rr/Uob8ZH8dPEerH+C3IkTJUMb8NzKSLjzs5SEuIM8SlSz/pFdQXk7E2Y1V/
	 FR2IFQh8hxn+gIjYNYIfOGW2SKf6THczZC+O3yNl7zO5UrPEflwK6B6IWVspl+YG4Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Ic2VUowI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="HXF/f0Yx";
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA7606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 14:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BA7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Ic2VUowI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HXF/f0Yx
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AE761D0055C
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:09:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 22 Nov 2026 09:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795356550;
	 x=1795442950; bh=SWWxER46zTj/3BX2HRutr4IQ7wsQb8IMS5bTO8V/C44=; b=
	Ic2VUowIWGuhlZCM95IGfAfWxnCu+RxhpHNW4bnFSsliU9LngorNbFs0+e/XEs0b
	z+B2qslbvUbDBEUNVJ/6/pXsxgaHjmpQNrRYs41kqo/JU4AbwN647ksEAAuW88gt
	VRFpGZXTgMYsZkbiuBzXcxvx1ItD8Kb2yFdWxaUBIYmN+Apaxdm5t7g+Jw9kA77J
	OB1SK8bmdD5tDFK81wIrkvbzd//yeI61WbjL9AQMg1vlmw1blXHvCA3qYsLh0kkW
	i8G0S4pxGzkngcW65RLx0tNtrHyjODxZGeRUsHcIw8QZZTLYvZqmmWJoeiqDVvxJ
	OsgXDGkj2JuLoxNVfi8ndw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795356550; x=
	1795442950; bh=SWWxER46zTj/3BX2HRutr4IQ7wsQb8IMS5bTO8V/C44=; b=H
	XF/f0YxSOUAlIbhdO5sH8FyZdUmHNtQxDxf/RZcgy/kU8BdYODZ/9Y0EJ8ctitn8
	otruEZzswwN2TQ/NajPXS+KKJYNpFGZnrBKMD/4augrhbkRMp9+r4d2MIGFUJlsb
	E+xolsQiRexFCkBQxLWV/RM7c2bsVrioecBRm12XaM2YjApBGsYcId7+23rZHM5V
	SdxzlrE9uHDq6y4HABd8NdNQLjRwYvd9l0Uy0B+fgYusY/0RsG4IjpbqoyZOYMU9
	XLJv4xMPWv3+NT7QcdQkd8IXYouB/JH6f7nH1sTFWsWyb+/uotOKFdkTco69EN3X
	a+KCXKxDM2DpTsXPBnPDQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356550; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:FuGp/c7bJdb6iNctxMu/yyBBYb5PdX5lfm5nX6qxZ3VGzY8
	f9MpQCodLlsEFUC2UsouigwKDO/heerMjv+l+6+AZ95g6ik+iO7bnD7nCJaSrxFi
	zM/iuPgoKd/DqY2TrDUMfZU7foi7RBuGPKLrB8g43kL6BrFvwJtCkEiinjIPEY14
	FHFLnwxLIB2C6cZZQkjuLjZtxhbG15mIx7fnY8ghw5zalZ0Z+JT3eTd5mSfPL0jX
	vgfZleTzy3eMIc5VPB4PJWEgEr/V2mHwRDyKjpIgJ1g7DVl7n1FyVipMe1+GySlO
	DNRXt3NcZytYOI1fIdsjL2fCkN2M9D79bpx78aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0rWfSO76YmvkTUb6rnNDZwj0dTBwvW+K0MliB6Nu2eE=:WQ00nvpv4N5oJZA5uObGh+OWo0oajOg449bEjoNLE7U=;
X-ME-Sender: <xms:hfcCa1gPVR_o18EjJtQNEzFfxM36pPQkvoGKUH1d9dfRrgA1ZRun_Q>
    <xme:hfcCa3YB4ctM_7SDdfPRJreHztaHqOPh6mqD1vZ-x9a8em8iwB-keGQPhXO3bcd3V
    g3B7YnB24BAjiRjGDijTrpbyzo0QZr9OQQF2yroANKZAA7HHwA3Wsi6>
X-ME-Received: <xmr:hfcCa-mzV2UupSeP2whW3SULWgGbyu2uaJ8z5XA6VoOZWNUB8h8S3u5Y02wq_fD9d1HT8ph-qx8JYpwFyj6U4Iw7DdLKw2Q>
X-ME-Proxy-Cause: dmFkZTFdc541zvmeTqPU1wAnnxMDrX4RWRhgyy/YifpR2bR4ces83OFL8Zkwg0EzwyXA5E
    eonTlxiCUrHHF2/fx3L8czDKA6AlYSldZYX0Ggsof4pXk8DhDKBcQp/OHShqoBd23QSj7W
    g7HXMBGH42psh2P/ivJ1Uv5jIEnJXiJuiPnaysf+XWCQZ4A0SG7TvBGU2EDRav5B+7Vxfe
    0cyBAtjtkuff6c7vMEJT4qoQDZfNJ5KsrAyO83+V0oHKLixUnaqepujBtRmuBBTL6ZtuM5
    DHZEakDGUBnW7L6LivcT1RU2sy+VgxtaqFSnBhon0PMByXEEKKa+rQ8+JzM8DcniBfusV+
    jJmX+ptfNWpMB4gYYZ3KzCeGl55t5gzniEYaqGgVDBgsVBDJRfP4noHaX2p5XvJ/XaXKoc
    qvZ+kqWO1BL3xxyT7q9kVdY1JituF4jHe2CidQhmuWB5NP/Q18Ym5xO/rA2NKfq96dJLkr
    Fv9anh4tqkL8DaQ+cjmpYgcIZXPlLxT/aJrYO4BLkUxtMXWJgY1/u8ScDu9gvtxwaSfbQe
    1GmyzAeUbXUpVaQn1RqOjtY1ibfFxAVBbmzLKlLXawfr+N78/Nmw41lDLUj7NhSS74LslL
    2qlbrJwhS+1HKcI2dqPm16AbkOVeV2UVFmTGjK4dt/ZV5MxN+ePV4QYnmnDw
X-ME-Proxy: <xmx:hfcCa1iyQWSdvHFqmhHcDXvJ_WC0ExDqNBOtj582YgYA-iRJsDQFHw>
    <xmx:hfcCa4SFzNGEQ3nKDn2Z7-U-H21pY33gymtHfyv6G_gdYqyJkxnsPA>
    <xmx:hfcCa-a0B5kL5GO46W885PkdxDxBf7OWLvJAu5Rz_KczS_3DV351Lg>
    <xmx:hfcCa9R8u0MdeAA0QAvYI6E0fEa0GT2gFpTyZjnE7Buny-toSOepTA>
    <xmx:hvcCa-c6WfQyZejdyJTBaR1FlhLMLNYHZ1QhJghCOooC9R6EWHS7zyq3>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:09:09 -0500 (EST)
Date: Sun, 22 Nov 2026 15:09:06 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal/drivers/rcar_thermal: disable the work before
 masking the interrupt
Message-ID: <20261122140906.GA3898744@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
 <179508711555.3615492.10674834361832600268@gmail.com>
 <20261119162517.GD2300348@ragnatech.se>
 <20261120073021.GA3126029@ragnatech.se>
 <179516779969.759914.14349189301325900521@gmail.com>
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
In-Reply-To: <179516779969.759914.14349189301325900521@gmail.com>

Hi Yaohan,

On 2026-11-20 17:43:19 +0800, Yaohan Li wrote:
> Hi Niklas,
> 
> Thanks for offering to test this on Koelsch.

No worries. I was mostly offering to run a test, not create one ;-)

I know how to try and trigger it, my point was this is a very hard issue 
to trigger and was wondering if you had anything already which do so.  
Ideally I would like run a test see the old code fail and then apply 
this fix and see it solved.

Triggering an interrupt by modifying the temperature, be it with cpuburn 
or a hairdryer at the exact same time that the driver is being unbound 
seems extremely tricky too me. Even if the bind/unbind operation is put 
in a loop. And I though since you where fix lot of drivers you had 
something from a hardware setup you had access too.

> 
> I went through the Gen2 thermal driver again.  One detail worth clarifying is
> that rcar_thermal_update_temp() programs INTCTRL from the current ctemp and
> ctemp - 1, not from the critical trip in the device tree.
> 
> Gen2 reports the temperature in 5 C code steps.  That does not mean the
> physical temperature has to move a full 5 C to trigger an interrupt: it
> depends on how close the sensor sits to a comparator boundary when the window
> is programmed.
> 
> The handler masks the sensor source and schedules the work 300 ms later; the
> work updates the comparator and re-enables the interrupt.  So this path
> normally limits how often successive sensor events are handled.  Reading the
> zone also goes through the same function and reprograms the comparator, so I
> would avoid tight temperature polling while trying to observe interrupts.
> 
> For the first step I would check the e61f0000 entry in /proc/interrupts.  The
> line is shared and the handler reports it as handled either way, so the
> counter alone does not prove a thermal event.  The driver has a dev_dbg() in
> rcar_thermal_had_changed() that prints rising/falling, so
> 
>     echo 'file rcar_thermal.c +p' > /proc/dynamic_debug/control
> 
> should show whether it really saw an unmasked status change.  That needs a
> kernel with dynamic debug enabled; if the file is not there but debugfs is
> mounted, the same control file is at
> /sys/kernel/debug/dynamic_debug/control.
> 
> If real sensor interrupts show up during a controlled temperature change,
> then a small number of bind/unbind cycles comparing the original and the
> patched kernel would be the next step.  I would not keep a sustained CPU load
> running while the driver is unbound: with it unbound there is no thermal
> monitoring from this driver, and the trip is only a shutdown.
> 
> There is also a condition that may be easier to observe than the UAF: in the
> original code a work that is already running re-enables the source after
> ->remove() has masked it, because cancel_delayed_work_sync() waits for it.
> A test-only trace of the mask and enable in _rcar_thermal_irq_ctrl() would
> show that ordering:
> 
>     original:  remove: mask / work: enable / remove: done
>     patched:   work: done / remove: mask / remove: done
> 
> If the natural race turns out to be too rare, I can prepare a separate
> debug-only instrumentation patch to make the interleaving easier to see.
> 
> Thanks again for offering the hardware,
> Yaohan

-- 
Kind Regards,
Niklas Söderlund
