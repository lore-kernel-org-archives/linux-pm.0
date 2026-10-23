Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726204;
	b=eSFa3ENR6T8ptmtGy3uoG++4s/SLe6/JWbH7wb+tApkv4DZ/4EkIBQ43QT2hPmCnzc04
	 nBLRxRsRDf0tPfAvnentr7Xdon9Gww/rDgyxmnabCDzcLy9B0s+v8UFAziyaD34T7Qtv2
	 WvIpy60/CY04thUn638nFRDnr+XJiD8KcQR6l1ID8fE0r9bLq8FGcdTWUe6HvrZKUF0C8
	 NnJvqWwpDBEoOSW2GYSLZwst9OymXadgPZACD9oiGr22+EBftbx92YymWWIpXPJrNPQ8+
	 0O/aL3QSYNw4F/vgBQahL2n2IfY3FTtYdyr7pY55pxc+WYlVwMkDVOdxNqg9Y9UGu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726204;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ynsZZCcsLCFsCT757HwPHQRAjd6MwLmnQSjGJ1BIZ1A=;
	b=HiGd1T5rlAuz3aVtaaqytre785fw4BCyqJHApKmV83Ioav0dt4Hdssuwn9nAKwfPath0
	 6cBpUIApUa7ANR1UNDw0qVefSaiUZB3n2cdqO64k185YQkqf7osYDm5/pSgyyNrP5AeNa
	 8O9WB939yzsGzUjGaktdH8T486rSKxNrtFxOCJyvKKBx3Igqhre1a1zPNpR/aW22I4ajG
	 o+1g5V+7WuTrZmYD461EoueL3g39wYyhak0S76votRLChI041diUY9EfxnaXORrs7f7QJ
	 6eKFDOERDRZQq0ksIvRq+KViqQ+on+kzLocWtHk5hjut2aNWiKRpf2Bo+BDltmPxJ7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiiMnBCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589A606A31B;
	Fri, 23 Oct 2026 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiiMnBCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E9C1F01828;
	Fri, 23 Oct 2026 03:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792726204;
	bh=ynsZZCcsLCFsCT757HwPHQRAjd6MwLmnQSjGJ1BIZ1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NiiMnBCYJ4Ys87/O/nXLjjUsqE0+n75ydgPxssKp9jIyGehILWge6/HRjHxmiFOZe
	 0YzWA51z/a5Ca1FI+w/gTcaquRTRahI+fL8Cu2ovZ3vVyrM4YMwVamzaLh3SghZWnG
	 Dw9sutYa56KEEzToMKs2kjDm+7EAIE543V37ruklhgiF7YniaT/+VmIqp2xeRo0ra5
	 282+O1VdNN5bW9v9EhPryLiDDX+MH+N1Z48GenseFllM99qxp1TXHhjWyVAJclxpL6
	 WwTbuFZRb2ABDHZL/auAiH8LnK7khzI0xFyeHSjvQDVZLjjuWNQNCtw/LYWC1gnQ90
	 P+i6Uu+LFecwA==
Date: Fri, 23 Oct 2026 04:29:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson
 <ulfh@kernel.org>, linux-pm@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] iio: accel: fxls8962af: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261023042954.25959392@jic23-hlaptop>
In-Reply-To: <atpNLy6Tb46hroHf@google.com>
References: <20261021235818.3059519-1-briannorris@chromium.org>
	<20261021165858.v2.1.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
	<atmy2Db_DlLUuOeC@ashevche-desk.local>
	<atpNLy6Tb46hroHf@google.com>
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

On Thu, 22 Oct 2026 10:51:43 -0700
Brian Norris <briannorris@chromium.org> wrote:

> On Thu, Oct 22, 2026 at 09:53:12AM +0300, Andy Shevchenko wrote:
> > On Wed, Oct 21, 2026 at 04:57:02PM -0700, Brian Norris wrote:  
> > > This driver propagates the return value of pm_runtime_put_autosuspend(),
> > > which is not particularly useful.
> > > 
> > > Returning an error code from pm_runtime_put_autosuspend() merely means
> > > that it has not queued up a timer or work item to check whether or not
> > > the device can be suspended and there are many perfectly valid
> > > situations in which that can happen, like after writing "on" to the
> > > device's runtime PM "control" attribute in sysfs for one example.
> > > 
> > > For this reason, modify this driver to simply discard the
> > > pm_runtime_put_autosuspend() return value, and inline the
> > > fxls8962af_power_off/on() helpers to their callsites, as they're even
> > > more trivial now.
> > > 
> > > This will facilitate a planned change of the
> > > pm_runtime_put_autosuspend() return type to void in the future, similar
> > > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > > type to void").  
> > 
> > ...
> >   
> > > static int fxls8962af_get_out(struct fxls8962af_data *data,  
> >   
> > >  
> > >  	is_active = fxls8962af_is_active(data);  
> >   
> > >  	if (!is_active) {  
> > 
> > Why do we have this check at all?  
> 
> Frankly, I don't know. It seems logically wrong; you shouldn't even be
> reading device registers without first grabbing a runtime PM reference.

In this case the runtime suspend is all about accessing registers
as it's putting the device into a low power state. Not removing the power.
So the same access is used if runtime resume occurs.  Hence this is safe
but probably pointless.

My guess for why it looks like this evolution.  There was probably something
more complex in power_on that has since gone away.

Whilst it should be fine to drop that check I'm in agreement with Brian
that it is a more complex change, so getting a bit risky without
an means to test.



> 
> But I'm also loathe to go tweak a bunch of driver-specific details I'm
> completely unfamiliar with, when my main purpose is extremely simple --
> to stop checking one return code.
> 
> All in all, I think this is beside the point, and I'd rather not try to
> address it in this series. For one, even if I try to address it, there's
> more chance of regressions that will distract from my purpose.
> 
> > > -		ret = fxls8962af_power_on(data);
> > > -		if (ret)
> > > +		ret = pm_runtime_resume_and_get(dev);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to power on: %d\n", ret);
> > >  			return ret;
> > > +		}
> > >  	}
> > >  
> > >  	ret = regmap_bulk_read(data->regmap, chan->address,
> > >  			       &raw_val, sizeof(data->lower_thres));
> > >  
> > >  	if (!is_active)
> > > -		fxls8962af_power_off(data);
> > > +		pm_runtime_put_autosuspend(dev);  
> > 
> > If it's active my understanding that runtime PM keeps device already resumed,
> > so these two will be just a reference counting calls, no?  
> 
> Right. I don't really see the point.
> 
> Brian

