Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159828;
	b=JH7ps6r7ghUc5jEGdRybg4hknDYVWzglGLzkQOLIkCoa15i63Nn94HVLX1wDWhjZh+WP
	 JlHuOBDfvAIt3kqXOb50+RG0IUbtHj89ZU4qtEH8OG0noR7GN9HArkABi/54uflaJckZs
	 EKXQkc8ogg5e41ShEJBy3GQV5DPwEoCZtAzK0EYSROYnNmXcRazXOzgDJA9TPTgdd3cXQ
	 upnDLq2YOw9siG6H7rWBRi+fuQq8p1Wha7anUQKtZLESd3RQInmSMeAP75vb2CBpLdB2o
	 74r78iJZLeiW9RD1GFtH4FcDBrgr1cZ2jra8tuHGZSdZ10Az+++9W+pL/g+pmt7ltmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159828;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2u/H1uWmtn0rYKOIJUAGYGAWzwBNm3ZSYXTR4+3kkrE=;
	b=eqAq+QWiqQnB0m4Rta60PMiIS7gfYZcC4gTcZqg+oo4HzMLemxYNsC60qTO5c18/GOzC
	 DIE21F74zq71d3sSPmf28T5wG8SdhuEG551RaoP3JYTjYqwzlk1fBokWWMONE5SRbACZ/
	 W+NB6HWmObs+gpJlbQ1Fr76v/OUKrKjiKg89b61rdtlR8MmbZ74k6JjQm5sAzxTKLe0fJ
	 LcV5cEd/LGKlNJkxLXhGlaBAQZ4K/l9IwhLV4MllKzcTjd64X3AI+IkN4FN1XLfxfZj+n
	 LdAL8UakmM+cSoHL/VVH8j+ZclQpQI3GAl5izmcJ+yUkUmO5l7ftJY/gq4l2RnGGRRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Oot7nq6k;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=e7hrtIih;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC54606A32A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC54606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Oot7nq6k;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=e7hrtIih
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 466B31D002E8
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 02:30:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Nov 2026 02:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795159824;
	 x=1795246224; bh=2u/H1uWmtn0rYKOIJUAGYGAWzwBNm3ZSYXTR4+3kkrE=; b=
	Oot7nq6kbb108l/xDtc3uPTP2rR+ufBaLLqwm8DjcaXcWyXRZtrOJRRp8598EOhF
	OxOsta+GgGNMQ3J8S2pXFBe9x0MWX0lvQb+Hch6NeyWuz8ZhjmfOeqCMx9VlaiM3
	hRdIGJUfSVN2dnUGg9iT1Is5PgWTofkLwPmpXWqARDMbe/+NZBxxqBdjArwnWFIn
	GGBZqTORVjecTLbDJKPT2N6Xqrz3lZ020WaWtMOIp+mHZHC9oPwgoAWzlEl6WXcY
	8Bylq/iwV9ticNvgxb5N2c3yknxvUFOtB+2fLpgO/VWaM1cgltrQ/XVwDEBO4n41
	hEVdo4/3/4YT+Nnmc7a0MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795159824; x=
	1795246224; bh=2u/H1uWmtn0rYKOIJUAGYGAWzwBNm3ZSYXTR4+3kkrE=; b=e
	7hrtIihZsZf6omEco1hqLczBXyxlFHy/Bv4B3gPYtCNqU607iMucm0asDAAJEo8q
	JM0JAs7bN/CB7Mvj//YHlSYTzMZK++6bFCYPnYBbBalaK3MBUs2RThLdrqyTCxHn
	Uw6jV0kw51hCc8khmZ8WGN3/JWOnoH98e/iUmlsoChbjIticOaAqA5GA6pQ80iA/
	YiJud6EXQ5XOAPFdut0ZbuSPn7JlBXdhTMTFImYvBb/3VbpAw1Z3J2WL7SrgEfxJ
	fe1y5FeMaQ1ZvJIlq6AueZysykRtXp+u5HVaGKbC4ot61VPwXs8Z1jOyNhqiwQsT
	4Ln2eK0e/DwBF07b02q/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795159824; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:SZ/jvgtOvuZKK5A83Fq75xdtB8o2H8F+JKID429VvjSAS2f
	LfeWXg90J5eM47BZkT6a56cokoZxGP7JyXC94k4HdRJaGkbWi1Fz84Y9CztKCQOA
	TdQXVOmxOw2jHF9xCY3anHxmF8IDwtKoRtIFycjte7cY32kr4ebQUZm4zqHkB2I9
	qB9WnnJDVwrw436nTkGMoQuHIU6m6OM7fuIUw244gCrWLR/bQJ0eQ2bQ7OyIGmKm
	6kcIIA0ebLSXuiIWDNrK7cNow2o3naGE6o9IgyhSecPMB0CDy3JD/n0icM1fFWhb
	6K2dqSph4AhiI3JNtkI3UxrBsVay75X9024TZBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kI0YwS3/X+5PBSZzioGh2A9tMSzpYmWZsK51BETerMA=:t8FIxVM7jmpGvFdp9emUSUMHqyhKFLOFwo8iWLMBas8=;
X-ME-Sender: <xms:EPf_alxbcHZAldYyWjeG9R0mFIVf40XaCX9na8OXpwLqaOrfhbxkoA>
    <xme:EPf_arQFvjmml8vXRvkgxAhHbH-e-O6fQXEtWCUZr6_DfjkpzBeVovVvHuYuPB8qa
    wlAwa41vdDCY2fP0loHRvHvgjOVVi_urOCj1Rkb7xAor8HReBSCWtzf>
X-ME-Received: <xmr:EPf_aqKOuDwjZ2T0ErOnK_OfEjAV7QKOOuB9QAkq6RlOVRLjFy-qC3tL6qPFOvYoUPESpGaSqw5N_0BL-wucMeHpCQmqAEo>
X-ME-Proxy-Cause: dmFkZTGpQeMcMjibnWEdWpH3i7C2pzUc5HaMxERBi20DEvx4nbplCdMTC+QpQmK82oUCae
    MpF+uSwsYPkN/TbypIs+6qnl/ezxBIjCLXSLE7O55VPKHD2mJGPtBAHNMWWyw9PJImooEj
    Mb18sz7c1RzD/A7dmOgsug+2vf30aE5jF3HLNkigPiKw8XKQoxOQdxMYtxADQDQR6Ov+kj
    iyQJx4Hmea4mQ/5NMYXr9u1D/O4V8OMDv5ygiM4Hv/XjbqJl8asvPLbDyMc/A+vpALPbGy
    RO9ujuitKNYafYKUAYBkuKDvW5KR84zMC+ZFYy+qhtcWz1TUudLpBoOjyS7fYvIfootjVA
    MzUhmGuMPxogH23cBHRXQw9SzwrZQLfeiPgBSLhXrGUahhefDVfX5qkfzTgIw7QSbrRP8W
    NO43VM1ZssPJoGOZiNuhqMnvPJhmXcSHhX7zlFBlIcueatX7jLcfqMpeM2KfjFP1CvxESL
    f19IISYEwK+8Kx2ktPyeX9qv1fkBn9Aynj1vmTx5EjJulwA3x+VpwT9nbM4EFRKDu76Vm0
    ++0tc0LKLHUASXk+oi6d0f4modMXPibsVPkHkYvlfExUj8AAccpPuqCz1iOjI8mM/xEkea
    hTaK0Bc5Dc1RjIXh9r0JpsddE9U5KuylmjROrHQMne2WuKSldiy+jQc7A6zA
X-ME-Proxy: <xmx:EPf_aqVXhGZFS20g7woKAeCfxHOKDz1PsMmcJDTDkbwTCPdK83QoWg>
    <xmx:EPf_amRRrviECtbPSrwX3bBF3l34YcFlbdTbSyjZVs4R4vxnFDF4VA>
    <xmx:EPf_aqAFAaJJ0g90Fpbx6z1o-DD4SyhYIIvXlOHPfBbvya46S8roVA>
    <xmx:EPf_atJoS8z3tY9hmOgV9jO5CCPyxLXqZFs9mbE6xzg3PfPQMr_Nug>
    <xmx:EPf_aqid_iRMKn4QOjSE6kgqP98dhHvj07-tp5-sf5iF9Res1aqnsL4o>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 02:30:23 -0500 (EST)
Date: Fri, 20 Nov 2026 08:30:21 +0100
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
Message-ID: <20261120073021.GA3126029@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
 <179508711555.3615492.10674834361832600268@gmail.com>
 <20261119162517.GD2300348@ragnatech.se>
 <179514885544.420816.9397060314487706966@gmail.com>
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
In-Reply-To: <179514885544.420816.9397060314487706966@gmail.com>

Hi Yaohan,

Thanks for sharing your test.

On 2026-11-20 12:27:35 +0800, Yaohan Li wrote:
> Hi Niklas,
> 
> yes, of course.  It is one module, self-contained, and it needs no device
> tree or hardware setup - it builds against the tree you give it and runs on
> the board you load it on.
> 
> The module exercises the three primitives the removal ordering depends on:
> 
>  - a work queued after cancel_delayed_work_sync() still runs, while the same
>    queue attempt after disable_delayed_work_sync() is rejected and the work
>    never runs;
>  - a work that is already running re-enables the source behind a mask that
>    was written before the cancellation, and cannot do that when the work is
>    disabled first;
>  - on a line shared with another handler, synchronize_irq() does not stop our
>    handler from being invoked again (and from queueing the work), while
>    devm_free_irq() does, without disturbing the other user.
> 
> To run it:
> 
>     make KDIR=/path/to/linux
>     insmod irq_semantics.ko
>     dmesg | tail -n 25
> 
> It needs CONFIG_MODULES and CONFIG_IRQ_SIM (the latter is a hidden symbol,
> selected by CONFIG_GPIOLIB plus CONFIG_GPIO_SIM; GPIO_MOCKUP works too but is
> deprecated).  The last two lines of the log should be
> 
>     summary: 17 passed, 0 failed
>     RESULT: PASS
> 
> That result is 17 assertions about the workqueue and interrupt primitives,
> not about an R-Car unbind: a green run says the kernel behaves the way the
> patch assumes, it does not say that rcar_thermal_remove() was exercised on
> your board.

I agree your test-case is kewl and interesting but as you point out, it 
test something else then the code this patch touches. But I learnt some 
more about ktest reading it which was nice!
> 
> The tarball is attached; the README in it has the same instructions and a
> reference log.  If the list strips the attachment, tell me and I will send it
> to you directly.
> 
> What the module does not do is run rcar_thermal's own ->remove().  That needs
> a real platform device, MMIO and a thermal zone, and the driver's removal
> would end up buried under the scaffolding.  So it pins down the primitives,
> not what the interrupt status registers do on your board.
> 
> For that, what I would suggest on your side is to unbind and rebind the
> platform device in a loop while the zone is being read, on a KASAN kernel,
> and check that no work runs after rcar_thermal_remove() returned and that the
> source is not enabled again afterwards.  To get real interrupts during the
> unbind the overheat source has to fire at least once; on this driver that
> happens when the temperature crosses the trip point it has programmed.

Yes, I was wondering if you had something ready made for this test.  
Having something push the trip interrupt often enough so that 
bind/unbinding the driver from the device would provoke the condition 
within reasonable amount of loops.

I will see if I can make something up.

> 
> If you can tell me which SoC and board you have, and whether the thermal node
> in its DT has an interrupt and a critical trip point, I can work out what the
> smallest meaningful run is.  I am also happy to reshape the module if you
> want it to reproduce something else.

I have access to a few boards. For this patch I intend to test on M2 
(r8a7791-koelsch.dts) which have trip points. IIRC when adding interrupt 
support i had a critical trip at a low temperature and then used cpuburn 
to trigger it. Maybe a non-critical trip point around the running temp 
and enough iterations can trigger it.


> 
> Thanks,
> Yaohan



-- 
Kind Regards,
Niklas Söderlund
