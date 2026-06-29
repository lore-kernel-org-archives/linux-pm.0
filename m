Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A71632DD;
	Mon, 29 Jun 2026 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774922; cv=none; b=GQOkrvntxaXCa5ysQeVdPdrNlm0Oh96fJR7veVcOD5DKuAmQ3NL84L9OK+Fz6261qsAgeV9rWedtfWdci1jpcq0ZeHcDTwBPhNvRgLPkVyHA9nXIj15OobZxQyyvru9UriYBAI9fDAn0RhG09ylrn10jCUUtWGn1BoGxLM7oWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774922; c=relaxed/simple;
	bh=5qA20pRRqXQqyqhmgrm9hpsVJ87sWrrB52/4s12fm0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URWQQcC8MBnIzWvXwdwjU4/eu9nWrJGet0boA0Fl6vPCZpbMecNx9izNPtGq8x7kyWdufjeHJXA7ErUPDY+EcfoEtQ8AtISsOaoXrd13BRMkQV/8tiFo2l8Lm/03DauxgE9cFQCemB5XzhomK5JjOdRIvBNvQREWc9ZOIBwUQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot0qqQP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot0qqQP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4810E1F000E9;
	Mon, 29 Jun 2026 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774920;
	bh=PTDwVtGU6wid+Bgktvqm3ZvyMDN9HQ00NiQBzjMDb5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ot0qqQP/lCjO5k6zzU+QNvbWLaxMC7H+3qFT92VX2UvZABSNZ6N/MA2JGDbKJUoW1
	 4M3ANFO3DORGIYjuAUU/OKyDgSRndVEow6+eo7gKf5g+h6Nta8gSgEIp649T4tfv2a
	 8Ktiv40iRLVXohmb+zQ3jkItGTS3vZB6ZyGiV6EAadMM+RSY9n/MsJxwkhpr50kHGz
	 K31LH0XcB6aN8eoHIi7kAdwqtv4A2jLe1FlUnosYLazPLozsAtx0LBNaD3AJjzlXwS
	 /WnVFsJ7hsxiDjHHixfIDpBA9qNUdqfbiOjfquNqtwGGDI5/40gxsVd0QLBzUBZA0k
	 MY+MvMrB9YDBw==
Date: Mon, 29 Jun 2026 16:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, Thierry Reding
 <thierry.reding@avionic-design.de>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod
 Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de
 Goede <hansg@kernel.org>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 09/19] net: bcmgenet: use
 platform_device_set_of_node()
Message-ID: <20260629161517.34754824@kernel.org>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	<20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 11:12:32 +0200 Bartosz Golaszewski wrote:
> +	if (dn) {
> +		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
> +
> +		platform_device_set_of_node(ppdev, np);
> +	} else {

Please don't blindly use __free() in cases where it's clearly
unnecessary.
