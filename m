Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860A3E5A37
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663109; cv=pass; b=nEuofBjzdPfFPgFkUYyOJghqy/fa71glNl14xZCphyOrXwWGIOEucdYSo4eRDJBTaj5m6iWSBdeTTXLSs18PqqLT1K38SW51QC20Tv1xVMLwFM7YBxEaHho/V5e0LOV70UmLnv7MXUGQp2IyeYXTTEiY9Z16zU/KoyhGPuUyLSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663109; c=relaxed/simple;
	bh=HVbPGmpsziIklRB2aj6jw58N/M9msEmJ9NtCMs5V62w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCQyBX8EgV2frB481QR8u7EewLdMq/V0iXnOCY7dlhvm12pNk0/rHSLnILFYm89aTQW56ZwIpnfVvKCmbfdPNrtmmtjKe8AnOqYrSmF9moJSSiKuhRFiLCAzLQyyGogD+lmcJq+e6WFdcu3ekLBvGuyuLVN6CghDck6HAFsFbts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=frs24xHO; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frs24xHO"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8d648466bso4067744e87.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 02:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778663104; cv=none;
        d=google.com; s=arc-20240605;
        b=LjPJm4T61ZLu67Y3m1D66jqp38yZbv5HB4KcNFUBAhqHNRY+0xKTHfhsiRlm9c82fC
         IOh88+3tBC7srN9r9RV+Y6EW+buS8M6gfZ0aALfPGQtwnhZDhDJnSCBVqv2H5Ozt5D3B
         LW1Vw3uhcP1XY8wCCH+Uc0dtA1yFeErW9lztgVc85Z5LOoajeMuEstjVDZL4gscM3X1G
         94rB5VxNyuL3N4AG4pq3AuENVXM1IBZ3v8PaMTyv3J9FJPZGuA0LoaUzfT6/y/dyMYdw
         wFQq2p7b1mWvX7kCq4QK2vrzKu0SQE6ZFbU45Z8txd/lJLIOsqzGXeCMz3i6GKjkzM3/
         9eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnSmxQtTUWEiFFU6qH7Iz8bWADJPw/bCswxBgGjsIdY=;
        fh=qbgpKcc0GvxWrYUTJjgPWrGgOHB0BL9omClDqpiifwE=;
        b=RXE81+G6V4xUh17buFq/QhnQ6mNow5igPT09Oioa9ww8g4LmknG8VAycHxReMD53Bm
         SgF87eMntZMuAAj6ifVqgdhh18h3iHLgtuhwhfgqiLaJmEKXzsx+Alk7klHfy2Ivc+xf
         VxxwJVJXYJjknGI14xwoNbHH7ulxggc8hVUyzRRHoXct4wyQMIDpstk1GI+iQEidLZlE
         UgYvu+0mTpFBrcaAOWeiv8TTsj5/gme8oVZ7wJHXd4PSUFhyKqXdTxKWDk3EJvDfFCsb
         qfGyrManSGO5malgDZ8CKsWuV4+QK+qkFu/xKh7jhJ9VmcVxHdJ4YE8IVPrryUH+ZXw8
         RkJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778663104; x=1779267904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnSmxQtTUWEiFFU6qH7Iz8bWADJPw/bCswxBgGjsIdY=;
        b=frs24xHO6deIZSc9xZlYtYRcFJQ7cC1XNGgyjGwMejG5M1PdpmvL98kSMv/C/i4zVO
         eRD3sp8UK7C/l440l4J4Tc/bLoLhvu+dz51OiCUHzF5sGJBakVY9Imxd0IwAIiaCcVEn
         DMyh0svojq+LYt62fCZVNXMCTv2GqcRRl2MsLFmpUpm2xuiDZFFn9X1ex9F+W8YYGHc8
         4e0dm6qTo0dDmbK8rV/MR46euzScs/R6+OvE8FIQzQ+BNHjr2RR0uxEzueLHCSwzC6v5
         WQUsjh0ISYLEYI8IyhrodAR2O8qMh41Zz2vM9G8PBJ3mAJmGXHyHlplNaHTsK5KR4rVw
         HcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663104; x=1779267904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnSmxQtTUWEiFFU6qH7Iz8bWADJPw/bCswxBgGjsIdY=;
        b=lb09OMSUegStFByh5WlxbxCx8uLZWwaLChw+AphUhY8qt6zYQd51s8oX4NtEhZwdlp
         YdNq4P2nM7yJFwx6EZUdge0jaBfWjjXVeOTkdZWHNsEYoLN5VwDxu3ZTIEnO5hQx6rq3
         7FlSMooeSVk2ieYBRArn5fmPHiv2Urmu4f2Ma0ytsgW1tMS3T1rrGKReTZGBeAEvxROT
         sFTkTEa026Tg/aMEmzCs93fOlbWxWtTSLgTi9O5AtcmyjHIoW9GWa7Gydf8nS1hoGhh1
         FJma8K4Na6doQ30DkxwP+ALV1Lycv5CDxVktxusDQPpO0k/0bj3wWDt4nWPTcvDswuh3
         WMUA==
X-Forwarded-Encrypted: i=1; AFNElJ+5CrynB9wEoJ2SnkigqX4/pazNoYelSPhVdPyT4tLPIMxamDXlpwKtxIqEXSUdXqFqdd73tFYwHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fgpsxzhgh+e6WAVpbB4SM0Mi0cxuumG6z4xxLlQbY8FuTHPI
	8vAx1OU3JhpC+kjrGOSugJo1lwfOUGEaT9PtU4zU5oXztb7DmLMxxkkqII4UCemQypSRVvE9Z2y
	ODDCaUUJNicqeI+ygTv49xBL/BI81GzGSz2iXkJAGBw==
X-Gm-Gg: Acq92OEtjYbMkpsK/qPHXn+mi6xAEyukI0HldZ8YIUO/fMqKFOltnznEpEjyWFvrXXK
	As7P/6N/4GVX42Y5QYLNzIk07UA7j3ElibuxHIJowuWoiV8nNUm5jZNfsoJulwAvTaaxztBt5jE
	+ThCw2WWNgw06bps2j27MAw6bdKGB83N089Ooa2HlrQCvAi4D+6nBJfHj+r0CPwDI9VUWhQzvpZ
	j/u+kIshxpHz4qfMTeLFr2d6ra4LEu1aMexlj2pQsyAi4YjKqq+sae6oyAg3ff1Rlc8kwnQhR0C
	GLOubLSiUln7wUgC40oRZfN0M4dLDEdPbLzWHHuB
X-Received: by 2002:a05:6512:3c8b:b0:5a8:d648:4601 with SMTP id
 2adb3069b0e04-5a8ef99cc5amr878284e87.38.1778663103512; Wed, 13 May 2026
 02:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
 <20260508123910.114273-3-ulf.hansson@linaro.org> <CACRMN=fseD6-ODYnOEE42S9VKAb2F33kRv_VPYBGyPsitG2how@mail.gmail.com>
 <CAPDyKFq+F=zn_Coicb9LzyMtQ=b2Lrd+3Czx6r4ReY-DNyb9eg@mail.gmail.com> <CACRMN=dZFvbXjZGqTvFdNVyXfyvS6YtWNKQnej9A1jihGJHcqA@mail.gmail.com>
In-Reply-To: <CACRMN=dZFvbXjZGqTvFdNVyXfyvS6YtWNKQnej9A1jihGJHcqA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 May 2026 11:04:25 +0200
X-Gm-Features: AVHnY4IY1Hl3PHqVdEbwrzR1kYI3x6GJYuzpslvlmUfAwZ9a3eA_KZCjdMuftMI
Message-ID: <CAPDyKFpYkzmmx+d2-x0YskO0H2UD2v1LmZLMRqMmDoLSfPk8Xg@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Saravana Kannan <saravanak@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 at 07:01, Saravana Kannan <saravanak@kernel.org> wrote:
>
> On Mon, May 11, 2026 at 2:43=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Mon, 11 May 2026 at 07:09, Saravana Kannan <saravanak@kernel.org> wr=
ote:
> > >
> > > On Fri, May 8, 2026 at 5:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > > >
> > > > The common sync_state support isn't fine grained enough for some ty=
pes of
> > > > suppliers, like power domains for example. Especially when a suppli=
er
> > > > provides multiple independent power domains, each with their own se=
t of
> > > > consumers. In these cases we need to wait for all consumers for all=
 the
> > > > provided power domains before invoking the supplier's ->sync_state(=
).
> > > >
> > > > To allow a more fine grained sync_state support to be implemented o=
n per
> > > > supplier's driver basis, let's add a new optional callback. As soon=
 as
> > > > there is an update worth to consider in regards to managing sync_st=
ate for
> > > > a supplier device, __device_links_queue_sync_state() queues the dev=
ice in a
> > > > list, allowing the new callback to be invoked when flushing the lis=
t in
> > > > device_links_flush_sync_list().
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > >         - Re-worked the approach to use a list to queue/flush devic=
es for
> > > >         ->queue_sync_state(). This should make sure the device lock=
 is being
> > > >         held when it's needed, as pointed out by Danilo.
> > > >
> > >
> > > Hi Ulf,
> > >
> > > Thanks for working on this!
> > >
> > > And please bear with my slow replies.
> >
> > I will try, but taking more than 2 months to reply isn't sustainable,
> > I think. Let's hope you can get some more bandwidth for reviews when
> > moving forward.
> >
> > >
> > > > ---
> > > >  drivers/base/base.h           | 18 ++++++++
> > > >  drivers/base/core.c           | 77 ++++++++++++++++++++++++++-----=
----
> > > >  drivers/base/driver.c         |  7 ++++
> > > >  include/linux/device.h        |  2 +
> > > >  include/linux/device/driver.h |  7 ++++
> > > >  5 files changed, 91 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > > index 30b416588617..c8be24af92c3 100644
> > > > --- a/drivers/base/base.h
> > > > +++ b/drivers/base/base.h
> > > > @@ -196,6 +196,24 @@ static inline void dev_sync_state(struct devic=
e *dev)
> > > >                 dev->driver->sync_state(dev);
> > > >  }
> > > >
> > > > +static inline bool dev_has_queue_sync_state(struct device *dev)
> > >
> > > Let's please pick a better name. This is too similar to the actual
> > > queue function you call __device_links_queue_sync_state() and is very
> > > confusing. Maybe something that has a meaning along the lines of
> > > "another consumer probed". So, maybe:
> > > * consumer_probed()
> > > * change_of_active_consumers()
> >
> > The whole point of naming it "queue_sync_state" was exactly to refer
> > to __device_links_queue_sync_state(). The point is, the callback can't
> > be invoked unless __device_links_queue_sync_state() has been called
> > for the device first.
> >
> > Not sure why you think that is confusing? To me, that is rather the
> > opposite. :-)
>
>
> sync_state() is a callback telling the driver that it's okay to sync
> the state of the hardware with the software.
>
> queue_sync_state() means nothing to the driver. It's just leaking an
> internal implementation detail (name of the internal function) to the
> driver that's not really relevant. What you are really telling the
> driver is that some additional consumers have probed.
>
> > Before deciding on another name, note also that
> > __device_links_queue_sync_state() is called when resuming sync_state
> > from device_links_supplier_sync_state_resume() and from
> > device_links_driver_bound(). I am not sure "consumer_probed" a good
> > name that covers both of these cases; what do you think?
>
> Yes, I'm well aware of that :) The contract of sync_state() is that
> it'll come after a point where it's safe to sync the state. Not "as
> soon as it's safe" -- meaning no timing guarantee. Really, this is
> just to make sure sync_state() doesn't come before late initcalls
> (because a lot of frameworks make assumptions around it) are done and
> before all the top level devices are added.
>
> So, even today, sync_state() can come a bit late. In general, the
> driver framework doesn't guarantee immediate action. There is no
> guarantee that a drive probe will be called as soon as it's registered
> (if there is a device) and vice versa. The same will be true for a
> "consumer_probed()" callback too.
>
> Also, your implementation is literally trying to check which consumers
> have probed and which ones haven't. So something like
> "consumer_probed()" or "consumer_change()" should work well and is
> actually meaningful for a driver developer.

I have no strong opinion on the name, so if you prefer
"consumer_probed|changed", let me just pick one of them then.

[...]

Kind regards
Uffe
