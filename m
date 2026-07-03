Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04673D34AB
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084817; cv=pass; b=cs5y1igjFLdTfMtV8NkXAmVU7DIFsRi1J7+n51Uv8M4plcCZHq4YpEO0DWxya1nY5VSpFEE5s1cAjPWDb/jTW4cT2lXgenaTMEut7NeTiBQVQznCiFqyPIqHHM+y+b9nz1bcDvec2UGinb4BCXYAcjHck13449fSKNMHWLiV3LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084817; c=relaxed/simple;
	bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJLfb/VIBqaBK4JN8/pNbe8Qr0Z4ZpUkP61l1vM7MKWja7rvNL4L++fG9jgw9m6AyVuGqdFoqCSeaQ1xnDfQrK1ktv1O9SmFX6Ph7ffrWtRSj0osjfUvtw8alX1oR1iJb/OF3AI/T2X48F+HI4lmQ9ZgyVDH87PLw1gqOk4fuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=grWpVETA; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grWpVETA"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664d530fcfdso702100d50.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 06:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084814; cv=none;
        d=google.com; s=arc-20260327;
        b=r5IaR3c0ADtOL9+/I4Cwopu+1cTFQPs9pX/h6xmAEFS1ubixyPzpeRwg8+IcNbX74O
         YzayU9sca63dfzdbRBa9c04OEY1Z4QpRFabE+IWTtEAi26InAs/3tbJrq7fCtymJQsRM
         MZ8hiQHyEed1llM9HrgL/fz6b0MNqx1eseYESEWq1mUjArLL8z4Ys8vU8rfEvW9kcESd
         rNWr2wMUjN69NxdGg9SSmFN00RMCLkHdaD4ZDPNGVKH89iTs0IxV0iyd2xjwRqOwWnMl
         o/Qv2JMH/XDHKeG5YhHeEiPkrw+lzXBHi92MpRIjOXG0bTO5tYAcRPfh/2a0kz5u76+S
         b/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        fh=oNqY8SnEURhK2b+GNHis+Qyl4T1qyk9NCotwCSIiNmQ=;
        b=cod1r175ZupI1bVtktwY7I9TMkviuzh4xVjaZkn6e+0GdVSD9acU1kCnTrQbuoWUB7
         zULkaGOs8vJSQQdN8rI0cawQuMY84iGv2S9GRB2yoG13VdYfn7RUMQUYrIYv+8HFJ1u+
         SPRkjXx47LlQQFZ7phKihZsJi9fo22exIhQyVZ9nNVrERzZozowYJvXHuIv5NaPUpNvx
         BYuAiZ1bm+zA0lJM8YdKdxeLVfHJ1ncj2cx3lMLVRQS+CTNqzwqQO+63nt5aIv2/F+Y/
         r+Hx8Qn0DzwbLcajP54J0MOY8ZoDJEpSOO9x57xFO0mJV3BgE8Y526W7aKy6oatcuA+9
         vLrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783084814; x=1783689614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        b=grWpVETAw3jDMmUy3XPnUGOjR8BcA4jyfVk14MFE953+F1914LoGY5rwA3Ge8NZuIE
         7GcRD4+VXwKna3rqHOPliBMs5HWA4GJVOYeQwRl48oHFyGMaDoiBQQ4jxnh2KgTL19Mu
         DTB/K71gdvc4rjOGt/blrp0IXyUNL2x51yQPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084814; x=1783689614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQD5gv36YoN9ZGBbl8CZ1ceMTLNRoJhvy7PP72AjYTM=;
        b=N6BRPZY8JJcoU4lDFQRept+Iyff+GKEJpPLXvB37lTBrgg8mV0AaTXmNXiEDet3yRm
         kUzbKLJIPBvL9SRMpVQE0ig12bjFIoYkmt2U+fChuwtdre4swZOuGyuy3A6Ce55mOsAk
         NxIeOI3rgXx/RkW/wdZxitxM0hgT0S0TfDTgXBscykKf4L/N2dc30/TCSDR9wkBp5Cs4
         Quljw0Z8Bq2RGH1wEaoHL0no1e0SEE2D95kJY1uCWda8BcOYlvSlQ/597fdFu3uC9EgD
         jaqaJ28GwawbPcn3VGLaUltPxqN9/waa52kHxFSMhGqFk1T7LZzIRSBuoIxQ9nQFMolg
         l1Hw==
X-Forwarded-Encrypted: i=1; AHgh+RqClrlV2+BV64ohy8zHeVhjJMjXyOyFYuZ7UBQ6mDTexYosGoomPbzUyJdu9aF8zgozmVia+tC5QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnszswSeOLyM5qewj+qkDfdzweibrEDTozZKvyhq240FwxttE
	EN1C6v+lxQOIIB8yqCXUwQEnmurZoLTY6AINYZW6bJ610h6SD5QT/WQAQSKEAT69yDpxmtDMt5e
	06jMwC6q4sddysPfE2K0zzTs2tcHAlPRGX81mdtqR
X-Gm-Gg: AfdE7cl3eon1P2/nbieSQmQLQTpZw8sbZPyjCZaaX8nsaUccvIWTtN4ldAHsJpazP7D
	79VIitMQrV9HeVOnq9Cb9tNT9U/xXbJN3cfj9IczBU9H/m91bc6ZwttH6p9K+QedOH6BEBH3Gnp
	xHNri0v7WDW4NZ1oL6y2Uc7TrsaS3G9k82Gy5NLvX4FxBC7Z1jnpm8qMd5DyjL8AjPIBR4ScQuU
	rwMCKNTb6sP53DdLL2wWK0EAZ9EK5NWVykpH9914/2I7zzCGXOc6GlVdOi3piEMQg2vDBtQIbJW
	u91fsFcwwup8oZcJHw0zj+rZBIM=
X-Received: by 2002:a05:690e:418a:b0:664:ae6a:e9a5 with SMTP id
 956f58d0204a3-66521d54781mr9923763d50.75.1783084814296; Fri, 03 Jul 2026
 06:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-9-wenst@chromium.org>
 <CAMRc=MdMhr6qAnAtUePbuBbsH=3MzRC+BrL5GssbNTwGjp_ayA@mail.gmail.com>
 <CAGXv+5GHFnMj3qr5BcpLCQk25rWYOgnMKUX079ScELs4uqEdVg@mail.gmail.com> <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
In-Reply-To: <CAMRc=Mdoj204dTwVMeqFwsVt3f4JJUJtk93VL2hDgh7+C60eqw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 21:20:03 +0800
X-Gm-Features: AVVi8Ccxmi-jSFxGKDTUuToCDHyjKIoBrT_lajnjop8tp06Df09KPZI8Is_qoIU
Message-ID: <CAGXv+5GH3navtUC-V--dJOEjqiDtOauXf_TKxzdQ_T+bK_v9gA@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:16=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 14:58:56 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > On Fri, Jul 3, 2026 at 8:41=E2=80=AFPM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
> >>
> >> So this is only needed to not have to track the state in a separate fi=
eld?
> >
> > Correct. Reading the field is not the problem. Updating it is, as the
> > fields are packed bitfields, and Sashiko suggested that locking would
> > be needed, though it may have been for the peer port, which has since
> > been removed.
> >
>
> I'm not sure if it is. The user controlls the handle. We could argue, it'=
s up
> to them to provide synchroniztion. We only assign the target and pwrseq f=
ields
> once in pwrseq_match_device() and only change the powered_on field later =
with
> pwrseq_power_on/off(). Unless the user does something weird, we should be
> alright. Maybe a small note in the kernel doc would be in order.

I was refering to the status bitfields in |struct usb_port|. As you already
explained I think the pwrseq stuff is fine.


ChenYu
