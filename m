Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB53E3163
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936658; cv=pass; b=d9aStZh46ZamqikkUwC3v8ZrKz2BF0HkyBAijnl/RMH9oqPgYmcFRJ2Wk1A2Y8/OMel60wQIjETPWfvQ7h5+PxcqgK8q/aUxX0yUdtj30CDLGxpIlEwWG2aWEdTUrHvPOu3t5t5o2ZtX+R9CeIfNl1A3s4L8lOzdmNkds2k+UuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936658; c=relaxed/simple;
	bh=+iOLSTgUanaRtm9A0v0TMBC0fmd4CqVE5DXXexLAS18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tisOkDvKE3F/+pkHlEZ4kETeMhA+uXLSKFEUHG0eJ8F//C2hHfm+R7UrKRVj+/1Hr0j+KRomygckcu7hbzWmt9OYCDGeKyRtolyQZ7NtBfMthxIUPtKgNsDjOhQamhwOi5lZ0SD8EZXdhJ0yO0rx3MN7p3f3Z+e7d36NnwUc/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nISxJ9on; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nISxJ9on"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-667ef69424bso821061d50.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 02:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783936654; cv=none;
        d=google.com; s=arc-20260327;
        b=Bc5h+/xjPg4cutZpGmWBzQNn1DHWhLrmQcwUOtBM97wqQk0l9a1lVTSDSacgOgiYbe
         GXa01teJRq66cg8PWsBI2Y0LJAZV6c5y+rMrUpflu85gttPCj/qAzKgNtz0ka/OGHCN6
         wUaHmcRJSCipQQiFlx8/r6AnDLy1reO0H/a105BQcAaz+N9ez2VdjFzk0pu+kzqeWXUY
         ZKNtbqDnkjHfVSgXZgXsgGYgIzoFMofMQGNYIedqxzzl5Imv2cDbU8GJFeQyi2B8Fm5a
         rrtHSw7Q8fM4yvRHDPxmNci0CYyt2GIaI6escjPd2fO7t9eOJNboyyuwomRkG5Wy1Gz0
         bcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4QXt7p8Vwl3VHBbUurRh8OkWPo7b1yKApjJfQ8E1MKc=;
        fh=0f0Y37nBNhxN6U5HRXaIgWTlVg7rOZByREAdC/gV+Zo=;
        b=btoAjTiWrlvJzzqJ0vyTMurnh1B8DCZZ6/nRoVe26ZEmOaMOB0aND3Rkj1DwqVunIB
         rC3LaDs47D0ROp0F4M62Jd9D7J2tY3SHJMf9gjeZD8mVlFBNKW/r4+rG/3p+ZZ6g3YE9
         oKgcUgnHzIrX9iCSJiKbm/kuhnSw7T0ue5w/A3F2fYau9KiGX6b8a1qweB5kcWP5DBUk
         lJ0grnUN+K84BZt5jA7Ijgz56t40n+0WqCQpODehxu37zJuSiVwm3bagaQz6E+vKUvhq
         dkIGjNV88idddxVywCLWiFhDl/cyhDg2aN/XyTUC4jV1/K+I2tgXF73QRpc7GZf5kmjJ
         NLTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783936654; x=1784541454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4QXt7p8Vwl3VHBbUurRh8OkWPo7b1yKApjJfQ8E1MKc=;
        b=nISxJ9onFd1jwGuiH0aauLQrJCiblFJYXTtxsgs7SDzXhKrM8dgyI06soNVGtAdEZs
         GBsGUDR6I1wHg5ZZE/I8Kao5niwKXeWFA7BOlQSYJps05BBAAOhcTl+brCpXk63+i06P
         BknkwBPLjH0Uny0wgaMzfdsiFUW5GtQ359eOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936654; x=1784541454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QXt7p8Vwl3VHBbUurRh8OkWPo7b1yKApjJfQ8E1MKc=;
        b=cd6HfcMFYVafJqi7ajSIlbze/3MS4a+J/+XR7xvrQiWDqTWc8Mwn9fxClXH6Pzp89F
         V6zP7kAnKHmdqT6IY/nP83eg5KuqQwHW2VFon3jiqN7YZKyx7vnkmGx0tQYQSNzsW1zd
         lbNJR7DhcH3NG/BGwXUxTX8iXEAvkwlsDvzB/ZbOnFp9l+byzGvDNfH5rHRwTSiaDt+F
         Lv5YnvT2B0OcXX8Y8v4lGT9kAXMWkB0sk7uJ8z8T7wj+r5dj3oaGg80plr2iZzjRSvFm
         +5Y9F0b5/hy7d8dI54/9x054ky//sqzyO2Ja12mKf2vpdI/2v1KHy8MI50qMyrAFHwCh
         G24A==
X-Forwarded-Encrypted: i=1; AHgh+Rok35jcMOxY3rsJ/KU+pGzauXWQhhVZeCd2ljXPE6tZoWKDPsu9LqtVKzx6rrYgYRucWwe8j/sm2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwzjvVEm/ZeJzUIujtQVE9tqboD7hwctMN2DHbOeOks0OdYUxk
	/hS1PAV3vL377W/6oNe5p6BOrQvKzfwdW6xHC9NYrJ+aUMhsjpTDXo9WYqGb0RjYi8J4CO/8sIs
	S2wUA0zEm3B0k6sN4s+hlcGTzyjTXq0zCK7rxzVqS
X-Gm-Gg: AfdE7cloVXJDffBAlF9G9vZyOhfdCQtSeLRRF1vnebOEC9jMWzOadfCAbjlQ6ikYnic
	xYP2IehIQ3H26HZfqaTUQubdjQNIsI+sgWpBm7gQ2PBpQNwLcKj2cXuq50oZgxRDVlALbooAYPN
	t9I1xDVpAT367yEhCujour7XAFq6E/Ad51/IOtpvuugcqZX9hEz47lH4HfNnuYUIeCGEY4zhjXm
	vDRGQHUgvDmMcj+0ER3t04nPxmqEzWLbsbEW4lyTkksAPT5wsxPOlIne+oJbeJq50abfQqIu94u
	8FvTs9QlPPoYZuBNok7cXHjbOtE=
X-Received: by 2002:a05:690e:c48:b0:667:f1d5:b364 with SMTP id
 956f58d0204a3-667f1d5b81bmr2295373d50.63.1783936649263; Mon, 13 Jul 2026
 02:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709095726.704448-13-wenst@chromium.org> <20260713094329.4105208-1-wei.deng@oss.qualcomm.com>
In-Reply-To: <20260713094329.4105208-1-wei.deng@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 13 Jul 2026 17:57:17 +0800
X-Gm-Features: AUfX_mwq5Qa8EaAFziCQqQmKzQg2wnKp5lbTV4kofMKUdyLtgA0yJkFs72KLWb8
Message-ID: <CAGXv+5Ew-_y4Ui8LF6sbges-nVi7mgB0HjQtZAUTHzPh6Vwk=w@mail.gmail.com>
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

On Mon, Jul 13, 2026 at 5:43=E2=80=AFPM Wei Deng <wei.deng@oss.qualcomm.com=
> wrote:
>
> On Thu, 9 Jul 2026, Chen-Yu Tsai wrote:
> > The M.2 E-key connector allows either PCIe or SDIO for WiFi and USB or
> > UART for BT. Currently the driver only supports PCIe and UART.
> >
> > Add power sequencing targets for SDIO and USB. To avoid adding a
> > complicated dependency tree, rename the existing power sequencing units
> > "pcie" and "uart" to "wifi" and "bt". The existing target names are lef=
t
> > untouched. The new "sdio" and "usb" targets just point to the renamed
> > "wifi" and "bt" units.
> >
> > The "unit" names are internal to the power sequencing framework, and
> > should be confined to a single provider. The names are only
> > informational. Dependencies are tracked with pointers to other units.
> >
> > The "target" names are the strings that the consumer uses to acquire a
> > descriptor with. As these remain the same, existing users will continue
> > to work.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expand commit message
> > ---
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 41 +++++++++++++++--------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> >
>
> Hi Chen-Yu,
>
> We tested this series on the Qualcomm Hamoa IoT EVK with both USB BT
> and UART BT M.2 cards and found an issue with UART BT power cycling
> when the USB hub is active.
>
> The "uart" and "usb" targets in this patch share the same bt_unit_data.
> The USB hub acquires the "usb" target in hub_activate() and never release=
s
> it, so the bt_unit enable_count never reaches zero when hci_qca calls
> pwrseq_power_off("uart"). As a result bt_disable() is never called,
> W_DISABLE2# stays deasserted, and the BT chip cannot be properly reset.
>
> Observed on Hamoa with a UART BT card (WCN6855, sub 0xe105):
>
>   With your patches:
>     lsmod: pwrseq_pcie_m2 ... 3   (provider + uart + usb)
>     btmgmt power off -> GPIO116 stays HIGH (bt_unit ref 2->1, no callback=
)
>     btmgmt power on  -> "hci0: command 0xfc00 tx timeout" -> failed
>
>   Without your patches:
>     lsmod: pwrseq_pcie_m2 ... 2   (provider + uart only)
>     btmgmt power off -> GPIO116 goes LOW  =E2=9C=93
>     btmgmt power on  -> hci0 UP RUNNING  =E2=9C=93
>
> USB BT card (WCN6855, sub 0x3374) tested separately works correctly with
> your patches.

Thanks for testing. I haven't gotten around to doing the UART based BT
in our stuff yet. Though today I had been thinking about how to reconcile
this with the MMC pwrseq stuff, if the SDIO stuff isn't moving over to
this. Still no idea whether that would happen.

> The testing was done with the following Hamoa-specific patches on top of
> this series:
>   [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key =
E connector
>     https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-1-5e7=
25091266a@oss.qualcomm.com/
>   [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART =
BT variants by subdevice ID
>     https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5e7=
25091266a@oss.qualcomm.com/
>
> The fix we verified is to give "usb" its own independent unit so its
> enable_count is tracked separately from "uart":
>
>   static const struct pwrseq_unit_data pwrseq_pcie_m2_e_usb_bt_unit_data =
=3D {
>         .name =3D "usb-bt-enable",
>         .deps =3D pwrseq_pcie_m2_unit_deps,
>         .enable =3D pwrseq_pci_m2_e_bt_enable,
>         .disable =3D pwrseq_pci_m2_e_bt_disable,
>   };
>
>   /* change usb target to point to the independent unit */
>   static const struct pwrseq_target_data pwrseq_pcie_m2_e_usb_target_data=
 =3D {
>         .name =3D "usb",
>         .unit =3D &pwrseq_pcie_m2_e_usb_bt_unit_data,
>   };
>
> With this change, uart_bt_unit reaches ref=3D0 on UART BT power_off and
> bt_disable() is called correctly. Since a M.2 slot can only carry one
> card variant at a time, the two units do not interfere in practice.
>
> Would this be an acceptable fix, or do you have a better approach in mind=
?

I think it's acceptable in that it works, but it needs to be properly
documented, like "this only works because on the M.2 slot only one of
the two interfaces is used; do not use this pattern in other drivers."

It's also up to Bartosz and Mani, since I believe this is a slight abuse
of what looks like a shared resource. I'm sure the AI review bot is going
to complain a bunch.

If it's acceptable to the maintainers, I assume you want me to fold the
fix into my series.


Thanks
ChenYu
