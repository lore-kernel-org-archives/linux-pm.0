Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE663E7150
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268407; cv=none; b=HyMxmaAUJvaT4q8PJeS1YnZZ8h6WC+HEAvmOMH0IkeyTvu1GW+Oz9KNAkgOD+LJZciypI36SDQqFG/DBjHtIHt9lZIxGtE11QBl4mZ3AqT2j4XFsT61a+nF0YVIdGXCz0ynYGdCI9a1hg9z3N/qnEDzcYODfYrZS+fK2kj7fqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268407; c=relaxed/simple;
	bh=3SvOdzFCR8HZ5gdBT/Eq4g666FksCrvDYtEMUUisJ28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWSN9FN9kDT6lnEdEc397ShFlyBcRXInp/C6pRhHMORAfiiuWujBTVzZs5pK7CiiUw77u8dLxUDnyG8YLU9HKGlXPbVJif9p2tssnkl/TPiq56KdJesOLFSb/QXQFUngTUx3aS6dj5qbTSoUMTTNJjgZu2L1xar00m2i3NzFX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX/gtDUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX/gtDUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8749C2BCC9
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268406;
	bh=3SvOdzFCR8HZ5gdBT/Eq4g666FksCrvDYtEMUUisJ28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SX/gtDUDjIjEfZP/9Ah5wW5kjWBacOWtfOS3sZetO1k1iVJ5hnSb2l6i4MPYZMnUA
	 5P351CSZXM2kOLuwLiIpQs62OdNxyYZAhYXSZwkzB/1dRCcX3Fl0ZMNl8/xc2VT0JE
	 ncP2eYH36utkv56PSxYrgAe3d/QHGTbs+zOWX9pn5IKUzb40GqQBcP06GxkBR851Kh
	 BCeK1eSYOuiKNELT0HWXpY7Oo2azxwNWL4a4PmoOUtl+sGllpRwLtI+nZMqdVRI8if
	 OxOjEiK9OYfcKafrvn/qxG0hivIU2Vi4hvrCBrltOBmqQRUpDBZrkUh8EyZP/hswaX
	 lPbBT0acuOpyA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dcdf60427so2363617e87.3
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:26:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Ri3iZ/daD2ZLBzKlDlKXHcrKn0l3yaqdbrUSPPdkg2YM1QRySJYOnUC6ghUwB/yA8Zg/k7sAm2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQH+eZbMi8eeyNh8q4cRKx+PMC91gADK+BjC6JjIQ5QwafIdF
	23EALBhJWXHSo/3CbBVicu+p5tDr+NGdK0UyqNKKojhGgrvfTADbzVBO+0C3kuaoyxrpdsy8yAw
	9IP+z912PTz2DNZUwM7GeuCEOo/zQXTY=
X-Received: by 2002:a05:6512:3d17:b0:5a7:46f5:de69 with SMTP id
 2adb3069b0e04-5a887cde266mr4415431e87.25.1778268405263; Fri, 08 May 2026
 12:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508180511.1306659-1-daniel.lezcano@oss.qualcomm.com>
 <20260508180511.1306659-4-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0gWgoZtuK6nZ+71QbdV96GXq8McQ=azcCuceph3XxBD4w@mail.gmail.com> <f00ef10a-9adb-4553-84cf-24995598ec1b@oss.qualcomm.com>
In-Reply-To: <f00ef10a-9adb-4553-84cf-24995598ec1b@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 21:26:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gx+yHZsBdZ7=O=Y-qcFOOCHwudGo17GdfH__z2_zBbiw@mail.gmail.com>
X-Gm-Features: AVHnY4LlFfQaz_QkkSSG9w_-iFDdLAwC02j8no-DHO8dtfkS5NVWhBMKUGXG_DI
Message-ID: <CAJZ5v0gx+yHZsBdZ7=O=Y-qcFOOCHwudGo17GdfH__z2_zBbiw@mail.gmail.com>
Subject: Re: [PATCH 3/4] thermal/core: Allocate the thermal class dynamically
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 9:22=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 5/8/26 20:24, Rafael J. Wysocki wrote:
> > On Fri, May 8, 2026 at 8:05=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> Use class_create() instead of a statically allocated struct class.
> >>
> >> This allows the thermal class to be managed through a dynamically
> >> allocated class object and avoids keeping a static class instance
> >> around.
> >
> > I changed it the other way around during the last cycle, so is it
> > really worth changing again?
>
> Yes, I think it is because it does not reintroduce this change:
>
> -       thermal_class =3D kzalloc_obj(*thermal_class);
> -       if (!thermal_class) {
> -               result =3D -ENOMEM;
> +       result =3D class_register(&thermal_class);
> +       if (result)
>                  goto unregister_governors;
> -       }
>
> -       thermal_class->name =3D "thermal";
> -       thermal_class->dev_release =3D thermal_release;
> -
> -       result =3D class_register(thermal_class);
> -       if (result) {
> -               kfree(thermal_class);
> -               thermal_class =3D NULL;
> -               goto unregister_governors;
> -       }
>
> It is replaced by thermal_create("thermal") which allocates and
> registers the class and we get rid of two global variables. But up to you=
.

Fair enough.

I'll queue up these changes for 7.2 early next week.
