Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415901;
	b=P+JtOjOy9iMyV8UAwqCKZEwE7Awmako3MCIvrvdjtzo27+Nh1DpDB1IMjGEYGdS2uJko
	 zZGa7nHIkrG1GLa5Nkcfv6KqnMlFUJDGWz3ZqUEqaWglxJDfFy5LUZj50RZa/G40qZsMk
	 ZR4srXHUMvvwdd+NDOpjdcLdyZIPrBT42hOurgJH8zxf7crdTD42HeKhSHK2dHMxm/yNr
	 zN/5X/7rlqAZwXZYYfg3LpU93GTnRoEp9PUdQrNQB7AYq3e0HldWph0IzGdLmD/gW1xX2
	 DzWAaOF2HtjWP3HBNWGHH6SdbeecmEWcpzDo9G6x3e7Af/ZYb9Zpqr0R84/OUgx5JXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415901;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=q0mLqSXDIzQNqVTzln8PT3COGc8e6WnuckNQ4xhN+LM=;
	b=10o+2vx4CNk9RB3L0Dze7JFjITCX8sy1OS902cbRxf3olQdZMf4ksAuVhcE00HVUXTSL
	 LdbWzm9BaB14wyiIyzxRuThSzPoKuTy97A+pxxU6YdxA0vg7HgQwXInfLZru708xGeFL9
	 2HA2GFVwtOXPK4imVqmb/fwNM2efWiZ/w/Ybh7yvplYT6MyXg98soaDCWWqXw+Bo5oMRU
	 frPsex1ZQgBPQdF2vMyTF+z0xHKqjowktdF8ajZ8qpyceYorKHwDIvBZJ3swNvagS7Xb/
	 TYjNCAjPQRq8/eudruYgj4nLXxFZd9Mllt/xqX+HHSAsTig3RqQGk6bkXKS86AL0lMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=fAPq3fr3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ccn1qYJs;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A4606A321
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=fAPq3fr3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ccn1qYJs
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BDE3EC0B14
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:38:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Nov 2026 01:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795415899;
	 x=1795502299; bh=q0mLqSXDIzQNqVTzln8PT3COGc8e6WnuckNQ4xhN+LM=; b=
	fAPq3fr3FJdNF7PpPrSJfewbqnTPYZUuGRLrPO9JuCE+d4FBRr6lt6HfIp+HD5i9
	rbAK4XFKEbEw3+0+XVWxdvHWe3d2+hMHwXx3/CVrehbS67uNNScSWG/0GBJNLdYg
	Kqi3obknXcx3dp3MyBhQV9O0h4E0ld60lr1at+7XlW4t/t58W9Ra/knYZMQjqVk5
	dp+RjZJbPLePR/mtPEzwn/nKC/A+WpVfitWDvMy3xv07wiG387aLkF82e6cXxYdM
	+9fKz1gtURIUSZzajAzhsUz3VenUZMAeeSOmB++uiOIwJxq4fc7C1I8d7DBF8ONW
	sjLEmIIC9PBLQCQNl7jo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795415899; x=
	1795502299; bh=q0mLqSXDIzQNqVTzln8PT3COGc8e6WnuckNQ4xhN+LM=; b=C
	cn1qYJss8pugykUKg6x+M0CQujJIIGtpsezee59MfEbgASbRLkUwiAx3/UMYRRC+
	u7uM9SaXH+qjbuEljZDFHFcu4aZFeMksM9bkgz4nS3Kdc2pIRFlhJ/nhSlwuCxbX
	kwwaBVC5eZUfw2bq2xnM/rSmsH4JQ3qRhlrVXEIKl/aKnxXJAvQGzXXNcVmRAfaw
	kf7+73HT3ghSCixzvLFnj20y9a3811DNUuBMJO3zAGjKJzqgbx2WfWxTNAU5mL0m
	nJcHw1LP1xVg9MkXNNm1ATJMnXWlhXxnvyEcqMGm0W2mV58xDqaEtOvLOIOn36zJ
	leddjP/y/cRpMmzE89GyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795415899; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:wQBKW9VdRXa0dS7Qo42e31fLPiYGwIT49W3Gzm6zWkF6Qub
	+knIb+6DdSQFtvOF7uBXQ5mzY8cH+jnPBF2qb7dseMkurBItRlRDGLLmAwOhK5nJ
	nknkWQ/NNUlRsKJHCO4pGfeKBoq9en26GC7TgpDuViezOTvDuMmx/sBN3zfkM2Ld
	M69NkP2sakXQKG9YJvuFskLznnY/dARH/24k/i4IxxfN/XMjIwh6yAhPIkI+mBLh
	UJoWTn4lq8JJ9vWaBucFcEHoeMWMPFcjso/ZEZQhkdk0fA32W0V/l2wAB3Nc3dQz
	KJiacsxAQmCKN85cfDR4xywvK40iC5hPQVIqSCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3Z8WjHWepqbXWook7ooKgKyfBrU+JKjnlzBgU5lBNWQ=:d30LbSxU56iby5FnjAFaMponSV+0lphd2F0vRkD1iVI=;
X-ME-Sender: <xms:Wt8Da-5h5xngbIUCm1D8MlV2J8MI5KH4UvTsZOWSV_j3G4SLw7mW1w>
    <xme:Wt8Da9796m15KP-l_9iQwsmCjCKHgvUEwD7pQjsBEev5rKlVSqDkEJW5_q0sk3HPj
    Bu2cKcj15cycI266boyrhJFGVxPb-E3b1mHwHM5XmTEtqomYbdAHwc>
X-ME-Received: <xmr:Wt8Da4T0iw19TmSBRhvCMS77Fw8PtiGU0jA1ngxHRSSt8Q0txvdTHN6D0dd_jFIqzcbnBPgnN3kG83OxcVCFawrJVtxlMZY>
X-ME-Proxy-Cause: dmFkZTGQKv0zWvGdnav/t3IFqUqITDlr4jn99xB8PNcn+tTn6dgxpZ5y8lPFArXeNCklnX
    JQfHaj5X54IZimrNIcDOI0Ze7tRtfV3l7Nfz5RxEse4/i6/xJ9MXghu3jTrRLnDj49QVIb
    WDMSn2KS81Kjgzo8tYU/VQaPlW+N3wjcUO61PtxY1+jOoPej918/j2T1ja/8Rjcs8FNJf/
    D+iHWWM8BbYdHP6f48Y+C+DuK8JAqc4RrMFbUdFpJ2sxnEMSBc1YpZl851XnB34tlQrAGv
    8KdageTwsuLChsdiavzXOeP8voCy6wgBoC8PA7/C72z/euo4grVEXyMQnqDV1Db6AkpGWz
    JSJJDe/IcKzRtsU2xVeeBfSzQSo8TMrCWkq4CNq22XaM/1bkOF1EqGVLfo5yoPtidl1rOy
    NgJ/INCxPVCW8EemN9CTyIxkVB3O1q+5sZ/7gKYYi59vgwaY4squvoMnn7fSEpsyqWXZ9n
    iPr2B8G0MI0vftz7rfCIIBtSjZ5eBxsNEvyHl1hOAQe8/KHajTE8eQEHQmpQtfzqfb5ctD
    HVLC2tybdUZUs1BfXjK75We0r+GoX4dFVeP4BIJcUWp+74L6JbfHvN4+axOrvD1b44Iizi
    j1WWDZEMf0tNWbNBk94j3BwhW4+EnXTdKLiVA56D/UM60aAnZZbWcHJgQo/g
X-ME-Proxy: <xmx:Wt8Da9_EZya7vg2shLZ0lEr2-NiP-Y7HQnmbTyGYEQWeU6UVsULFyA>
    <xmx:Wt8DaxbvHf5u9iwnYTsCaX-BRGjkCrwNpNWX8ajLSoHultJZTI9acA>
    <xmx:Wt8Da2oWTfaqdQqJ6XcgF-c1AniyXdPHQkcq7G8qHN6eURE9RAfiMQ>
    <xmx:Wt8Da9QK_K2Js19-tflPPLFjh3yZGWGJxUZbykd5WrSE5h8MbduviQ>
    <xmx:W98Da7q_zjyhcVf0woLsmRszgfS8FyO09vKAF-bfbvBpMi3sRiElmR2d>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 01:38:18 -0500 (EST)
Date: Mon, 23 Nov 2026 07:38:15 +0100
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
Message-ID: <20261123063815.GC3898744@ragnatech.se>
References: <20261118072321.1259639-1-shunsheng1218@gmail.com>
 <20261119022903.1493494-1-shunsheng1218@gmail.com>
 <20261119062203.GC2300348@ragnatech.se>
 <179508711555.3615492.10674834361832600268@gmail.com>
 <20261119162517.GD2300348@ragnatech.se>
 <179516779969.759914.14349189301325900521@gmail.com>
 <20261122140906.GA3898744@ragnatech.se>
 <179540050658.417371.12537370024433882605@gmail.com>
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
In-Reply-To: <179540050658.417371.12537370024433882605@gmail.com>

Hi Yaohan,

On 2026-11-23 10:21:46 +0800, Yaohan Li wrote:
> Hi Niklas,
> 
> You are right. I do not have a ready-made reproducer that exercises
> rcar_thermal_remove() on the actual driver. The 17-check test exercises
> workqueue and shared-IRQ primitives; it does not show the original driver
> failing or the patch fixing the race.
> 
> I should have made that distinction clearer, rather than suggesting more
> thermal-load experiments. I will keep v3 on hold.

I think you can post v3 already, if you think it's ready. Once we can 
test it or it becomes trivial we can move forward.

> If I can put together a
> test-only instrumentation patch that forces the relevant interleaving in the
> driver's removal path, I will share that for review before asking you to run
> anything on your board.

Maybe the top half of the interrupt handler can requeue itself. It will 
be a infinite loop but as a hack patch to trigger the issue it would be 
ok I think.

> 
> Thanks again for offering to help test it.
> 
> Yaohan

-- 
Kind Regards,
Niklas Söderlund
