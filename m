Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E234A4828
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144602; cv=none; b=ERwPasM+KqCtZ+UzEIAqSLNEARBRnbMbZ5QKS+r0ChSMWv1aS9NIEMG9I2NRtXeIwm+jq4CdzCrtyKyShjSMzz/56rwD48e3jUKKev/sMU77o4xLnq5b5VuhS2v0g252RHFjH+zI/9/dX94pHszuv0MzzwOA47rpbOzCVJKYUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144602; c=relaxed/simple;
	bh=3C4s74+fiXJ/Tb6yiCf0/1iEVRfCgm/jh1W3+HtsJ3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4noh82VFowLlzthe7MoX7MZBivKS9aujnu895+S7OnM9NVGa4moujHdsn35wFQEOWPML7AAACQl3nIKFCTyIRQP0uEEZRgq5YDlYt7w9l2mjnq1jQT2F96ERYUbfi0c2QKcqIPbp+BX2qTDdQutB1bfU6b9VmNh+j0bXgjJKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMZ17gME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMZ17gME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662721F00898
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144600;
	bh=3C4s74+fiXJ/Tb6yiCf0/1iEVRfCgm/jh1W3+HtsJ3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TMZ17gMEE8s5IvageHa/O+f/XtGubOVZh4MhTDYMQ+a/3DNQbk0yZDrgtrW/Nsq7/
	 oq5gtad/xl1qUlPZLlby3ug9t48hgOs1AfKPgrkQWGVHHtCG3hmwH4RS2Uo+LjrwhW
	 wYBCP1UrB6fxudYEnWen9J1LGSVEP8kHHUGWghLGBkA4g/2dVpkPS/HXASyHIoS/Zj
	 8+Mg6fEbPnVgPYotu71N2HdpaDWaPvJAd6Z1UuabI0BCxS6ygryv/3VlS+67irzOHY
	 Cp3MpuhOXfFigsyaHOD8ebihn9dwqjnGpJBBSJ17wHgLnv/nczgkE/yVkW3rbZyzzo
	 R9VSKduIno+Hw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a4fc78b556so10533811fa.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:36:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx8dhD2SrBthhv80fqEOQlTijwK0EUgR0Mt96mflCJ6lmQGqWvYvyRUaFNBrIi7FOAsfoGORffheA==@vger.kernel.org
X-Gm-Message-State: AFuF++k0TzLthCC642IVUedu4aWIlyYRkB4QSrbaGQHwk0bUNx71vkQS
	qe5JUFuVV5bmOhB9jwTFowU/MbteBk6MvbTH7LXlJewyV8c4SCe6+7k1vP/9MFiXHkDVZArqcm1
	JBhiyoky6laAV/tTDzS2fB9JfwsQvBtE=
X-Received: by 2002:a05:6512:1388:b0:5b4:57a9:7030 with SMTP id
 2adb3069b0e04-5b8a030022emr1302589e87.22.1789144598708; Fri, 11 Sep 2026
 09:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <3429468.aeNJFYEL58@rafael.j.wysocki>
 <aqQr6bZjZziZVPyy@ashevche-desk.local>
In-Reply-To: <aqQr6bZjZziZVPyy@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 18:35:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQq9ccqAG7V9op2397DCRQNTd1czSrb+1MUH2beG3WmQ@mail.gmail.com>
X-Gm-Features: AcwNN1V8CKzRNX33jIWysP2iCQsd1ihJfAzZkt6oiefbfFP4XVPHk9H5IiXQu9I
Message-ID: <CAJZ5v0gQq9ccqAG7V9op2397DCRQNTd1czSrb+1MUH2beG3WmQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] ACPI: video: Fix backlight unregistration ordering
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2026 at 03:01:30PM +0200, Rafael J. Wysocki wrote:
>
> > In acpi_video_dev_unregister_backlight(), the sysfs interface of the
> > cooling class device may access the brightness object under the
> > backlight device's ACPI companion, so that object cannot be freed
> > before unregistering the cooling class device.
> >
> > Adjust the code to take that into account.
> >
> > Fixes:
>
> Fixes?

I thought I added it, but clearly I didn't.

It should be

Fixes: 67b662e189f4 ("ACPI / video: seperate backlight control and
event interface")

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Will fix when applying unless there will be a v2.

Thanks!
