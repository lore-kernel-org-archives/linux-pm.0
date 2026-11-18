Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994270;
	b=3y5UE8BPDiwnWYEx9Q3u/LXeNA9G89EtZKHRUMZm46yDqJm7ZSK96yWMhRjOVE22KWN5
	 L7iuCtnKkjEHpUcHF46Z7USq2gVAI2N74FKFRcV9BQF/ie6rTc8WcZXo4MMV9RvvPtemm
	 qvsXd+t2e1MMRhnHt4/nkwpUYiyeEIvEtgWDUbnSjA6CduR+9kBN4au3ob39VRecDVj5q
	 NK042OnfWXLmeYwtT/XsZHxGeIZHD1mth98VWuX5WOQDjx31OrALyCoWSreT+iueVrIUs
	 qJU0HSHFlmTsKC8luB8bnZfZuIlJL4fWaePSMsA5sfAggAzWCNxO+Hn2TXPpN8wJmvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994270;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=FYEMQL7D8ekblNOegLonV+3XnFkGP5/QdJvz54jKYXw=;
	b=avLzlj2MSrYfG86cYO7U5O2Gmi7CIyz/ODvR5B3vkC4hgfCt+egyaTmc7HdtCp6AcsRa
	 6tW3XRBx2Dw6wdpjlO7333hdTmrdNofPBUmy1+Ek8SjBTSMP/tXT72lWkmMH8wLZ1UPM9
	 lwgXiNQ0CcZPPaKgAkmNTO1qh3Zw9AjjQodY9jHa7+HpS2+iHxMI7Hh1Nr/xOfuVZ3WFI
	 ezMY+1/EtsudM8q4Sx55m4XNWdLPVxTWIHFpvhWsCYYMRzfiJAXMG9iresoPRFGQBt59C
	 27dkiTs32i+MxF+3JD56zPjxxVOIAvHQUILwqd1oKseM5y2h1ID1YKvc4MtQl3xT53Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=QZrKC83z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cVndpGNf;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEE606A32A
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 09:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AEE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=QZrKC83z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cVndpGNf
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 89E2FEC086B
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 04:31:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 18 Nov 2026 04:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794994268;
	 x=1795080668; bh=FYEMQL7D8ekblNOegLonV+3XnFkGP5/QdJvz54jKYXw=; b=
	QZrKC83z2FpDVnSp9EjKacNXubNDWu/JA67DtL66tFql9QwJoQb3ttL7QkE3qyeA
	UZPG04Fw0ryUWUfciC27jtzj95hFM0PivZ0pBdqkinPFk7BknvjDgDLStL0GpQdL
	bfXUf1tXnw7cmGU7HFrQlIHm1UipI0mEq3c19TH8MuQcHg8+daLdZNywgCHIZETU
	E9hnhFynHILmV+yNCw+R4bakNshnwMiL+Vf6x3KgDEEGFUd932f3iiBbWoDOf/ZO
	G6BP31pfb/PbcLLpwZ0C7pT08J6tY/TZhOQ0bMrUp0pDDy48+RMGcKGjo7w3pKmI
	TNo1kCryCpvSrnOsg0PsPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794994268; x=
	1795080668; bh=FYEMQL7D8ekblNOegLonV+3XnFkGP5/QdJvz54jKYXw=; b=c
	VndpGNfIEs4ansqOxdPm/EA22hHz4yEB93BQhcK39kLA8y6bMJkkHgRtcRUsaLbD
	U6Ty9XCWEO+1/fFeXqU9zYa5qsnb83eKONIymb7RCMFOcG9JY/YSufuqQdBLpg20
	fdVAGW5d5pahFvEqKywFVA3yagD1CiVBKPR++JD9uDTq84c9gef7ZglnQiLdDFlb
	iY/Sn9Q5T9G4dOiR32ARXnDKGi1qNNAPJXj11rpT04KrD1zfw4s2+uTKJdqFWiWp
	AceMyMabG/KQBzXLDXBq5nWDdHlcIVY7GO9sr4/jYuZjoqYsZMisyVVpB+5IHi9n
	kwfymmC3bVPHZw4MHnP8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794994268; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:wQ0COXC011Td2aYUo7dLDFpbxwKtWx8H+kGaYMk3ajpN0fP
	R/BXqfRrrwQKPSRGTIpuP/CT7HrpKzxb/vU+uxEMaBzReL88X5tKoCNlzvO1vCU2
	3oCdAQuaNTH6Y8Bt7CipGBf3C4vcuRQx233OxIZtvi1XyRaF+FQsrLv+aOi0Z4T2
	h125MYd6+I4I7bglf6Vz7WwVUi04bpfqVr6TYj9B8u0A/+q+ByfPFLpOGkdwIMbq
	zM65OpbPz++yMbJzQDXen3F4RaDpUkS1/LgmsXk0r8w75GiMzuvkjh02D/ymeUb4
	Ussa3WH9twNZybeAHHswbMKk9ow2aEp1ICjy3Xg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7NTa3zNk24Dn5DDudjdq6sX3jIAvJDBGhOy+LMZpnPg=:hpm+LCmifHtf1PHuC4LPNLY/W1wuc2v/aTBiusw+BFE=;
X-ME-Sender: <xms:XHD9alLLhG03lRu7r5_a0axdf-xgjp9czVnRnWrJ6q56WhGu1NE1wQ>
    <xme:XHD9auimjg_7RcE0e7iSsg2OdUw2B14dgR8CUaaB5jJu8dOucBeE-7ZPhQZlR0Q3B
    -Sym5aHZInKzcARQA18rqUGuiBLhvqKj_YcLmRXJwRkDcfCdvx74n7xhA>
X-ME-Received: <xmr:XHD9anORA5r6Z6OQPeMsra98IyLBY06w1JhqRrY5upPVGo3R9MqSabEJOPxteaKPLTXsK8mGqLQOz1yWAmMumiehyxq8EIo>
X-ME-Proxy-Cause: dmFkZTEF2qGdxk7mJg4/ZMq8GPpSmYQEk3ceRSu6WvK5sPCzYYTmpIsMkynA90lJJ3Hh/M
    TjTk9wNG4sUQmRmxJ+cd2Ntso6liWsdywsLdhU6KDk2tEqsYHoAlqYhnjCBwv+HDA1xOz7
    eq+EfvaJIOBFKb4B0S70fybXlTeoNDRjg8ZK/DYm0EqmNdQRoeNZ3kKp3FmCy9qMIlJ8++
    4in42Bj/MAONqgwG0c/3niOu/v2nrBEjEnPhCcVixd/HgrfJtIGZZGIJdrasmI79EBVBYt
    07O8xQjPKhxEfjSPg5coYbfT3xmpQGjhNJu4VbWV9qVPax3tz0U+mJIrxW8etL0Kykokof
    b6lXCHUDY2J/pmhvsddOjzTeB3fw/oFQThWVBem0zsauSxP3Ogm/w86OGxLOkspTLdxE0B
    kFBcir9mbs1PAGNhBsiq0T7/P74BbHD7YUvtOqxlIL3SAPrVO+2SfxupU6iPUhPGe+R8FN
    AVV9VU5hNffwRhl9NxPFez39nsW7Xa67Ja8u0Z9NDRp6WZew23Ed2R171IzHchdpUwIjaE
    XwnHLZJO5iOW97t1kEuJTuM9JwaOUE5KR6cGE0Wyb6F6eB1UbzZYkupcXPS0u1wJtELyjU
    CyzbbfzraHvyirxN0MrtACGExvKAhZWfSsRT7IgFoPSicQi0uMlwOB++r3OA
X-ME-Proxy: <xmx:XHD9ahoCsSHlQec7RXdpsjf3amZbViWdbWCM2Qaq84tiI8ngOiO0Kg>
    <xmx:XHD9ah7HsT77umj1lScvIdbT7RhDRUIXj9A1UsntXjXwZ8jWAa-5hg>
    <xmx:XHD9anj_jPX8IOQvQcstDOf-YWsjhcIZvfyoDHixYkkf6WbtjOOO-A>
    <xmx:XHD9av5oE8RS84TmtToVE9PEyNMRyT9N0JHUledaKRikJ8QJMT1vGw>
    <xmx:XHD9avRDpZVYy3dJ3L6U4C9WpP4ez3t99e8JdZX9JxqRo_KVLqXEPkVZ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 04:31:07 -0500 (EST)
Date: Wed, 18 Nov 2026 10:31:04 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, geert+renesas@glider.be, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: rcar_gen3: quiesce the interrupt source before
 releasing it
Message-ID: <20261118093104.GA2548353@ragnatech.se>
References: <20261117145348.1092528-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261117145348.1092528-1-shunsheng1218@gmail.com>

Hi Yaohan,

Thanks for your work.

On 2026-11-17 22:53:48 +0800, Yaohan Li wrote:
> rcar_gen3_thermal_remove() only drops the runtime PM reference.  The two
> threaded interrupts are left to devres, which releases them after the
> TSC objects and the thermal zones have already been freed, and the
> device keeps raising interrupts because nothing clears REG_GEN3_IRQEN.
> 
> rcar_gen3_thermal_irq() walks priv->tscs[i], reads REG_GEN3_IRQSTR
> through tsc->base and calls thermal_zone_device_update(tsc->zone), so a
> handler that the hardirq has already woken can run after those objects
> are gone.
> 
> Disable the interrupt source for every TSC first, then release the
> interrupt handlers, and only then drop the runtime PM reference.
> REG_GEN3_IRQEN is only ever written by rcar_gen3_thermal_init(); a
> concurrent set_trips() writes REG_GEN3_IRQMSK alone, so it cannot undo
> the disable.
> 
> Remember the interrupt numbers that were successfully requested, so that
> the partial-probe path, which also ends in .remove(), only releases what
> was actually registered.

Could this be re-written by a human to describe they "why" and not the 
"how"?

> 
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
> Prepared against v7.4-rc1-1969-g666539eecdf4.
> 
> AI assistance: the analysis, the change and its review notes were
> prepared with Claude (Anthropic) as a coding assistant.  The author
> reviewed the reasoning and takes responsibility for the content.
> 
> This revision also clears REG_GEN3_IRQEN for every TSC before the
> handlers are released.  rcar_gen3_thermal_init() is the only writer of
> IRQEN; set_trips() writes IRQMSK only, so a concurrent trip update
> cannot re-enable the interrupt source.
> 
> Testing: compile tested only (arm64, gcc 11.4).  No R-Car hardware was
> available.  The partial-probe path that also ends in .remove() was not
> exercised.
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 25 +++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 9c64cbc2ee67..35bb49915a75 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -110,6 +110,8 @@ struct rcar_gen3_thermal_priv {
>  	int ptat[3];
>  	int tj_t;
>  	const struct rcar_thermal_info *info;
> +	int irqs[2];
> +	unsigned int num_irqs;
>  };
>  
>  static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
> @@ -468,7 +470,28 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  
>  static void rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
> +	struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
> +	unsigned int i;
> +
> +	/*
> +	 * Disable the interrupt source while the device is still runtime
> +	 * resumed.  REG_GEN3_IRQEN is only ever written by
> +	 * rcar_gen3_thermal_init(); a concurrent set_trips() writes
> +	 * REG_GEN3_IRQMSK alone, so it cannot re-enable the source here.
> +	 */
> +	for (i = 0; i < priv->num_tscs; i++) {

Move the loop variable declaration here.

> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
> +		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> +	}
> +
> +	/*
> +	 * Release the interrupts before the TSCs and zones are freed:
> +	 * free_irq() waits for an executing threaded handler, and the handler
> +	 * dereferences both priv->tscs[i] and priv->tscs[i]->zone.
> +	 */
> +	for (i = 0; i < priv->num_irqs; i++)

Can't you store a negative error code in riv->irqs[] to indicate no IRQ 
and avoid adding the booking variable num_irqs? One variable can never 
go out of sync.

While at it you could create a new define for the maximum number of 
IRQ's and replace the loop limit in rcar_gen3_thermal_request_irqs() and 
the number of elements in irqs[].

> +		devm_free_irq(dev, priv->irqs[i], priv);

Why free it and just not sync the interrupt?

>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> @@ -504,6 +527,8 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
>  						IRQF_ONESHOT, irqname, priv);
>  		if (ret)
>  			return ret;
> +
> +		priv->irqs[priv->num_irqs++] = irq;
>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
