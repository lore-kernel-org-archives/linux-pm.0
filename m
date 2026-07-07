Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7FF30E82E
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398558; cv=pass; b=gwl1dAZJ4u7ZFrC8dRtlpW2DinpVCmMIMqpYSZ6QJDHBzEp1GdcKh9JUGpiLcSjXr/O/5qfA2PKBWiKUAK+KHahXfcj37Yq3b2eeGwlFaDPl4FRTwIYJjPijNWaSMGQCO4yo6fsuMng2YPWJgjrM45R3+XG3gIkRRlRSHQrz62o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398558; c=relaxed/simple;
	bh=PSqME/IPugtczex5NRAm1XmhU5y/+03GI6oS0AsEg0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgkfs2m94W2qpyxhpIVA7lm3N9ifpJgNLm/Q1Kk75tCZewv5sqywbtmuhwZuLNbz9USddX+CMaIs6b2ZFyGwpeKt3fhBprJevt+4K1g5nD92bX/QA5EY4pJ+LaqRlelHwUw+XqwJsky/aZ+p8jL+i0ZjvhOeLRrL0jxhkOqBsX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S52CYQCo; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S52CYQCo"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d7863920so2963002d50.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 21:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783398556; cv=none;
        d=google.com; s=arc-20260327;
        b=aLh69Rua2hw4yTaTSTEmoe0YOels+3cY3ZD+TDe9RuZJntID4dPmLV7cv4lQfDkZys
         UDjgSxrHi0KF8x4AxkaTkic/kVoaU09DCyM7ZbLbeVDFOAoVQV7qqpZ0zuVWPRCuj7lS
         TfiDY0s4e/aoNKoM6ad3J++4G1UWxrj9Go2s05fX+MXZUvOZ7aQYWz9mFiadfb2xJY81
         f+kggMG1DPldcq1Xhpld9l5IL5y/YB5HV+AU5Zn1RKFOfwdov0Kznd1dkRTOAXHeKRM+
         vGjKJSyWDp0dvLLh7y/VrwFVWhj61BzTwuMHMLqxPhiy8IADMmxNXmHItYUJdbfgf9k8
         EAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        fh=R2dwNsqFNM3hJAdlyAR+WSarWzCRxJpjnpxSa1FRdZA=;
        b=RQVI5yVw26iu6IogmHMebxSoKpj+86fpmwkbNdQ6CxDHi3h2NBNPVZFZibGUFuaTvH
         kiyFpI91mfuW/iPGGHevojs3dmdr4pzhgIYozRWYGldzSK0UrxHCVa8bMIngsRdombkP
         jHzDCIwdxWR1acH68pJFnqiVYhE7u0Umo/12U6ncKKykWt6/TddDxHMGC17i5oMRbRNN
         9gsCPGUX3nqmpB04FCacc3q0h4AKSI1n/WDxpkh8SAn5qnIrODb7FomBMCCbznUCCuO0
         +YRCeK5vb61COnCorfzg0HL+p3/DASkvnqHkQmiyKYz+WJt3VwfyPlTDn8axJ8VygFuG
         n+ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783398556; x=1784003356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        b=S52CYQCotEH8dw3N4wHAkEvIGgiFgLyj8Ojw0yloH6rv4EsRH1/NXDuhCfIZEpAiQC
         ZRYNEp+gcPgEJMfIdlVEIu9mqaDJk7q0OIhMYpdFIXVGCSlfBkfekpao1lwjYzmcipib
         J35lfe6nc1sAxtwhNAT9CNHR1/iO9PltWiY1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783398556; x=1784003356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bHz8pIdj5qCHMVmE3ZgrvqBvuIVwQ8F/DhCqlx20Pk=;
        b=prIPP1EuRJJCruhpX1/CsP9Mxu3oidi4846mifVAY/VNBJtB0188KcxI5H4FfF5Mtj
         q+lNJl3/Cjb8OStpssS4pJuzvCD9s5MfwC8lJiT9yt+HugwKFZWn7mzybl2+hpyS4FkY
         5c5Pm41oeUXzZHXx5yJAghMkDo0LWNHcq5C1hQYcdox9aosHLGfyrFnQDRnLci8A+i3S
         VOi39n/mmQDEQOMkdPlT8nl2uxeHvqRMUzND+X1BWFSBfB2nOBP/siEYlQvsOV1hskck
         FPUnhgnl3/PcepYfvboSNU637np1oIB+t+TZCvqq+L7ZqFJpPwE968oaQ3DyuSRDMhec
         pMFw==
X-Forwarded-Encrypted: i=1; AHgh+RqGqbMKqUBJ5BqXA/hTHJg50qzLl2hwjXoCgyZAg/XvgqB8bqaKc33SpxEbZG3wF0AtZbxmxWPnEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwj4WJEELmZjrskJ+Hzx3isoK0p8wx7vfBhv7RAx+arHz6hPV
	MQ/xCWJlZRRkOsb12NooQ5W+N8PIFTnNcrXynua+ANZh44XHilSHYH49K2qU7H1CzkLw1U8ALdV
	jgbIkudGbxvO8zgnjdCtjKm7Wd6N+NzNwk7ZR0NaW
X-Gm-Gg: AfdE7cnXwez9yQn+qqeEMOaB+hk8x76PKTJ8nrZDZ0H44AHHrMTCgKdjMLYLdF0A+qI
	4YpzGO0oDoaPgs6RJIWPREAt7jWqlhIiK3xkadCj2QWmlcdqgDu1sVm/df+/EUXDdP4qHQ7g0Rr
	RyPxTjdw8RfjsswXl7U1CWQ1N96f7roxB00AvpMB/EeMXsQp6elJ4qjT8inKNZVBIQuPN2NqJ2c
	eDvpz2cIxe1A9axMxlmcNtIL7NK7nRMQRkQjdSrSiUsaaOKLXQVBgzKafwCTFR663GeMTvhlWLW
	tK8B+qRaUNeV9NYvzuzlDcyeZ6frzw03r9Jxwg==
X-Received: by 2002:a05:690e:4549:10b0:662:b6fc:ab84 with SMTP id
 956f58d0204a3-6677fa2ea7bmr2174279d50.17.1783398556262; Mon, 06 Jul 2026
 21:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-7-wenst@chromium.org>
 <ake09vk4fEv1D9QC@ashevche-desk.local> <CAGXv+5GNucSXrhL=YxarSJHD2ezzYDK3EovFu-zy012KgZ+ZBg@mail.gmail.com>
 <ake6FNy83LLtCs3b@ashevche-desk.local> <CAGXv+5EgpizA3Pc8ScNuChPhvFKWd5F6dxB-wT4-7EwabE-9dQ@mail.gmail.com>
 <akvRMcGnUPxE3sxR@ashevche-desk.local>
In-Reply-To: <akvRMcGnUPxE3sxR@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 7 Jul 2026 12:29:05 +0800
X-Gm-Features: AVVi8CeDQS-P0cN7_fGlNwSI_p7eUQN2BPzLo_iMICLRCJ8sboVGUDAVuWI9R6g
Message-ID: <CAGXv+5EqsDbzTg9eDMGK3Ph6Pe3_uDoSrjVL4q23cy6jZCk2tw@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to usb_port_is_power_on()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 12:01=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jul 06, 2026 at 07:08:07PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Jul 3, 2026 at 9:33=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Jul 03, 2026 at 09:17:16PM +0800, Chen-Yu Tsai wrote:
> > > > On Fri, Jul 3, 2026 at 9:11=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > > At a brief look this will be the only function that takes usb_por=
t
> > > > > instead of usb_hub in the entire hub.h (I don't count container_o=
f()
> > > > > as a function). With that being said I would rather see it to be =
moved
> > > > > to port.c altogether (yes, it's more invasive change, but looks m=
ore
> > > > > consistent).  I would even dare to move struct usb_port (and cont=
ainer_of()
> > > > > accompanied with that) and this function to port.h. This might re=
quire
> > > > > a separate patch, though.
> > > >
> > > > I agree with the reasoning, especially given the function name. How=
ever
> > > > I wonder if it would cause problems given the linking order. I'll g=
ive
> > > > it a try nevertheless and report back.
> > >
> > > Thanks!
> > >
> > > In case it won't fly (but I still think it's better to split), can yo=
u at least
> > > group usb_port APIs and struct? Means moving the proto closer to that=
 struct
> > > usb_port followed by container_of().
> >
> > Looks like it works out fine. port.o is linked in after hub.o, so movin=
g
> > the function from the latter to the former doesn't cause issues. One mi=
ght
> > even say that it is the correct thing to do.
>
> That's what I say! :-)
>
> > > > > Perhaps something like: 1) "move struct usb_port and associated A=
PIs to port.h";
> > > > > 2) "...this patch...".
> >
> > There are still some left in hub.c:
> >
> > static void usb_lock_port(struct usb_port *port_dev)
> > static void usb_unlock_port(struct usb_port *port_dev)

These are only used internally in hub.c as a wrapper for the port mutex.

> > static void port_over_current_notify(struct usb_port *port_dev)

This is only used by the hub's overcurrent event handler.

> > static void hub_usb3_port_prepare_disable(struct usb_hub *hub,
> >                                           struct usb_port *port_dev)
>
> This one takes hub as well.
>
> > These are used only in hub.c and moving them probably makes things
> > messier?
>
> Perhaps better naming to each (kinda moving to usb hub namespace)?
>
> > OOTH, the following bits are in port.c but declared in hub.h:
> >
> > int usb_hub_create_port_device(struct usb_hub *hub,
> >          int port1);
> > void usb_hub_remove_port_device(struct usb_hub *hub,
> >          int port1);
> >
> > Any preferences for these while we're reorganizing the code?
>
> These ones would be good to be in hub.c if there is no circular dependenc=
ies or
> alike.

Those two, along with all the static functions they call, ends up being
half of port.c. That doesn't help the size of hub.c, which is already
over 6000 lines. I think I'll leave this one as is.

Both this part and the remaining bits in hub.c I mentioned above are
outside the scope of this series. We can discuss whether they really
need to be moved or renamed.


Thanks
ChenYu
