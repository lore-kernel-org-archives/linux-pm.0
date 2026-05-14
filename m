Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7E381C4
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717110; cv=none; b=MwnXtz9GG6UkErTycbGwV90tMj70/w4/S7Kj4LXFQIxHaM1f+XZgMterHalUHUBHOhNrt9WN+15DfT1z2ClBN/Dce3wjQs78uiukvXu1p1U6mIpN4zMq9zSDSqSfCFg2ZwRYlhTeAe0KsSstxhbLVu7DExS6joflbssxSTwvtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717110; c=relaxed/simple;
	bh=fKZ3CvKEmWz4+/oeIHxkB/mW5xs10t3qGPYefEwGd5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXogQu1eTscVrz8ZWYfmcDlRwih+dq64X1fP4k1Z1oNipIz1iwcmA8fNKWfgqTVpslqSK0XOILQi71fzb194xfWLpBXskJxbPxC0JWenajXq7wf9PA5iQAkXm3Dahg29L72MPDRXxnohv4daiQwy3Pneh9W9Vt9UxAp4PeEGwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNA3xk2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNA3xk2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA34DC2BCFC
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717109;
	bh=fKZ3CvKEmWz4+/oeIHxkB/mW5xs10t3qGPYefEwGd5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cNA3xk2/2JDDfZ/BZSO0I1jN0RZJ8+pBuQjzr1SBsHlRVj+uBdw1Qmb1kU0u3e034
	 dXa4aY9k0Lc1SGwX2Bcz447qxPoKgsAd/wCYbg7+DnJGbIUUa67XrsHDERmULcHjc9
	 YS9ET2x7IuOdfyxfkSKdCrPxZR4oXIwQxalsmVSFTF5zr4PqywtZ68hP4VrxybQBLc
	 PTp5kdSQoZi2Fzcv1pkh+NaO/58zCrbO34YO8wd2OoXXEBwIZIIJWh8Wr0KRcduQ3P
	 hFyaI42Br9zNNQSBMGSYRK6qOqB8Qm9zjvw1lR9T54Kajd3L15JfXl5ItJ0B8KWyrd
	 hnTpUK1L68WSw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso7351571a12.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 17:05:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+I4lm5bUgrBfgraVrKANWym9kzwXHNmchFSHsuNNqn9yNaJBSnUhnXdPzTZTQkOmZwCrWXhzVz2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVQUAJp9GeCqpbUYelwSHnAGwpXBK/uyu07Aw681GPKzH3WaC
	gOmynRwIoynpRnG3kshkiFjfCYd+B4nfgX7TuVHEaQVfVpkAKDDpxHxx1CE/x8Nb77gASycR9rk
	G4ak+TzNaQvnlXcHfkJkGNFj3Zq7E8+Q=
X-Received: by 2002:a17:906:fd8d:b0:bd3:897c:7800 with SMTP id
 a640c23a62f3a-bd3dfb605cfmr337600766b.15.1778717108461; Wed, 13 May 2026
 17:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org> <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
 <CAPDyKFq+F=zn_Coicb9LzyMtQ=b2Lrd+3Czx6r4ReY-DNyb9eg@mail.gmail.com>
 <CACRMN=dZFvbXjZGqTvFdNVyXfyvS6YtWNKQnej9A1jihGJHcqA@mail.gmail.com> <CAPDyKFpYkzmmx+d2-x0YskO0H2UD2v1LmZLMRqMmDoLSfPk8Xg@mail.gmail.com>
In-Reply-To: <CAPDyKFpYkzmmx+d2-x0YskO0H2UD2v1LmZLMRqMmDoLSfPk8Xg@mail.gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Wed, 13 May 2026 17:04:57 -0700
X-Gmail-Original-Message-ID: <CACRMN=ecKDQPTvBFOxukodq-n87G0eE-gKrJpMSnBVg+ECS7JA@mail.gmail.com>
X-Gm-Features: AVHnY4KA3ly_Sb8EybV6Zuiap53KAX57UpEaxPTX2pvCtMlxPfvoP6wHKC3FClg
Message-ID: <CACRMN=ecKDQPTvBFOxukodq-n87G0eE-gKrJpMSnBVg+ECS7JA@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:05=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 13 May 2026 at 07:01, Saravana Kannan <saravanak@kernel.org> wrot=
e:
> >
> > On Mon, May 11, 2026 at 2:43=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> =
wrote:
> > > >
> > > > On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > > > >
> > > > > The common sync_state support isn't fine grained enough for some =
types of
> > > > > suppliers, like power domains for example. Especially when a supp=
lier
> > > > > provides multiple independent power domains, each with their own =
set of
> > > > > consumers. In these cases we need to wait for all consumers for a=
ll the
> > > > > provided power domains before invoking the supplier's ->sync_stat=
e().
> > > > >
> > > > > To allow a more fine grained sync_state support to be implemented=
 on per
> > > > > supplier's driver basis, let's add a new optional callback. As so=
on as
> > > > > there is an update worth to consider in regards to managing sync_=
state for
> > > > > a supplier device, __device_links_queue_sync_state() queues the d=
evice in a
> > > > > list, allowing the new callback to be invoked when flushing the l=
ist in
> > > > > device_links_flush_sync_list().
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > >         - Re-worked the approach to use a list to queue/flush dev=
ices for
> > > > >         ->queue_sync_state(). This should make sure the device lo=
ck is being
> > > > >         held when it's needed, as pointed out by Danilo.
> > > > >
> > > >
> > > > Hi Ulf,
> > > >
> > > > Thanks for working on this!
> > > >
> > > > And please bear with my slow replies.
> > >
> > > I will try, but taking more than 2 months to reply isn't sustainable,
> > > I think. Let's hope you can get some more bandwidth for reviews when
> > > moving forward.
> > >
> > > >
> > > > > ---
> > > > >  drivers/base/base.h           | 18 ++++++++
> > > > >  drivers/base/core.c           | 77 ++++++++++++++++++++++++++---=
------
> > > > >  drivers/base/driver.c         |  7 ++++
> > > > >  include/linux/device.h        |  2 +
> > > > >  include/linux/device/driver.h |  7 ++++
> > > > >  5 files changed, 91 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > > > index 30b416588617..c8be24af92c3 100644
> > > > > --- a/drivers/base/base.h
> > > > > +++ b/drivers/base/base.h
> > > > > @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct dev=
ice *dev)
> > > > >                 dev->driver->sync_state(dev);
> > > > >  }
> > > > >
> > > > > +static inline bool dev_has_queue_sync_state(struct device *dev)
> > > >
> > > > Let's please pick a better name. This is too similar to the actual
> > > > queue function you call __device_links_queue_sync_state() and is ve=
ry
> > > > confusing. Maybe something that has a meaning along the lines of
> > > > "another consumer probed". So, maybe:
> > > > * consumer_probed()
> > > > * change_of_active_consumers()
> > >
> > > The whole point of naming it "queue_sync_state" was exactly to refer
> > > to __device_links_queue_sync_state(). The point is, the callback can'=
t
> > > be invoked unless __device_links_queue_sync_state() has been called
> > > for the device first.
> > >
> > > Not sure why you think that is confusing? To me, that is rather the
> > > opposite. :-)
> >
> >
> > sync_state() is a callback telling the driver that it's okay to sync
> > the state of the hardware with the software.
> >
> > queue_sync_state() means nothing to the driver. It's just leaking an
> > internal implementation detail (name of the internal function) to the
> > driver that's not really relevant. What you are really telling the
> > driver is that some additional consumers have probed.
> >
> > > Before deciding on another name, note also that
> > > __device_links_queue_sync_state() is called when resuming sync_state
> > > from device_links_supplier_sync_state_resume() and from
> > > device_links_driver_bound(). I am not sure "consumer_probed" a good
> > > name that covers both of these cases; what do you think?
> >
> > Yes, I'm well aware of that :) The contract of sync_state() is that
> > it'll come after a point where it's safe to sync the state. Not "as
> > soon as it's safe" -- meaning no timing guarantee. Really, this is
> > just to make sure sync_state() doesn't come before late initcalls
> > (because a lot of frameworks make assumptions around it) are done and
> > before all the top level devices are added.
> >
> > So, even today, sync_state() can come a bit late. In general, the
> > driver framework doesn't guarantee immediate action. There is no
> > guarantee that a drive probe will be called as soon as it's registered
> > (if there is a device) and vice versa. The same will be true for a
> > "consumer_probed()" callback too.
> >
> > Also, your implementation is literally trying to check which consumers
> > have probed and which ones haven't. So something like
> > "consumer_probed()" or "consumer_change()" should work well and is
> > actually meaningful for a driver developer.
>
> I have no strong opinion on the name, so if you prefer
> "consumer_probed|changed", let me just pick one of them then.

Thanks for taking my input.

I'm thinking "consumer_state_changed()" would be good because:
1. Not using "probed" because we might need to send this in the future
when a consumer gets deleted.
2. Adding "state" because "consumer_changed()" could be mistaken to
mean the actual consumer(s) changed.

With that said, I don't have a strong preference between
consumer_probed(), consumer_changed() or consumer_state_changed().

Thanks,
Saravana
