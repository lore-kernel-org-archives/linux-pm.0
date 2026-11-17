Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886100;
	b=JRa1wgZZj4mAyRndNMdd/H618BV99jRE5i1JTizEA40ruCwffnr/l/tzkgl7MkuTZgIM
	 +Ow5In/WARcqUUe54XA04WirY4JSDXaTTPlxhHsH6jBGZ4/eA9SCKJEqQmMDDRgYsQI2d
	 hwcodjlSySKsuJt2qpNpynSws+y011dkmO6IEexyTsqKoyeWtSaEHiuACVYtLpnHyJagd
	 rJbMCNCQ2jdyGM4MiuMprwzqhRqFCf/I2e4CkMyEoP2J+X+xnEXWFfaOZkxWVOKEwX3m/
	 xMU0Scy+ZjjWyHu2Uh5UijR420rLE7P5VKmYiTRFhOlfT8Sl0aKbZELfzztzf7ujDEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886100;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c0JsWQXNXPSYKzypC+IrZwI9PieUjCX9McZxnu5scXA=;
	b=NK+PLk/awJezFcIApo1pmcCrr/5b6+//b0NraIiIvl5TsbptkajdYXUZkLi3cgmbzW8J
	 0PUaMWEQtrtNQ4SmR/8tK23dl31wAtZsG8awo/SaGTBc31SuccS3YX1pyvBpyTsa7vjh8
	 QTUFYVCPHRPQe5U/iBWtKlOCRCGIxd2wK0bw7TPOGjq8/Ub5HD+Sjhda1q0ZT4FZKVDUy
	 NRxGQveKRKx/LvUwVQl+11ZtzPdnZy2At6EnJq+djUE8husFzY6267dt7OwkH3mxdmRIH
	 rmLAE/MURmINAgFzBWQU/PH9RP54uaiFtSZq6gNK5r6yQJggpmggp43OrKL4Omsnjsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMQhrl2E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39878606A31C;
	Tue, 17 Nov 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMQhrl2E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611071F000C4;
	Tue, 17 Nov 2026 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794886099;
	bh=c0JsWQXNXPSYKzypC+IrZwI9PieUjCX9McZxnu5scXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TMQhrl2EWsZgpDJ6bcnpK/K80l7WwJtd9i89BBWLb1kSSnwxbIcvK8pBEo/gaINFt
	 KvYUohbr0vGSOb1uVPu+jolFwW13MvxyTTOG0aWJXtdsqu3gQvG4oRSlMT7/ufG1aY
	 O6dYTBLLoYhFYEt4VHrtglsmmRnB2UUVec0+dfLB9aYNBp5OR2/+aw7QLDzy1+1rnA
	 BBLSp+NFki4nJPubEJT9wF9Sli9k5lPbo2Gw5kpv/B1BMMx+89xEZ125PFtDYl8zKN
	 +jlr2eLZp3J5KZ9Qw14rO62OOA/SHQfZfLf9tYCdAV0STEWGsMe7N2jmBIv8xTji2f
	 4eT1EXF8a5bsA==
Date: Tue, 17 Nov 2026 03:28:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, linux-kernel@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3] iio: gyro: bmg160: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261117032814.2db03e9d@jic23-hlaptop>
In-Reply-To: <avSx8m0KegrXO8D4@google.com>
References: <20261102014830.679216-1-jic23@kernel.org>
	<auj9j3sbYa4sVoil@google.com>
	<avSx8m0KegrXO8D4@google.com>
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

On Wed, 11 Nov 2026 10:20:34 -0800
Brian Norris <briannorris@chromium.org> wrote:

> Hi Jonathan,
> 
> On Mon, Nov 02, 2026 at 01:16:02PM -0800, Brian Norris wrote:
> > On Mon, Nov 02, 2026 at 01:48:30AM +0000, Jonathan Cameron wrote:  
> > > --- a/drivers/iio/gyro/bmg160_core.c
> > > +++ b/drivers/iio/gyro/bmg160_core.c  
> 
> > > -	data->ev_enable_state = state;  
> > 
> > This is an unexpected (to me) delta vs v2: you've stopped setting
> > data->ev_enable_state here. I think that's a regression.
> > 
> > This is also one reason I think it's unwise to make so many changes
> > together here. One person's "churn" (to apply several patches to similar
> > code) is another person's "hard to review / easy to make mistakes".  
> 
> Gentle ping on this one. I'd like to advance my
> pm_runtime_put_autosuspend() series one way or another. I'm willing to
> respin this one for you if you'd like, even if I'm still personally
> hesitant to make so many of these changes together.
> 
> I'm also open to going back to a minimal series -- that only drops the
> return codes, and inlines functions that are trivial candidates.

I want to find a bit more time to look at these. No rush yet given
we are only at rc3.

One advantage of being the maintainer is I can always pick up
the simple version you first posted at the last minute so that
we don't become a blocker on forwards progress in general.
I'd like to do better though if time allows.

Jonathan


> 
> Your call.
> 
> Brian
> 
> >   
> > > -	mutex_unlock(&data->mutex);
> > > +		pm_runtime_put_autosuspend(dev);
> > > +	}
> > >  
> > >  	return 0;
> > >  }  

