Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805733537CE
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542680; cv=none; b=XYQPoiByYWupEXkZBh8foejYGwdXgb9LwakE7UJpMb95PuCnyERwsPSxyXctvY4pYfSPBjBytcfJyNJ+QLQcd0yW7DJv5XcBJcRn3fVlIrAiPDMg8MLH4ED+RXMCiA6JxEj60oHnJvaxOrXlwUOCrpPQpMgK/TNjVk8JCE7oRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542680; c=relaxed/simple;
	bh=wzb03DLVgIj3vB7hKR26LkDSnhyToSK5dDUTYTCmeno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddTQzLCwCgRr2C8ntwu38L9hxJ512uO4O2LU4mkZWCGbmeTXal69302NExyvx1Jj9/qfhsO94Ul2YPRsAdcnECXnYbSAWXopuQRo9sFBCJtTchkXQ9EQixS6O7B8A0LPRYIRfEfzOIVehKZ5BxVQ90q2lmIt5cUzj+cdKr5OKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSbCUAoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSbCUAoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFFB1F01563
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542675;
	bh=/CDqLznQvkVu7WQ3vZoYAE6ZEb2I+Dl4DDzf448Rh98=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=DSbCUAoaBf0BDfPe5nbw+AB5KH61cmX95b2H4GrECOmgcWubqAUSF+QTRSuXuKJ7W
	 So0x0z73IE6ijUa/G9rzZeyi6XXSdOCJpEK1oP0odVfwTNd9h7hU4p7kbn9tbBzUkI
	 oInQ77/mksSytpVmjMak/Lh1ZpwaM5Z7jIk/Jv59U6t216lhGAQBi4a+g3PJdstRji
	 qrFVpmYGS3RsbLRcnKlpuulzpxXD2M11HxGYsFBaJtmdQNOmwYOOAU6PeH3T0Tjlz3
	 dYfLpT7avAUwMSnxOhcRqJ7tStlmGT5PgYp+NABfyd5BpMETqLNwc/PXFTiF24ERqi
	 9BoXQ1Qr/orZQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so14156891fa.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 10:24:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByqi1rCUEOdFeIaHjupHDyVzQPKG4ldqFhojYisLAJllYZGEHIl9MOUy80imsM5Odmt/KtzScTBQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kJpywSdMIkd84NunFRdiiIyjce3Ecix36wmto/AsiILlDMvbrI
	xPOVyR2rssB2bGUiLgGxxVL5vQbOWnewkUEmIQkvn7rOl/TnTU2oYMQpDQkwr6WKWh3m4kgubGv
	b23kScws2FuJK+jEyJd/Jh0R71GJ5AjY=
X-Received: by 2002:a2e:a54f:0:b0:3a3:314d:115e with SMTP id
 38308e7fff4ca-3a371bc73e4mr9829551fa.10.1788542673867; Fri, 04 Sep 2026
 10:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904084158.1341550-1-wenst@chromium.org> <20260904084158.1341550-8-wenst@chromium.org>
 <2026090430-botanist-ungodly-0299@gregkh>
In-Reply-To: <2026090430-botanist-ungodly-0299@gregkh>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 5 Sep 2026 01:24:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>
X-Gm-Features: AcwNN1XsOjcnbmZTa6fnJtFKjvQsiEWmd4_rlrVRXh_dounYDIlqWUAfitdifNU
Message-ID: <CAGb2v65MSxL+r+wqMjPKVSh9aS1gkn8og6oBinSXDdipnoOyCQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/16] usb: core: Move struct usb_port and related APIs
 to port.h
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 12:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 04, 2026 at 04:41:46PM +0800, Chen-Yu Tsai wrote:
> > |struct usb_port| and its matching container_of() macro should live in
> > its own port.h, matching the split we have for .c files.
>
> Why?

This was requested by Andy. And to me it sort of made sense.

> > Move them as described. Also move usb_port_is_power_on(), since in the
> > next change its |struct usb_hub *| parameter will be changed to
> > |struct usb_port *|, and becomes a non-static function that only
> > references |struct usb_port|.
>
> No, please don't do that unless you have a really good reason.

Which part? Move the code?

> >
> > port.h is only included from hub.h, as a subsequent patch will directly
> > use fields from |struct usb_port| in a static inline helper in hub.h.
> > The USB internal headers don't have header guards to help with this.
> >
> > Also drop 'extern' from the header declaration of usb_port_is_power_on(=
).
> > This is not needed in modern C.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v4:
> > - Dropped 'extern' (Andy)
> >
> > Changes since v3:
> > - New patch (Andy)
> > ---
> >  drivers/usb/core/hub.c  | 16 ----------
> >  drivers/usb/core/hub.h  | 48 ++---------------------------
> >  drivers/usb/core/port.c | 16 ++++++++++
> >  drivers/usb/core/port.h | 68 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 86 insertions(+), 62 deletions(-)
> >  create mode 100644 drivers/usb/core/port.h
>
> hub.h is small enough, making a single .h file that is 68 lines long
> for no real good reason isn't a good idea.  Odds are this will make the
> build take longer as you now need to open/read/close another file.

OK. Andy, can you accept not doing the move?

> And if we really want to do this, it shouldn't be burried in the middle
> of a long "enable this platform" series where people will miss it.

Well the code is also touched in this series, so it is related. Without
the change, the code movement makes even less sense, as mentioned in the
commit message.

As for missing the patch, I can change the series name to something
like "usb: Hook up pwrseq for USB power control on M.2 E-key slots".
The series spans multiple subsystems and even the driver core, and the
goal is to enable M.2 E-key slots, so hopefully that ticks all the boxes.
Except which platform is affected that is.


ChenYu




> Thanks to Alan's review for making me notice it.
>
> thanks,
>
> greg k-h
>
