Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DF1ACED5;
	Thu,  4 Jun 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617112; cv=none; b=MQOcjBY182Joh6vSdEl2q2J2KFSfpuLBBgR4tIFpiwjmAThOnoCYtBjdjbq+Dr5KNVdEKMeY9PawtRDWzZ8RKlelejqnRJSLmTomIWmF07yJgYWMIGEGT3x/9paiBiYHUK1w8Kl1YZ+pRTteaLvtq7CciVQhmJU4n/op3xNi0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617112; c=relaxed/simple;
	bh=Qsbe+Zr03M6GgtVi4XR4r7M6OAh7koJDCDJUXBghNFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld2gVpYWTswbNciZ4Vj0f+5LWHaVDiPt5yw+AvB2o2IelZvjyZxMYCm0MksSuRlCPrTAr0odeFOFKboxb72Jt4Yauf31Rq2zXyT5d//KWkAs4THMHrtjQbjJXdXRbgVVJzolSylEhNl2fSLPNJ38f6Wo7jI8bGfMtqxZSHhsOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKcw/Idx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKcw/Idx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175F1F00893;
	Thu,  4 Jun 2026 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617111;
	bh=qh7GaHudWqFS4OaIxaBj0xspMhNwznx2VYShs8Ojxj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKcw/IdxZ03ISnE0pAxKMesbvA2zH37ofT1ZM6iLvTf8bkoWUUHHP7DKIvnR++TXM
	 Sf/wygPpPp5JQO1CJSW1ZQaN6+Pv3ZCFh5pYEcCejg/80HHXVHtqZ36q4p0FYJWVvk
	 uVCsNmN/MfBHpIYpTx/TRT9f0uQ9tCK7jkJNiyBu5hRdCIuL+1XgLZGfizTG4R9PHg
	 9HPvfyNATXVxxjTv8Ex0EVM1wPYQKGO7hWZsyb+6gcqoT7SlSB30uBN1rZq2p3zYTz
	 +QjuVQm/o5LXS9vCa6l2pSEEjJiVgs4nBu8n1ALFSUX0BbHDFAxRy6BKcGRNGYOB3J
	 ku1q3xR/wKM4w==
Date: Fri, 5 Jun 2026 01:51:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Peter Chen <peter.chen@kernel.org>, Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, driver-core@lists.linux.dev, 
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 11/23] i2c: pxa-pci: use platform_device_set_of_node()
Message-ID: <aiIOrXwc4pNk8ihI@zenone.zhora.eu>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-11-88c324a1b8d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-11-88c324a1b8d2@oss.qualcomm.com>

Hi Bartosz,

On Thu, May 21, 2026 at 10:36:34AM +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
