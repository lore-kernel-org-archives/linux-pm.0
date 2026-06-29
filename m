Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB063F871C
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723973; cv=none; b=aAsVGVQygQXWN0RQdIoLbLoINpk6Ma+IrV8lsGsD+gRzgQfQdQuDk5K3k5XY3cP8k3QS49Ma9yT1z8fCXirE0NnKrHgpoKIk9x8t2CNB//fVy0H/BmNyaVsCiu7ZAFW2B0faScku4CLdtr3khCuGNueTt+CB+okWcpjv+u0l+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723973; c=relaxed/simple;
	bh=qB4tJg2aYLg8hehpYin2dptPRoadEzGzbBpoppNMyKk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8CME2bVhcrtd+S5L3asRjLesa2n8XWmbcKvRHS6po3hQ+sP/e7S+Xk1lf091KLxIw3+crYs3YimWFzNlrtNxlC8k+rdZ8UeKp/oO8Zo/aiOkRFCjLz+tmfXTL7RAmWLgyFQ+0PXFUm3dHaNkYYxOCSSCI5VRjMHxh/OvvJ1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyUhTV03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyUhTV03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EEA1F0155A
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723971;
	bh=qB4tJg2aYLg8hehpYin2dptPRoadEzGzbBpoppNMyKk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=iyUhTV03bOKBX3P50ZCu5uI5Z9GdSG5FaWYf46X7lJcOmFmX+TOB5ZSHaEGQvoVvi
	 w7QBgX5wGnlIt9PwETkpMRIPTtL2gcrwvVGZlvQ9UEO6y0jwZX9Mmn6Zpk9DscDEuY
	 F0AAPET4mFlLtpb3GilD+x3+Q8aLT5LUaL+qRXeepLEhJbSMjM6672Tt+0t+JTi4Ib
	 aZbeAoeQD4GZ24bf76pYRPdkOembLX2HEF5nuge3oTrb5EA6IK7gusKHdgBYLt0wZe
	 2UB/jbL1RUF+Rd3fa80u2w1VGLhbQLmwYrqVheU88CxYlRSZkCxTIpqImYjye4YPzK
	 QVoyZa2wkJ4iA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39af6402933so14210181fa.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:06:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpG2EhvK+HRhj6TELBNPSmcV9lFiL3IPtbl9jE54r2H9bE8xp0NQKDsCAFj/BCxx2SSXHlWNcUkXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsudv/97pSaRdlcDWp122oP5FNb/1sMaDAK8bz47BqKfzpX9Z
	R3qixp0xiHRPSWDDJhntqc3+oeNpFJgfji/O1UgbnwLNO68+R8Nv//ro/RiSGVHfc4V9tbgXWCu
	h9BuLuJDva6bwbNVczW7l0yrBP3aiuXTiT95LdTmFDA==
X-Received: by 2002:a05:651c:1587:b0:39a:e3c7:6644 with SMTP id
 38308e7fff4ca-39ae3c76ecdmr17150311fa.12.1782723969253; Mon, 29 Jun 2026
 02:06:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 09:06:07 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 09:06:07 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9QPgco9BxEix7T@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-21-88c324a1b8d2@oss.qualcomm.com> <ah9QPgco9BxEix7T@ashevche-desk.local>
Date: Mon, 29 Jun 2026 09:06:07 +0000
X-Gmail-Original-Message-ID: <CAMRc=McSDNdBMc_MAbBiOgeWusQXPEvivxniX5dJq+X6rp3UZw@mail.gmail.com>
X-Gm-Features: AVVi8Cem7nS_T_r8P1YOw4p48wRJJJKggepy3MNLXmsKDTbaRpH5jyNSSJ0YwZw
Message-ID: <CAMRc=McSDNdBMc_MAbBiOgeWusQXPEvivxniX5dJq+X6rp3UZw@mail.gmail.com>
Subject: Re: [PATCH 21/23] usb: musb: use platform_device_set_of_node_from_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 23:50:54 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:44AM +0200, Bartosz Golaszewski wrote:
>> Ahead of reworking the reference counting logic for platform devices,
>> encapsulate the assignment of the OF node from another device for
>> dynamically allocated platform devices with the provided helper.
>
> Same Q as per chipidea. Do they provide a pin control facility at the same time?
>
> Otherwise simple device_set_node() or whatever platform analogue should suffice.
>

Hi!

I don't know and I can't test it so let me respin the series as is. This can
always be amended separately later.

Bart
