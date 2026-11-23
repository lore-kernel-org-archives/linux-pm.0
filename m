Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416473;
	b=mFfUWUtb0Q1zaI+7jTMLUrFDuR0E3I4ufgbDgxGBESejLujIXhjLLRg0W+XAMO45nYwq
	 L04Hc/CVTyw5rCbNc3WASfCNydkdorgredsp0Lg18YGwq7XTHpjjq7oEot5eqPHh+2boL
	 UjrEa6Ys3eJkNpHkG6QqCv3d+CVzp38z8K4YwM9zxLS2SubxdlXboHEJ7RbkFnHDiPGA3
	 aDkgXNt0o6LHV5w+JaW37XMdwJQvIMuGTVANjERXx7XEZUzZ35KGmIPUEAHb5ybEhBce3
	 uK3UQZAzj2ZRJ8OmdA+XKoZYDBd2SWf7jXWDU2SCSVwGB7L+QKKxcNJV7Xq0zKoy51A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416473;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=R56CGvuipwCkw7nLgNx/ugKW+lWOaqftE893+JUs6Vs=;
	b=qn+0yWFIF/1cu2bgp5ipbPnRXaq4uE4aylqPpHpM1g99ch5Ef/My1F3hi+xw+rwuQXHg
	 7DiksHe+NZhS0VvmalpMugqTgyzUqWYjAmPgDo07+mswiNZthjlz8BGT2KNWAD4wVps0T
	 yb9C7XZbogW1jbfaYRqix7tPZyUbM0mwIMDl5ZaEErH2fDYwTkCnnE2swrIwrvuWUuFKe
	 pSY45b/E+mC5oDl9JfB4RD4b9r6MwpGakdCXllImtJt3Eqmi35JSTy0Uryt96I54gG8D2
	 L7qxl7K3HataqO4jrMg7pRDRPPUe8aZ4b7hlAqddUQ3CsEc0AhVO7ryp9YQoQ6JqhQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b="CWDv/UaW";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gT4kkZfE;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FA606A31A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=CWDv/UaW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gT4kkZfE
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CFB4EC0B10
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:47:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 01:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795416467;
	 x=1795502867; bh=R56CGvuipwCkw7nLgNx/ugKW+lWOaqftE893+JUs6Vs=; b=
	CWDv/UaWmofZ0Jh6lNvrMSIWJOFsFfyfXQc5XOikrOMjL+sjVHBHkWKbzsgp9HMS
	agofCSfGXSCVOV3/sQ3fDIYlsdAr6v4Ozgh1APOetZGxS5e2Uy3BqB4YXwSqJLxS
	79rMTrkmk9ye84qpc2758Bh6Z0S8a54ui2jMjDza896x6wPTYDbaCsZqPrrJdfIE
	4zmdHgwr4uJKzgzsASMcHbco5v6H4NYmc0YBSmTGMwE0VWlanOkOMrDsV18f69aS
	M1ufmoOve2MKsaHicmuMcng5+VqXxMdOAclGX45EQDFsmGjjyIw+oah6SVqIn3ZM
	CRKJRn+ToAv+Tk9wanOgFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795416467; x=
	1795502867; bh=R56CGvuipwCkw7nLgNx/ugKW+lWOaqftE893+JUs6Vs=; b=g
	T4kkZfEtE3nc718RC6oCQBxi8W36XYW6VOPVxQ1pWkULzorcj4ZEW21f7BOq6L20
	pGH3qCSVtnmjYDQQ7AJjhZ53VPAoZNRss7oDWrnT6YnAsy+xPCETB2yzLUZ6ZOXL
	FU1anIiwZfdqWGtkw0m+9yOdamxvKjq9VT7O7KejdlzKGSvQEv+dYWrqwa663BEk
	1iYTilsjsPGj1G5+eROydn4aOmtB+SZPFtZC5sA8l5rqYWmcorwtOxRvhn3KVUbQ
	4zlAOPg+1NfcG0ocUiEIWUH2qBhpI7Lb+3LTW6UmNTcPADrTCrgST9CL5jxRthHI
	1VulfImASUX9xoinNhJzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795416467; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:gdtBRc1bqGzLQFWqJDs1WpaFI/mLs5quYUy0yHPBelvnj/D
	D8wAEFJWNyQvnFaZCDnqdcyU93fCNsO+NrTcCZfewwB6Uf7KgXOOnNwUDOwkNYXi
	ZYcz5ugCGMSpF/gZk46gCHOkb5itbOPRjIZjIO2nQ/PgmTBDJcjKu4VWjvh+jMwA
	9x9cbK5NV46X31Q9Npc4uczBXR6EB740RD7/cgRieHqW9scrHqeniT1GB6jLhEGW
	+REA7CohAP3CdZuaMgLnbx3zsJYrnXgSA9+fTQVm4B9YYE7ojNxOSn7FF87ffZWN
	FNKFio80UdHn9XPHBjPUleRBZrLDqJuKYngdsZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1Pdeaq4U6HzVIDUjSF3kboOQsse4dXOdurywr3307Vs=:qmub/TK2m4rzQej8CYP3DNk/yeW+UT3ctdZcLREkYfQ=;
X-ME-Sender: <xms:k-EDa9DMJUXiA6Pp7jmEpW5z4_Aj14PEyfZQU-cntYcHQyujoC6nEQ>
    <xme:k-EDa7_KfKiol124A_t16Ni4Sq-A0U0_1CleELtAfuCTlFjaJTGQQ8KzdOn9H--Xa
    dL3eiKJxs8oNt6gOrXpJ9UBPYmP0U_IJRz54VBghvILIgT7HaayWJ8>
X-ME-Received: <xmr:k-EDa5TpZC5_WqORypUsRQIIFS_9tNYa-b79jYhziuub8_wSx6VP7YMY8SdEnxKHqNT0xuOQzv9PhYJGdFiQuuktmtCV1gk>
X-ME-Proxy-Cause: dmFkZTF4zgerQ3Slxqerv7kv0Wob6fmqMCcLmsiJURccvCd0nRf1XVlG218zD+p1GyTkM1
    Oj4IbEqo7W8WUCqiLoyR6IIxAD35eCkRpVf3ijhlDBApn6vonDbcl0B0a22HrQ6BjAXPnH
    nO9CNVvcQdZ5RJ9ONHlOsPoolSfLhUwpAR41+l7J7TJgFOms2BVgo7lQy3tC5cfCmb0Mhf
    tdTKyki0249/iMAKKLf7tVPL/P0dHsS6suwHsxNZJU5hyzl1DA9tJtsarZteJ9BJvXgf3t
    6/ymrRniHWsiYSGBufuSFbJc1rID2fwv4FfESMDEtrI1XWpyHVHDsqRBrcsguJOxa27ebp
    5H+fym0P3Tet3uX0DDTT1FfP4+ArUM0CYoNOS2zh/xMd96Nb3s2zyYL3+2Ghr2QLCxYlFx
    et1Ts1nNG6/kMksCS8TFVMwWNgjoQt2/69UrQxwvguVigSWAD8o8RKLNSQ0vNBhRImBxN6
    WvBxsY1bw45YaUSfqD+vLy6JqyKpO5PoY3zGuCw8uGAY9ZusE1cddqtGH4cMN1263hziR6
    M6PMOwmcae/Brf6EVOA6mIT5gSRkUBNrUPC2QFDLOvX2kJX1HuKXXATmXW8x0JXC0R/n+V
    MbbcdlHyWvzHMEF93MtMB5scYGfGgr/FWTg8XybIbl4gLEimaxdIzAQGQW/A
X-ME-Proxy: <xmx:k-EDa_VSDo9PARaKWZ9Z3SNddXe7ohujVhhfNTTVC5EBDmkuMe50ng>
    <xmx:k-EDazSpIyuFizuTz2xjgTCUQK5CN4UsnH2orzW2haEh8IVb0GA-Yw>
    <xmx:k-EDa33EmKzor8sDN7tA5Zt0iG9amP1MykrpyfLJSEE3K5Yw_djHlA>
    <xmx:k-EDazfP7aJnTPlqss1VAG1KupFUeEgpwXlxG1WmVzkKfO2YpHK01A>
    <xmx:k-EDa86-L93BHXow9abzTv6jjH8iDyHyviAaFK4eAFnmLuDh-p_6vOS9>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 01:47:46 -0500 (EST)
Date: Mon, 23 Nov 2026 07:47:45 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3: release the IRQ handlers before
 the zones are freed
Message-ID: <20261123064745.GD3898744@ragnatech.se>
References: <20261117145348.1092528-1-shunsheng1218@gmail.com>
 <20261119022926.1493582-1-shunsheng1218@gmail.com>
 <20261122144813.GB3898744@ragnatech.se>
 <179540050658.417371.217605576878858750@gmail.com>
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
In-Reply-To: <179540050658.417371.217605576878858750@gmail.com>

Hi Yaohan,

On 2026-11-23 10:21:46 +0800, Yaohan Li wrote:
> Hi Niklas,
> 
> The explicit devm_free_irq() calls are needed because of the current devres
> registration order. rcar_gen3_thermal_request_irqs() runs before the loop
> that calls devm_thermal_of_zone_register(). On teardown, devres therefore
> unregisters the zones before freeing the IRQ handlers. During that interval,
> rcar_gen3_thermal_irq() can still call thermal_zone_device_update() through
> tsc->zone, which is not cleared when the zone is unregistered.

Ahh I see, thanks for explaining it. Will that window not also exist 
during probe? Would not a better solution be to rework the order in 
probe to eliminate the issue completely?

> 
> Masking the source and freeing the IRQs in ->remove() closes that window;
> free_irq() also waits for a threaded handler that is already running.
> 
> Requesting the IRQs after the zones would make the automatic release order
> correct. But probe currently uses the return value of
> rcar_gen3_thermal_request_irqs() to select priv->ops.set_trips before zone
> registration, and rcar_gen3_thermal_init() enables the source depending on
> that callback. Reordering would therefore need changes to probe setup and
> failure handling, rather than just moving one call. I kept this revision
> focused on teardown.
> 
> I have shortened the two comments as suggested. I will hold off on v3 until
> we have agreed on the approach.
> 
> Thanks,
> Yaohan

-- 
Kind Regards,
Niklas Söderlund
