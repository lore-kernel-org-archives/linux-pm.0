Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07D33D891F
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939678; cv=pass; b=AP+BF5Jku6LJkrX42//rNu4e8jwe59L31WaiBq+Fd2xPeYKjuOv3FpUeuGA6cM5Xj0H5DpXfWB22MtwAF6ovCUjBK925DAIZkN33wPaX94GepzDjJ/MO52rityONIg2nGDwErTb3fNCfBlSUnU3tP4XQ/OEn+mUSDIp81Ae6pDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939678; c=relaxed/simple;
	bh=Q+CCqNFJAWM5zclazh2uA9ABf22MMeWrfoy3sMf1DJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ke8SjyE9fbgdhJcl+D/17ShlWcf5mMZWeou+P+wQ6Qaq+doU9chY1zdzPkJ+5njkV6nIx9X3I1wIcvvYeYCh7wquu1r/SdBJcgq2oB9qG6VDPJhYQ6HJ3vo54p4qHM6aB6+zZF0qmw90ZaLvHi5Ragt/V/NSJwfmIUDxvdcIqZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MWcCWXfz; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWcCWXfz"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb9b427da2so2666065a34.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 03:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783939676; cv=none;
        d=google.com; s=arc-20260327;
        b=JGk/OzjMWY9jNLa9FD5J94WQH8vlhImVeXhPXctI3UJ40UAc2fRWTqBZrRwOEx3/et
         z3tFElyVeEDURJ/ltYNQRtxWfPtcNgmthKkrxjCNS03bZHZWvq8PnRwE9sfN6AfXgkbz
         Y6CJ3h7JggdvN2niyk+GzKn82aq2TrN59/0MPCs4CzQMt+7GYse8IKdCEBK7HGPGM9r+
         jdrPacvQ2SKj9fE8Ghf3lgBPmifKDXTTFEy+4Ww3eJoKpwf1XdvqZnR3D79a/vKS/rW+
         sBK+NHprdUXFvOh0rhs28HSrv93FQOIgc57rKON/+Rk5qHixIH5rMPa5Juca6tXxUmdm
         JgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eWFL44d2xUl7HIjwQPptHzV3ZpTWrkGx+gsq+YbLkl8=;
        fh=WjMjmgUmrOW5A8VB9njiOln14DB5Lnp7KHcYS2uUHjA=;
        b=r1LuBBuTazHcszb3dqSI3IjcR9BZpyf455mL25jgY7bVZDd+klRHs/Sk0DSLLXtmlf
         CSP+x4Egwww7LGsIwrqwk7IWwtrzVjxX09MUnH7I6sSUBx6VvdowishVifYfMw0voOpR
         0I7tHDcF3egsN2NfRu2JooN6L6JQRh2CnBSVTRUXjhA7aup7Nu9KSZBVTj6/y4b+DjCE
         Gvr+ufO8tzVKs8F5TgEe0z0tGYQ2ReYn7E626fB8gh9ZX6q7DNglKxFaA4RacwMfp4+I
         KT7IqTehMICT3QWP6sazsjCwnvY/opTn90AhpyC7PDEAcTCSYn7pszmkAS2OXBdbrKVn
         q4kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783939676; x=1784544476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWFL44d2xUl7HIjwQPptHzV3ZpTWrkGx+gsq+YbLkl8=;
        b=MWcCWXfzyC78Su9gH2gNTAvh4aoXBuesyO1EqEGBcwQpsU1cFNejSsqtwS+1ufqv3K
         bu/tm/rOHqw6XPg5m5Hb9WvCn4SAyx3jyovZE3HyKGbIZPn7RgR1SHNA5LH+Wx2U7phk
         YG33WyMLyYdFkYiiry7ZWNiXz7bq6Qd/QXbfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939676; x=1784544476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWFL44d2xUl7HIjwQPptHzV3ZpTWrkGx+gsq+YbLkl8=;
        b=n84q2OuXpcehPIFypnd3dW4a+BPQxI5I6yr8FrpTNYNfauyN7aMkzX3M8xHJRVwVR6
         zGAS6Dz+NCdxli7kzeMbzk78n+Do3TgFQ95W//omINDkfe+0iW/vNutlzoVPMvi7IdvG
         lGFmlHnGj2R0e9m1k+Xbh2Bsr6LnHeX2f2Gsj3wt0Cln+kpgM5tV8QKM6S0+rYWevLSc
         ZH8r25hPamnoy3aYrHU+b5HaYkZZcv1DAm0o2Mftq+0M+I4Y4RYabw/K7jnw5/KIPvNr
         OrayWLbx4192HS4nh+L2177PMjYFG3rMou1xVQwjJAlsTpamvR8KmPxr+E5buXjR7ltu
         yWFQ==
X-Forwarded-Encrypted: i=1; AFNElJ//2Zs/xn3NOJrUx73AcDJjVBq/rZtjB+NHRt1fyN0827nd07Z3yweT5IaR2AXeaYQcTBr420YqXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KZ9oaAZjDvih9mGIcIW/OFjNuq5rhwbYKOiMxwhnoeI5voJn
	MVnvoRgaa0KGHkvMpg5yzdx2+84czxu7X2g5WSKrYUnPBvUWjcV+xUAWMwBxZsJf2gdbKMaUiSv
	eXht2D1xARf2aWc9pN66aW24dXY4iO8kIUk5NZxhEu2EULtFgWGoHyw==
X-Gm-Gg: AfdE7clKnADoH1Qyvh+P/mo432T87So4vWOLdbgSnuvkEjTUokb9QKusKBELA384MOL
	hI5J7Iqx0m2f2dtGm7Kcc2dGIMYLzDYGy/lZP0Lz6AmmMaerBQcn+8NqOT3Zj5PdHu0zAqJ/dzs
	6rpbvrviQBrVhnJD/UivTJ3UJPnWIwaopFvngURs+C5ltObmiG9wab9aY4WfgoRk3zt6KD5lp+8
	Sxe+Vuz5H5IEwf2E//v9/H9eLOz7ZWHT8mrHsJWJADTd2J/nIM4yoqPZTVdQBgfQUXskBkeD/bO
	/2QDY9Lx+REoC5zbUVAWJ0hEY/E=
X-Received: by 2002:a05:690e:12ca:b0:667:f107:388 with SMTP id
 956f58d0204a3-667f1070edcmr2274020d50.36.1783939356491; Mon, 13 Jul 2026
 03:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095726.704448-13-wenst@chromium.org> <20260713094329.4105208-1-wei.deng@oss.qualcomm.com>
 <CAGXv+5Ew-_y4Ui8LF6sbges-nVi7mgB0HjQtZAUTHzPh6Vwk=w@mail.gmail.com>
In-Reply-To: <CAGXv+5Ew-_y4Ui8LF6sbges-nVi7mgB0HjQtZAUTHzPh6Vwk=w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 13 Jul 2026 18:42:24 +0800
X-Gm-Features: AUfX_myp_DLSLs6zxF1b0ZOGMaYgyXpFtWmzvguDpYK-nGyh8AfVloamNxBzSn0
Message-ID: <CAGXv+5E0Nz=uD26eXSdt3jGKEjsWyai_+PO2ZBTr8t45FQ+SKw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] power: sequencing: pcie-m2: Add usb and sdio
 targets for E-key connector
To: Wei Deng <wei.deng@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mengshi.wu@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 5:57=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Mon, Jul 13, 2026 at 5:43=E2=80=AFPM Wei Deng <wei.deng@oss.qualcomm.c=
om> wrote:
> >
> > On Thu, 9 Jul 2026, Chen-Yu Tsai wrote:
> > > The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB o=
r
> > > UART for BT. Currently the driver only supports PCIe and UART.
> > >
> > > Add power sequencing targets for SDIO and USB. To avoid adding a
> > > complicated dependency tree, rename the existing power sequencing uni=
ts
> > > "pcie" and "uart" to "wifi" and "bt". The existing target names are l=
eft
> > > untouched. The new "sdio" and "usb" targets just point to the renamed
> > > "wifi" and "bt" units.
> > >
> > > The "unit" names are internal to the power sequencing framework, and
> > > should be confined to a single provider. The names are only
> > > informational. Dependencies are tracked with pointers to other units.
> > >
> > > The "target" names are the strings that the consumer uses to acquire =
a
> > > descriptor with. As these remain the same, existing users will contin=
ue
> > > to work.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > > Changes since v2:
> > > - Expand commit message
> > > ---
> > >  drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++------=
--
> > >  1 file changed, 27 insertions(+), 14 deletions(-)
> > >
> >
> > Hi Chen-Yu,
> >
> > We tested this series on the Qualcomm Hamoa IoT EVK with both USB BT
> > and UART BT M.2 cards and found an issue with UART BT power cycling
> > when the USB hub is active.
> >
> > The "uart" and "usb" targets in this patch share the same bt_unit_data.
> > The USB hub acquires the "usb" target in hub_activate() and never relea=
ses
> > it, so the bt_unit enable_count never reaches zero when hci_qca calls
> > pwrseq_power_off("uart"). As a result bt_disable() is never called,
> > W_DISABLE2# stays deasserted, and the BT chip cannot be properly reset.
> >
> > Observed on Hamoa with a UART BT card (WCN6855, sub 0xe105):
> >
> >   With your patches:
> >     lsmod: pwrseq_pcie_m2 ... 3   (provider + uart + usb)
> >     btmgmt power off -> GPIO116 stays HIGH (bt_unit ref 2->1, no callba=
ck)
> >     btmgmt power on  -> "hci0: command 0xfc00 tx timeout" -> failed
> >
> >   Without your patches:
> >     lsmod: pwrseq_pcie_m2 ... 2   (provider + uart only)
> >     btmgmt power off -> GPIO116 goes LOW  =E2=9C=93
> >     btmgmt power on  -> hci0 UP RUNNING  =E2=9C=93
> >
> > USB BT card (WCN6855, sub 0x3374) tested separately works correctly wit=
h
> > your patches.
>
> Thanks for testing. I haven't gotten around to doing the UART based BT
> in our stuff yet. Though today I had been thinking about how to reconcile
> this with the MMC pwrseq stuff, if the SDIO stuff isn't moving over to
> this. Still no idea whether that would happen.
>
> > The testing was done with the following Hamoa-specific patches on top o=
f
> > this series:
> >   [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Ke=
y E connector
> >     https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-1-5=
e725091266a@oss.qualcomm.com/
> >   [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UAR=
T BT variants by subdevice ID
> >     https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5=
e725091266a@oss.qualcomm.com/
> >
> > The fix we verified is to give "usb" its own independent unit so its
> > enable_count is tracked separately from "uart":
> >
> >   static const struct pwrseq_unit_data pwrseq_pcie_m2_e_usb_bt_unit_dat=
a =3D {
> >         .name =3D "usb-bt-enable",
> >         .deps =3D pwrseq_pcie_m2_unit_deps,
> >         .enable =3D pwrseq_pci_m2_e_bt_enable,
> >         .disable =3D pwrseq_pci_m2_e_bt_disable,
> >   };
> >
> >   /* change usb target to point to the independent unit */
> >   static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_da=
ta =3D {
> >         .name =3D "usb",
> >         .unit =3D &pwrseq_pcie_m2_e_usb_bt_unit_data,
> >   };
> >
> > With this change, uart_bt_unit reaches ref=3D0 on UART BT power_off and
> > bt_disable() is called correctly. Since a M.2 slot can only carry one
> > card variant at a time, the two units do not interfere in practice.
> >
> > Would this be an acceptable fix, or do you have a better approach in mi=
nd?
>
> I think it's acceptable in that it works, but it needs to be properly
> documented, like "this only works because on the M.2 slot only one of
> the two interfaces is used; do not use this pattern in other drivers."

One small problem. On the USB side, userspace can disable any port,
which will cause the usb unit to be powered off, and therefore asserting
W_DISABLE2#. But on the UART side, the core still thinks the uart unit
is powered on, and the consumer would need to power off and then on to
recover. Maybe that fits into the normal reset / recovery procedure,
but it's still not intuitive.

Maybe something like

    pwrseq_power_cycle(struct pwrseq*, bool forced, unsigned int delay_us)

would be better suited?

> It's also up to Bartosz and Mani, since I believe this is a slight abuse
> of what looks like a shared resource. I'm sure the AI review bot is going
> to complain a bunch.
>
> If it's acceptable to the maintainers, I assume you want me to fold the
> fix into my series.
>
>
> Thanks
> ChenYu
