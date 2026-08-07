Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE529389DF3
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131250; cv=pass; b=rMQRXMHDG0oR3LbQ/ED75Woq9OdGYInAvetxVcBu4mVYhrqmjfVGbnyotiVgdA73ZUW2XD5fVHgsuNS6pM4hU0KUXlAhuzPE8D6jYV1BFYFJbdMzKWlCfKMOxsgtetR5h76V5axGQEvuNXj4uE4kvasWkeaiiYdTQVAzSNR49YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131250; c=relaxed/simple;
	bh=U6y2778gV/zoZJ4mqp5v2pm/RGDs0J8HINfVltgsuYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZajRb1MZahtMpecB8SdNUMx2jRXjqhZ1dRoXru0bNmLkKKqr+Zp/6uf0IJAAoqg7GNgWztmrctRpzm8m6bmfwBUoNT83SeQl6rulcZ7XlomVgvVxbDWHG3a7L4OAA2QEreUaG+Kab1n6XWZxpmnbgAifUSw/U6LwVg1iBnmFeXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if9oZXL2; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if9oZXL2"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7389cff36bdso993903137.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 12:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131248; cv=none;
        d=google.com; s=arc-20260327;
        b=UgUaNhyfIhvqv6zJcFczIrLCxyB+MHvBSDTctj/JgPCa3/784ej5kvSnY7XIT4qams
         o3zySxfCS7dJlnZ/9Q70DgWs04P5NKBK/rhoKVnyP+pHcNdFV7livHmG6fX5eVE4qA2D
         MkNaRGTU2QdY8egJT9rcyQn0xicpC96t2qJ8XoADopgxrMIZ5mVao7Tax53ct7OHZZI6
         YBL63BubfpKWGEd8nMqUp+uAFrvoKZvVGFc6Nb8jetWy5HoB0kegMkI1tC5DI8iXeVq8
         2gOesBEbKaXMhzENCt1Hx99meOThUF4ZWxpCaMBjNlFv6hGstldsWUv1YuDT/HmR4D4d
         O/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        fh=YDVCfHHevRc+F5dth4NcRzk4CY8PlgBoTtn13GCb8RI=;
        b=XnvmuVk8xDloyCLQgL/C52TXRdnbHzGgVlK5BSGDZv2vQRzyqzGaBTDUWBj1ZtxycJ
         S6Qq51ttd5ZrJipE9foXpIE/bFnosru199qarARc1SUttgyPPKPahaKHkAKIpL+RiCmT
         XuDP3KI88OQf2ZWXBqI/FXbsq0vW+nC/bED9bbd18FNi2Q4tNLFVmxXG3aN//TTa1Nsx
         pm4MJqcdWrZxcff+7t+2uCyLHWmdroJjurYDfaQJcHDrAlc+OmTMV2KfpN3z7NGnMeqb
         Mfg3S1gTyABTc1x/yzN3QADwbuB/HAOpU/4NP+NcFVVAW56YGocDttS+ccUOhLQz0kcC
         dezQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131248; x=1786736048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=if9oZXL2QnHfigqUiImu8fydZDDmfepU1ziHSDHwg7vyx4Xxy/XF34gEbxEUmIxlYr
         9lnAor71qGZtrcZ1O/AuT3Xh/Tnc00I0GrcxCDbiovj7vYoBlf/wWyIU5iX1MDNuAiQr
         sR2mxMFCsueH4zaYb4l9jPB6vDN/lJ7pzUNYfgfGxdGHxEYSUB3e84igBa/7w/KH9aOJ
         ljGKoZxmOvtGP7U7YTOighKHbaO/0ihPftlNtXN6NW95qC1Wt35lfYcdtYDNkzgNH4Zx
         UkEwMMrpGixtIM0fpafEEGuwKs4sIkmPozmk2RMLVOphB//8Eh5HDdpWeDByOxTwmbol
         x4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131248; x=1786736048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=H39oLdTwc+D4UtMwogMZ1TJodyFUjiJ7IbAjofNQRA6nr5RdF/VFqgBla6XAEqS87j
         9V9PC0i9Q9qlN0oyAZLEg4IqL1/EVokEXQy1c6D16np1pkXd3K2tuUB61qKI1dFHXs1E
         EcFqSr9+tTgvAtyXBKsq5523aOAt5FTXrM+RG75wLvLsMcpzkTYt45NxdVC6BHLsqISq
         EpUG/LRB/KNFhVbr4HvZDs5CRQfP5lV5xz4azt9K0pvH+NTx8nXflyLUjY9j5fsUPYZ0
         Gv3VOz36Yr2Xnc/IVXH1FNfRjwqTWSSjxsSXZyWJyqd0xu+XUJnRFz1mwpxU3zOwl97g
         ZH8A==
X-Forwarded-Encrypted: i=1; AHgh+RqXCTap/zXq2K/V5vhX8R5QmhXa/zJox2ldJ7K3hZtttraIlZ7mvjA58G6x2gwtHu7wfwDYrECuhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytHSOlpR9kaIQVCKC7DuPtidGzAhotbpepVbKoyoh/buUnFE2D
	5jA9hqTTtPjopGh4SkfABkB9kRzBufFzGmUhwZ8FDgF0QZFcVw/txsC8YIlw3DZDl7OmONehCub
	RqV6R+6Qh6m/pU9KQOlqzsnFqUQcJOFg=
X-Gm-Gg: AR+sD11EbJOWSZQ/GN7JrZ6kgSpCy2ETUEv1/kRIrXsQOyIX0La8pk+ymB2ek6h2pjm
	CB5JR7G+uUy1tQDlfszIHXaVM2rSHuA8k7Kgc4rw1ly4RI2EQM6Gt1ZERxJoJVR3ukEmImY6V9o
	9Cky0rC4JfiemMoWOp3PVUGkLETsyyooHei0VyNVoV5U031njTAYucGvuFPkjyZBJ7ToMtc2SOY
	p6qsn1YnqSt9MGX9+c17YU48HpdPV5oEplmHBycQB8qJgwVWdy2IkuQonNiowRMOp0KsHTl1RM/
	tzYvrvqOOus5+xaj+URJLmpj88bxBPqKDZd6o8tfJtMhgl/RPpXpwnIYpo5zBDuS36w/X3+hT6Q
	VfbqQhIZtJreopq3P446vZJv6yXWYE0erC0OESsn1CtTMkT7RAA/sDEBYe6vJWzHmugXzmjNW3V
	B6RkTGxTuoWB366ZCS8bwl4Z1V7QDiJRaLMoKy
X-Received: by 2002:a05:6102:d8e:b0:739:478b:5bf2 with SMTP id
 ada2fe7eead31-760e8f347d4mr6463052137.13.1786131247763; Fri, 07 Aug 2026
 12:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch> <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
 <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch> <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>
 <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
In-Reply-To: <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 13:33:56 -0600
X-Gm-Features: AUfX_mxMpD-qand8wklMDqDrRd_xxDI0iY7G3-8rmiKaEvXH5AFL93SLf7_FiGM
Message-ID: <CADvTj4pJG56UERve8BfbYzjCLO4KBDDuFviTcz1ivuwUFRMdxA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:16=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 12:48:43PM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 11:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > I guess it can also be used like this for live dt modification:
> > >
> > > A guess is not good enough. Give us a concrete, in kernel use cases.
> >
> > I searched the current tree for callers of the OF changeset and
> > overlay APIs and for OF reconfiguration notifiers. I did not find a
> > current in-tree path which adds or removes a child below an already
> > registered MDIO bus.
>
> So lets wait for a real user to come along.

So should I just drop the final "net: mdio: support dynamic OF device
changes" patch and keep the MDIO hardening patches?

>
>         Andrew
