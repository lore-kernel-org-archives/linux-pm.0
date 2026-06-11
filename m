Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273C373C1D
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165875; cv=none; b=uoou6DSHeZVyoyd9ZmX2bFt8SWdEGN/uA37RiT4CpgKLe6NhqXavNN7QOy9FJdR/3vTUNZuzWoXGcv6TDx3mI5+2KCgDskN6NBzPvA1alJx9+nJOe9foElotk6+k9wnCGklU163L5CLAw0dPxcxM4IOW+w8+D37hcgEd2e0llcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165875; c=relaxed/simple;
	bh=qaWx8ntXsuM96Pn2hdwxwXAPPKnzorenweIrZzy4GK8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qoy+nzj69/aI0osGHpS3Zzhkd7rkM36NPbV7rYHHCMeNZbpsaV5mlWFvxyWtR+iCQ7GARu2XiRYxFkbY9pdbqgoV/N3ZJ3GI7k9BM2SHFu2dgkJcvtYy9fKuU03YSXotlmaG9L3XgXzN2R0y/Y6Bkdo9FP4p0RdwtMcKpevBkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax9Ae/gZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax9Ae/gZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E6F1F0089C
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781165874;
	bh=qaWx8ntXsuM96Pn2hdwxwXAPPKnzorenweIrZzy4GK8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ax9Ae/gZHGie3gCb7JuI+NSQ7kHM1EM/qVFJxb9aiciImMjST6c8o4cvWd5PjHPZR
	 uvlWZyjcj+1jBOXZjE6f9Ba8KlQlCsw3LEZ1hNXrr9UNGe+OsOSmAhKm5JovN14xeV
	 b7HQMQzLknvP/w469emCcWdYGQsdjKsy+Z5ZKRt/N8Y4tJSZiTFjafcXoLHsryuHhr
	 6phpOMgR0i/eWnpNpDbsXI6evj3LdC3Jw5bsUm8Dezhsb5aalPtVIPq0udQecodlWg
	 SORzDhPk3xukvwagHUsvRIT1rZF2oF+GFJN7oWyVnKAUT+wyHZQQpWl88Au9a4d1C9
	 N0829CZP/trWg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso7979271e87.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 01:17:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9G+g3xS4FN4FcflBLCm/XBwby6/gIDxfPViajH4EX+qUrSCyRuLjHTs8gINp5U7TIgZ0gLS7IH9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLH22sKgSOl9LmwqZ8imPchvWzCmDd81G7gnsrISvNboxTRnSB
	t+G7eZpV1L5XAcLFl/dL8WBy7/Ig+G2d1bWo+j82figeijwWvuUXbNqfTwWfQmN2X1zrdurbfKi
	+lsysrd1vJ9njtBgKP1E9S4Hycf6HRCtuvtAnrqaiaA==
X-Received: by 2002:a05:6512:33d0:b0:5aa:5f06:b01a with SMTP id
 2adb3069b0e04-5ad27fb2c6dmr485526e87.25.1781165873117; Thu, 11 Jun 2026
 01:17:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:17:51 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jun 2026 03:17:51 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260610084053.2059858-5-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-5-wenst@chromium.org>
Date: Thu, 11 Jun 2026 03:17:51 -0500
X-Gmail-Original-Message-ID: <CAMRc=MduBaCYzB40+b35ogxKgBx6zkB5WMV_zBPkZpec6O1Grw@mail.gmail.com>
X-Gm-Features: AVVi8Ccelzelin4KP3uByrL3JP8Pe5yqhtuz-V7A9LSr5BQSCNVmXC1yUbrpp3k
Message-ID: <CAMRc=MduBaCYzB40+b35ogxKgBx6zkB5WMV_zBPkZpec6O1Grw@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] usb: hub: Return actual error from
 hub_configure() in hub_probe()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 10:40:38 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The addition of power sequencing descriptor handling in the USB hub code
> requires dealing with deferred probing from pwrseq_get(). The power
> sequencing provider may not yet be available when the USB hub probes.
>
> Return the actual error code from hub_configure() when it fails, so that
> the driver core can notice the deferred probe request.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
