Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE38BE9
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576351; cv=none; b=Frm2Rl5GjWnWA/LWz+Dbeba/rvVXPwqQokO/WXevVtEKkbRdAZP8Myp6FSOOoZfQPhp1UX4sNjvEnCEH5RNoBJsGr2U8k8pvLheytbcbHVL8ZLFVawxMW0YoWcA76C51RG5yEhlxmmgjXzL5NyiJ5S9LjqPJHyM22hWmLsFrbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576351; c=relaxed/simple;
	bh=LnrtZB0iEg1z1vGOmrpOOK3Cssie/DMPDNqDCPjTdS8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYFYmfUKvqGWncE47aNu5ecLyh8KvlaMrVFUr8zcN8eMa9TrdZ/cmf3m94TAAlWvAcGRNz5Kx066tHgRZSG5PhCPs7xVbv4YTHDbtY7kTqNG+oM52+4IvSzdjlPIxJGv/jB/Aq8wkts85gJwLRXtLJoMPgVEIns2YxwoyqS1OmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSLBVLuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSLBVLuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DDD1F00893
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576349;
	bh=LnrtZB0iEg1z1vGOmrpOOK3Cssie/DMPDNqDCPjTdS8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NSLBVLuHPNJKJoWXBFYM1jX5Bar59Ts44Gjv4B9yEXF+Wr9dqp7TYmlAahSDWUJkO
	 wYxfb6tLkovopDG4nBLwSB+j4VDoLhNifa7VD/iAmh0Ry6f/fFqmnp5foaxoOvKrAc
	 hlSb/elZisOr9iiC2JLhQUrurlb7GbXmuqNJZHpnNvY4C3+UGwpiUq/DzPJLHXKNHw
	 xwKMT4yAYPIa1z5CBijEwsICgYz7s1WBEP4gjTOQWcmqyQkdjNWmqVOPiogBWS7VG+
	 Jxhht+pi9vzwFVzaBSdf1rWZJtiTEJzT0AX2CnlS7i7QS2AwHbw/UZX64vt4VnCZ4T
	 0gRuCWdk7J1LA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39677aed4d3so5551101fa.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 05:32:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+tNzCFpPVSwq7kDlBgsP51hgXg8ef++1PKgdjVMr0L91Zemkmo4dqvCvjNqi4u2CfH6/JwjQdBsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyarqzFj2Rk2nNGEVxOOtqFKvLhm/UGwhrB3SJvfBPqGPgUHJf/
	exlfUi+zupJsPkpclsMN55GOc/sB4qgK85HLvMuR32Jj5rK296sCsoEbda61P6bXkf0pf75STUx
	ric5w6BguEz9TELCsW+W9poVmwyuwshKyCVkIz3LRSQ==
X-Received: by 2002:a2e:bc24:0:b0:396:9cbb:673e with SMTP id
 38308e7fff4ca-396af48a101mr25033101fa.24.1780576348691; Thu, 04 Jun 2026
 05:32:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:32:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9OIVyrHEhcMHzN@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com> <ah9OIVyrHEhcMHzN@ashevche-desk.local>
Date: Thu, 4 Jun 2026 05:32:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
X-Gm-Features: AVHnY4LlXi8ln45MTUjJfpd_YWjp19dT0a-H21-M7Hc7IKBiGWRxgS3l-OaDEEQ
Message-ID: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Subject: Re: [PATCH 07/23] driver core: platform: provide platform_device_set_fwnode()
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

On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
>> Provide a helper function encapsulating the logic of assigning firmware
>> nodes to platform devices created with platform_device_alloc(). Make the
>> kerneldoc state that this is the proper interface for assigning firmware
>> nodes to dynamically allocated platform devices. This will allow us to
>> switch to counting the references of the device's firmware nodes in the
>> future, not only the OF nodes.
>
> But why different for of_node and fwnode to begin with?!
>

I'm not following. What are you suggesting?

Bartosz
