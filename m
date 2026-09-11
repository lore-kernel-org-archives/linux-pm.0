Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13B2D1F40
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146161; cv=none; b=itymkfS64imJ9XNo8DgXAEVLaUHES1X4v+ITrZ0LP1THnjzdnh7i2W4Vy8+bJQNW8Uvz1WBdBdO42g/6rm9Uu4xTRIdUij4gWgl6xUdBazwimOqfPUjLrR6XRg0OCRLV+dZw9JjUn4zUBnYet8kBJpz03LnXJ7o6SA5JigxXTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146161; c=relaxed/simple;
	bh=fxWSIughWLEiCFjIRnrZLUvtc4BvXYbaXzVo/oF527k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnLlUtEKj24dsoCcBLEDYmZMbe1r9WmUGE5Mmh3tM/ZNffOdzo2Cmcd5DAMBADeD7lsUpC2Pza90Xwy7Pt6FZF1dLlXRWpLt6pKCB/F64tu36CpXmajijyA1AmP0J7tQq2/Q3Lt8GU5gonykecERf4EZZM0WxmSzxeUxtQyUHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/im4jQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/im4jQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1361F000FF
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146160;
	bh=fxWSIughWLEiCFjIRnrZLUvtc4BvXYbaXzVo/oF527k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H/im4jQ+Ds+/y0c9YktF+Mw7aAC0qtFwfSeXBWcPx5iSaCo02bAaNXaFmKMsbGFvN
	 Jg9l16duQYz76tX4cdjDCFR663Bi47zSmfKm6CjaB9bcvdi5s/Q3FqLVCIpHICCO3N
	 wFz4BaGzBE2ZGTqq9EMwOvNgBn6bJg1y+Wpy434HWpfOZCHHFOj5RxzRljuqGtY2oN
	 3ndq/rLSBlcUKdsXSxLF5Twv8zDq3N/qLwajzFozy4dodI22f7ekjuKbPRephHMZQi
	 YS+ojnhlNyYTWJW4Z09JrJ7KYfXLuR6FU0ot6qg2U1nq/9/XChBRdnmOtphJ3oLCUR
	 OC5LuQVxSD/7A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b8997bc6e6so769580e87.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 10:02:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzzJA/UoP9tgQdWfUZkT2yWLeN6d2pCxTOFdPoVqhWTHiWpI4+/5Xav3Zl3pJVdRV16iQaDc8imkA==@vger.kernel.org
X-Gm-Message-State: AFuF++kdRSXB588BqJSQftbLNJWm+cEsGFRIOVUxQS9/B0TBf3M7yoNI
	xrF5gWzZmWnbeuy+6uzovdetb4kDSB8O7Qs1Qkfrk+NwMdMKZatxdtGKwlSr1acERXTNms5BtAJ
	Nf438yrnjhWDCZMsiX/c89w0txKOdzYI=
X-Received: by 2002:a05:6512:1150:b0:5b4:a798:2630 with SMTP id
 2adb3069b0e04-5b89a2e9ee4mr2055093e87.3.1789146158306; Fri, 11 Sep 2026
 10:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1965933.tdWV9SEqCh@rafael.j.wysocki> <2362345.iZASKD2KPV@rafael.j.wysocki>
 <aqQtIMm-gdJoZAsq@ashevche-desk.local> <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local>
In-Reply-To: <aqQwf3y66lPhTTyf@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 19:01:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
X-Gm-Features: AcwNN1W7OqdA13AKPFP3g4bCqTYMXYRHQEXL-mLU7TGoAhj6twlxY3ReBmjnq6I
Message-ID: <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use thermal_cooling_device_create()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Fri, Sep 11, 2026 at 6:32=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:
>
> ...
>
> > > Is any user space ABI breakage expected as an outcome of this change?
> >
> > Not really.
>
> Maybe makes sense to state this clearly in the cover letter?

I guess you specifically mean the manually created symbolic links in
sysfs that get removed.

If so, I'm not aware of anyone using them for anything, but the lack
of observation is not proof of nonexistence.
