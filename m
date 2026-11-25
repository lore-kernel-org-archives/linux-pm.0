Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606272;
	b=n7EPhf4023bl+K/2TUeufxw04LUDBzuKCN7I/kbPAY1pDGP0YZuwgkG79Vl6nw39AUsn
	 TwC8EWhqP1ZpiJWR0ABr4rypBbrrBfOPTg8o1JK6hxrCn3lYud3N8TX+OKMj+ymSofbUw
	 65IBOmorAoxgz/BVumZEz6hMFVsY3EHRKjI2xJb1WlMNeWYr4CAW7xyzsAT4v3363SsaX
	 0a6MeBxliyRnI93KtG9FcDnHbQYSdi8aYd60OeO6N0yAr3wNWLML7SRRF6BYmsXs7Srnu
	 tBr1IsKwSX1ZY3b4i+i1/rnVM6DZ6g+2EcwfVFHo2TRk/blxm57ml1FdR/45M7ffx3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606272;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=07CB2JdpTLRGg0uhkULyfmQ+l69QiH2n18DqTWiKyng=;
	b=GACvxuyg6XOptRnSoiGOQrusPit2R8MM6bqunMFoIQ+jVWN6QmUbc0qYMC6gb9VBFJWF
	 DODX+GQBm0x+20/XM+Hed0xKP0AJC98fxpvs9ICpBgkYqU9E7o/d2L14iuQHZnXakNwB0
	 LgqMuHercXhywR6bK6fNF/fO5XIMRvc+sXp7KAIxZtTexeVNcRcLj2+wSI47hpBWodyUG
	 xxLqE/zeaNWXQpkmoL02iyNo00nX347SmvAK0TJlrhrj5pcB01VxFGjMyJt42bzI5j0ZV
	 oOi1+kX7OWGXsrzwf9W39r+WiHMNHGqUT/tdyEr3yyLrsrS0sTGlcaYHW1LBoFa8/bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=bGC6fXPG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1kerWhiN;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766F606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1766F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=bGC6fXPG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1kerWhiN
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80CBF7A05FF
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:31:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 06:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795606269;
	 x=1795692669; bh=07CB2JdpTLRGg0uhkULyfmQ+l69QiH2n18DqTWiKyng=; b=
	bGC6fXPGGbWnx/h7ckOm/Wf+GcGt1SuAMHdukor6aie33500Bgi3QizxNBVmSJIU
	oNfJIHupIRItGgvFsnZrIYKR1o7cc3Zr92Svae/OiyQVcwk8tNtzp/X4UhhZbJtI
	lLE6SC2mdsqWF9gTNCDGmAOU9458vm0so6O1UAoEC6Ar04tDPvrpXkletAn6+hqK
	a4tsRpmToqXejrGdEEpEowjtxIUWnpJwaLChC3mzGhKoCM9czInvBAgA/OSQyVvL
	Ey9PdhxqSMaWQ5z3QR5H2o6i1xwqhTi/A42liKL58Fr5lVp4vH8txAKr5ZQfDyfM
	QeYjjn2uuFITL1q0RxcpMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606269; x=
	1795692669; bh=07CB2JdpTLRGg0uhkULyfmQ+l69QiH2n18DqTWiKyng=; b=1
	kerWhiNzkdfetpxL3Ulhe4ZcqAPeAH0VZLT/sstGDX14w0a+vd3IpSawawqYs9cN
	Xj708kZwg9EOt8CUF8x6aXj1Vm7SVH7HY+MGkCX6qm5kuC09jHVTokyq/000yyzw
	Z4vAWrB/Y3XDsbDFwfiPHREaZkBkYQXlHArv0Wk4gqGOkkZs+SaljdUZlGbYB7FI
	EVwYn4dUUU5uJwzbRWk2HfafZJ4V8mz9Hao2k6c3WHB/VKFRzm6p5+sUW33FnmgN
	SAaD8SY1vxle7ZdjVWCtzanx7qFQ2TJ+qP0bxm+DotIYdz2damf6JapJLO5R/a9D
	uSwoIPftpUWuxjcW4i1Cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606269; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:PmLMLsOoxcLf97f5NYs+/qiKjweYy2z/Sc4x3fiBncqubRF
	84iVcvhaTkS+qsjIUpL21G5a4Nq1rRw0H0Q/tlCSzq1WnwQFtqD+Oo8BLPqXuuEZ
	SxvzMQks+iZdTQBeXXC/Ini6U1JDnuAUQsAt2nE0sRBrQZHDO+NvxQ9DNZQImn0W
	4LPRBNBCA43S2OPkQS6yAvmuNzutouvVCZIsk53Zpuzf0dFLpZ7uXjkNxQDKpBVc
	CMRdhly95aTQbBi0GX4gQNfcgOz7Vlj48eGUmjV6y3LWgghJV9Y5FwpVe9fudzKC
	kIEXitkJIePy0NV4ABtRUSnYPS0vp4PpRaIDUlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ufM61RjvuqR1r5BUEPLZlryjW+cmxFM2FV1LvtCK5eI=:4WYlrs6VcY1qrwdfudkrtiUKHwcTjuWD3mfHDU/7I7I=;
X-ME-Sender: <xms:_cYGa_rHVIZHLUtTt9LA1F9P_FjkWk45NsH4fHj4MvkqCFXuTwOYbg>
    <xme:_cYGa6F33ZVFgJDCJXxnl5HDXxlo6F7oQjRsiGGUNB5ZfGr7cFNMKOqHPOdeK6nRk
    u_UifkBYjGfT3SQgHj6kjzQSr1-29_Sg7JXwMBUrwk_m7Ggl5jHi2AC5w>
X-ME-Received: <xmr:_cYGa86ROXjLgEAGioTv_xcbdJRFINet2Q_znqd0pqAA9LXCTe1jaSs7Hs9Hx0HQX-ScWnzsGfzfGv_uLQj3A-peAqrgk4w>
X-ME-Proxy-Cause: dmFkZTFYIO1k+miz4jJ9B4TClE7SkH/GEU7+sz0HR7Lfzb+pMfdQPHogWYQRlB3X/KzKna
    VGGt6bpybPog+30OxfnKZETDRcplBcv7Abac6MjdMtHXwc3n1DHt7Q8jUMqw7swYGLVb2R
    VN8R5oRGRfjeZyi8LGnINAb1Hr3zsWrAb/4q/NcyX3K9EQy2GQ8CIgpJVplv2awK9HSoYJ
    V1P8Ht0tPLOG+PcIyAImchcVgsSV2fuaYLAkVx5wysyHiy6sG8gMXk9CsovaTD0LSO71CI
    7MIX2OamBJ/tcs0oHyy5WdoUTWf9coDW5lFrPFSFF8vnsyIOUEwg6vBpGpryr5N5lTCbZf
    dUOjGml6OdRzzzkbxXSNbElpC8F7E1TuI5qTjU0+0KaFjv0RB+1Ijn9mfLiAmRALgWkcS/
    6LbE5DRXuripm/yq1b9myEYptWUBFlTsAC/dga6kwGlNkM352mzoO/15iyiFaao6Zl8cU4
    lNgEi7CyrrbKVnUExy4ymLpPRB/aLe10Zz+dIjj73wmHvCmXJNwp1DGkzeBJLr598yKHzL
    tradNAmxlPvxou/ggdzJiy4rAWN58QbVHDb0MK+oY6z7YY3RKxLhjlpmzfcd6q5mdsYt0d
    Jk3qgTdLObXJ9UaxdK2WVsmPf7aeJsxEdr4xhUQSUU+fvyPGp6oB6Z0mD5EQ
X-ME-Proxy: <xmx:_cYGa6cPNm-0BZ3mn1tLBOXxry0NJ7vvR8wpd7of2IcPVwlYY8r5Lg>
    <xmx:_cYGa_7srp8EAHHBtpc43N8wsgj1vKj7Q1wq2lzKHdY0DLM2O02vAQ>
    <xmx:_cYGa38dBBW8aMqM0uJnWhFgGerFo-k8FlXDu_pG6cTRgM4Y3nmaUA>
    <xmx:_cYGaxGBclQ_ENKKU2f5fzVknSve792W7OxSMeEj9qw8QKM1cDQmIQ>
    <xmx:_cYGa-BPmAzkWpY3MRmTPjMzHBYdPqB1kKWbsJUySwr7PmX9ax-c_LBr>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:31:08 -0500 (EST)
Date: Wed, 25 Nov 2026 12:31:06 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: zhang san <shunsheng1218@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] thermal: rcar_gen3: release the interrupt
 handlers from ->remove()
Message-ID: <20261125113106.GM3898744@ragnatech.se>
References: <20261124095110.131258-1-shunsheng1218@gmail.com>
 <20261125030327.953450-1-shunsheng1218@gmail.com>
 <20261125030327.953450-3-shunsheng1218@gmail.com>
 <20261125073342.GL3898744@ragnatech.se>
 <nh-17d10cf4-3201-426c-b9a7-95bcba2df381@google.com>
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
In-Reply-To: <nh-17d10cf4-3201-426c-b9a7-95bcba2df381@google.com>

Hi Yaohan,

On 2026-11-25 05:18:20 -0600, zhang san wrote:
> Hi Niklas,
> 
> Fair enough, and sorry for wasting your review time. Dropping
> RCAR_GEN3_THERMAL_MAX_IRQ and your earlier style feedback across revisions
> was my fault.

I'm happy to keep reviewing your work. And I think the issue you are 
working on is valid and worth fixing. I don't see it as wasted as at the 
very least patch 1/3 is good code and more or less ready to go and fixes 
a real issue.

I was just, a bit blunt, asking for you to work thru the changes 
yourself a bit more. From my side it reads as a copy-past from LLM and 
having to point out the same thing in multiple iterations is what's 
tedious as an LLM can't learn, but you can! And I'm happy to support you 
if you want to.

> 
> I'm dropping patches 2/3 and 3/3 and won't send any further IRQ lifetime
> changes here unless I've worked through the driver properly on my own.
> I'll look at patch 1/3 separately on its own using your feedback.

Thanks for breaking out 1/3 it is good and fixes a real issue. As stated 
above if you want to keep working on 2/3 and 3/3 with more human power* 
then LLM, I'm happy to keep reviewing it.

* I don't care if you use an LLM or not, but you need to workthru the
  LLM suggestions some more before posting it IMHO.

> 
> Thanks,
> Yaohan
> 
> On Wed, 25 Nov 2026 08:33:42 +0100, "Niklas Söderlund"
> <niklas.soderlund@ragnatech.se> wrote:
> > Hi Yaohan,
> >
> > Thanks for your work.
> >
> > On 2026-11-25 11:03:26 +0800, Yaohan Li wrote:
> > > The interrupt handlers are requested before the thermal zones, and
> > > devres releases the managed resources in the reverse order, so the
> > > handlers outlive the zones they report to. The handler walks every
> > > sensor and calls thermal_zone_device_update() through tsc->zone, which
> > > is not cleared when the zone is unregistered. Masking the interrupt
> > > sources neither waits for a threaded handler that is already running
> > > nor removes the action.
> > >
> > > Release the handlers from ->remove(), which runs before the runtime PM
> > > reference is dropped and before devres unregisters the zones.
> > > free_irq() also waits for a running handler, and after it returns the
> > > handler cannot be invoked again.
> > >
> > > Record the interrupt numbers as they are requested, so that a partial
> > > request is undone as well: if the second handler cannot be registered,
> > > the first one is released and the driver falls back to polling, as
> > > before.
> > >
> > > Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> > >
> > > ---
> > > Prepared against v7.4-rc1-1969-g666539eecdf4.
> > >
> > > Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4,
> > > CONFIG_ARCH_RENESAS and CONFIG_RCAR_GEN3_THERMAL.
> > >
> > > AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
> > > author reviewed the reasoning and takes responsibility for the content.
> > > ---
> > > drivers/thermal/renesas/rcar_gen3_thermal.c | 38 ++++++++++++++++++---
> > > 1 file changed, 33 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > index a96f02d4a8ad..37348f4413b6 100644
> > > --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> > > @@ -107,6 +107,8 @@ struct rcar_gen3_thermal_priv {
> > > struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
> > > struct thermal_zone_device_ops ops;
> > > unsigned int num_tscs;
> > > + int irqs[2];
> >
> > What happened to RCAR_GEN3_THERMAL_MAX_IRQ ?
> >
> > Please stop thorowing this code at an LLM it comes up with new code
> > ignore past ideas.
> >
> > > + unsigned int num_irqs;
> > > int ptat[3];
> > > int tj_t;
> > > const struct rcar_thermal_info *info;
> > > @@ -466,9 +468,25 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
> > > };
> > > MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
> > >
> > > +static void rcar_gen3_thermal_free_irqs(struct device *dev,
> > > + struct rcar_gen3_thermal_priv *priv)
> > > +{
> > > + while (priv->num_irqs)
> >
> > Please use a for loop not modifyig priv->num_irqs, this looks dangerous.
> >
> > > + devm_free_irq(dev, priv->irqs[--priv->num_irqs], priv);
> > > +}
> > > +
> > > static void rcar_gen3_thermal_remove(struct platform_device *pdev)
> > > {
> > > + struct rcar_gen3_thermal_priv *priv = platform_get_drvdata(pdev);
> > > struct device *dev = &pdev->dev;
> > > + unsigned int i;
> > > +
> > > + for (i = 0; i < priv->num_tscs; i++) {
> >
> > Declare loop variable in for loop, where possible.
> >
> > > + rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQEN, 0);
> > > + rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQMSK, 0);
> > > + }
> > > +
> > > + rcar_gen3_thermal_free_irqs(dev, priv);
> > >
> > > pm_runtime_put(dev);
> > > pm_runtime_disable(dev);
> > > @@ -491,22 +509,32 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
> > >
> > > for (i = 0; i < 2; i++) {
> > > irq = platform_get_irq_optional(pdev, i);
> > > - if (irq < 0)
> > > - return irq;
> > > + if (irq < 0) {
> > > + ret = irq;
> > > + goto release;
> > > + }
> >
> > This changes the behavior of the driver...
> >
> > Please stop using an LLM to code this. As you don't have hardware to
> > test with throwing LLM spaghetti over the wall and see if it sticks is
> > getting tedious. Please read, understand and write the code yourself as
> > coding for gear you can't test is hard.
> >
> > I will not review another set of LLM slop, especially as the good parts
> > like RCAR_GEN3_THERMAL_MAX_IRQ are dropped between revisions.
> >
> > Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > >
> > > irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
> > > dev_name(dev), i);
> > > - if (!irqname)
> > > - return -ENOMEM;
> > > + if (!irqname) {
> > > + ret = -ENOMEM;
> > > + goto release;
> > > + }
> > >
> > > ret = devm_request_threaded_irq(dev, irq, NULL,
> > > rcar_gen3_thermal_irq,
> > > IRQF_ONESHOT, irqname, priv);
> > > if (ret)
> > > - return ret;
> > > + goto release;
> > > +
> > > + priv->irqs[priv->num_irqs++] = irq;
> > > }
> > >
> > > return 0;
> > > +
> > > +release:
> > > + rcar_gen3_thermal_free_irqs(dev, priv);
> > > + return ret;
> > > }
> > >
> > > static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> > > --
> > > 2.34.1
> > >
> >
> > --
> > Kind Regards,
> > Niklas Söderlund

-- 
Kind Regards,
Niklas Söderlund
