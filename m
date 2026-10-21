Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608600;
	b=O/AL67aIDwDwLk4xv9ATEJqgISsB3qXDLHlFLZmvy0X7IK9D6kIL7ah+gN8R3WipIb7Y
	 AnsAqlZLOfiqSWPGgIQCbYimcRSAsyd/Ys/42dvx6iD6wQ1i+IUZAQja1ykCpTo6qdrBH
	 grAQNvdxzeJbkMInFdgrFlBbTlhjUN0juGP/js6gsM4q9y/cIQLPoM94ZsPoJpf5TdmOK
	 +zGYqituJv1zmZKiyUNsNtOF/2l+A214D6h/hqhhH5l1JaPBSjFMQuDtIBLubKocDnZhK
	 LvW0tpJ6Iw3agkbEwNcoagURcq2GT81ViWjYYDqXk0sS1znsP7Qv6JFLt/jas4tkTcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608600;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UP7QKcZoxFf5ukFFf3zgd+8QVhw52yv+EUqhUUTfyb4=;
	b=KSitFwIZOtJeRj6ftP6CYfDrJOp0J/5sYP1xmYjoFmQAKTF7qpl0hZJo5dFoigzqn2jb
	 iu3iIsVMqlOcQUQex7fjGhnMgpJSJQyfrCD0fzo0yEpcRX8c71EEFBGz2DaQ2hQPEoXVF
	 +ch2MG8/IXEBofW8gfNtmLrsqvhgFuO6ibnpepMCcv4vIT1F5nXuQ6ckNZ48vt3YF5i69
	 Ie2lmyCu2fPpR7si2Txd3qHOHRVqM+KpNZSVrQptpsI+4IEY/4C+ibC/L1I2B8Ly02dcm
	 RuvshHu2x67Iw3eXDBDOIbX0xHvdVVnFYJTd/i2U8fXhRjZ85ll+4H3iLhmHIDfEMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2aDVkC3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F3606A319;
	Wed, 21 Oct 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2aDVkC3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947C51F000C1;
	Wed, 21 Oct 2026 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608599;
	bh=UP7QKcZoxFf5ukFFf3zgd+8QVhw52yv+EUqhUUTfyb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F2aDVkC3wKHHTT76g49QPHNRr9iHNf/o3pj4tzGIUkjoh8OOPu5FE5dHowS0tIoef
	 sn3kug7+NGNfS8MV5OvoLU/mFl066DoydpisPFNekOWrs5ZaAe39iXy/ZFdXdmzTPi
	 hwyMD2j1eAp5ibjgRP5VOD+Nl8WTYFIn3AEdo2mDWJ8O5tP3NQyiYPcPGRA4xk/HDc
	 N9Ylbfroo/g6m6RCa/p0EVOpUoP8ORnGDu59yLEvf2htR+5ppugdyp6xEZVFb8C998
	 DEPbgu0vyxON++1Kdf6Bn53W9ORsSFaYYwtpSIvdf8SBFXm/chMV4KwJRob9Jn09qh
	 5ol4dDmCmogZw==
Date: Wed, 21 Oct 2026 19:49:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Ulf
 Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return
 values
Message-ID: <20261021194951.7b65c2eb@jic23-hlaptop>
In-Reply-To: <ataTYER7XM_MEYKL@google.com>
References: <20261006231900.3230373-1-briannorris@chromium.org>
	<20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
	<20261018211807.66bfea0d@jic23-hlaptop>
	<ataTYER7XM_MEYKL@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 15:02:08 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Hi Jonathan,
> 
> On Sun, Oct 18, 2026 at 09:18:07PM +0100, Jonathan Cameron wrote:
> > On Tue,  6 Oct 2026 16:13:31 -0700
> > Brian Norris <briannorris@chromium.org> wrote:
> >   
> > > Multiple IIO drivers inspect or propagate the return value of
> > > pm_runtime_put_autosuspend(), which is not particularly useful.
> > > 
> > > Returning an error code from pm_runtime_put_autosuspend() merely means
> > > that it has not queued up a timer or work item to check whether or not
> > > the device can be suspended and there are many perfectly valid
> > > situations in which that can happen, like after writing "on" to the
> > > device's runtime PM "control" attribute in sysfs for one example.
> > > 
> > > For this reason, modify these drivers to simply discard the
> > > pm_runtime_put_autosuspend() return value, and change the return types
> > > of fxls8962af_power_off() and fxas21002c_pm_put() to void.
> > > 
> > > This will facilitate a planned change of the
> > > pm_runtime_put_autosuspend() return type to void in the future, similar
> > > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > > type to void").
> > > 
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > This patch is independent of the rest of the series, except for the end
> > > (changing the return type). I expect it can be applied by individual
> > > maintainers, and we pick up the end once the dust is settled.
> > > 
> > > I couldn't decide if I should split this up by individual driver, or
> > > just 1 for the whole drivers/iio/ subsystem. Many of these drivers have
> > > borrowed the same patterns, so I chose to just send 1. Let me know if I
> > > should split it up.  
> > 
> > Hi Brian,
> > 
> > Great that you are doing this, but sadly it opens the can of worms that
> > are the helpers a lot of these drivers have.  They just about made
> > sense before various recent runtime_pm useability improvements.
> > Now they make very little sense at all. Dropping the return value
> > here also removes the reason for a bunch of odd defensive ifdefs.
> > 
> > As such, I'm requesting some slightly more involved changes. Some of
> > them I think are coupled tightly to what you are doing here so should
> > be in this series, others can be left for later.  
> 
> Thanks for the notes. I'll handle the ones that are at least
> approximately related to the code I'm touching. I think there are a few
> bugs that get resolved along the way too.
> 
> I may not get the more tangential ones though.
> 
> Also, unless you'd prefer otherwise, I plan to wait a bit more to send
> v2, since the merge window only just opened, and some of this series
> will just be a RESEND. I'd prefer maximizing the chance that the
> recipients will actually notice the patches, by submitting outside that
> window.
> 
> (OTOH, the bulk of these changes are in IIO, so I can just make IIO its
> own series if that helps things along.)

I'd split out an IIO series but take your time as no particular rush
given these won't merge until next time around.

  
> > > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > > index d611341a0e2a..e8e511daa7c4 100644
> > > --- a/drivers/iio/gyro/bmg160_core.c
> > > +++ b/drivers/iio/gyro/bmg160_core.c
> > > @@ -319,18 +319,15 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
> > >  	struct device *dev = regmap_get_device(data->regmap);
> > >  	int ret;
> > >  
> > > -	if (on)
> > > +	if (on) {
> > >  		ret = pm_runtime_get_sync(dev);  
> > 
> > gah.  Please just change this to use pm_runtime_resume_and_get() whilst you
> > are here.
> > 
> > Ideally squash the helper in favour of direct calls to the runtime
> > pm.  Yet another pace that the recent improvements in runtime pm useability
> > have made what was of minor benefit entirely pointless.
> > 
> > The ifdef can go away as well as I think the only thing that helped with
> > was the return value of the put you are removing.  
> 
> One thing I found while looking through this driver:
> 
> bmg160_write_event_config() and bmg160_data_rdy_trigger_set_state() do
> some ghastly things w.r.t. runtime PM. In particular, they seem to
> perform put_autosuspend() *before* they're done touching the hardware,
> and then rely on the (very large) autosuspend delay to defer the
> runtime_suspend() operation. It even has a bunch of comments about the
> incorrect ordering.
> 
> That's one giant race condition. And the autosuspend delay is
> configurable via user space, so it's extra dangerous.
> 
> Anyway, that's to say: I plan to refactor/reorder the put_autosuspend()
> ordering there while I'm at it.

Excellent!

> 
> (There's also some strange error handling that potentially leads to
> runtime PM underflow. I'll fix that one while I'm here.)
> 
> I think this one is imitated in another few drivers as well.

yeah.  We do seem to cut and paste bad practice and bugs around :(

> 
> > > -	else
> > > -		ret = pm_runtime_put_autosuspend(dev);
> > > -
> > > -	if (ret < 0) {
> > > -		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
> > > -
> > > -		if (on)
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
> > >  			pm_runtime_put_noidle(dev);
> > > -
> > > -		return ret;
> > > +			return ret;
> > > +		}
> > > +	} else {
> > > +		pm_runtime_put_autosuspend(dev);
> > >  	}
> > >  #endif
> > >  

> > > diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> > > index c0f4db8d95f7..d4e197e05d26 100644
> > > --- a/drivers/iio/light/pa12203001.c
> > > +++ b/drivers/iio/light/pa12203001.c
> > > @@ -188,7 +188,8 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
> > >  	if (on)
> > >  		return pm_runtime_resume_and_get(&data->client->dev);
> > >  
> > > -	return pm_runtime_put_autosuspend(&data->client->dev);
> > > +	pm_runtime_put_autosuspend(&data->client->dev);
> > > +	return 0;  
> > 
> > This function has evolved to the point of silliness.
> > Given how minor your change is, feel free to ignore the following however!
> > 
> > There is zero shared code in here between the on and off paths so
> > rename the function pa12203001_runtime_enable() and cover only the
> > 'on' case.  Then just put the pm_runtime_put_autosuspend() in wherever
> > on was previously false.  
> 
> Ack. But because "runtime_enable()" has a specific runtime PM meaning
> that is very different than the usage here, I've chosen the name
> "pa12203001_runtime_resume_and_get()" instead, which I think makes for
> more API symmetry.

Good point on naming.

> 
> > Given that presumably one of the things is being turned on whenever
> > we enable it, also pull the mutex out of the if blocks and use
> > guard() to simplify that.  
> 
> guard() is tricky, since it produces a deadlock if you hold the lock
> across pm_runtime_resume_and_get(). So I'll skip that part and leave it
> to someone (or no one) who is more particularly interested in this
> driver.
Ah indeed. Should be scoped_guard() but can wait for someone else
who cares enough to do that and maybe not worth it anyway.  I got
lost in imagining what the other refactors would look like.

Thanks,

Jonathan

> 
> > >  
> > >  err:
> > >  	mutex_unlock(&data->lock);


