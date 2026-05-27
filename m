Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7425D215;
	Wed, 27 May 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895925; cv=none; b=mZhEbgAQDQDY0QDKF0ShnfUZx6UoAKUH2ZYgcRA3lSgy0ACZbjyIV2xxWJhsUKkLQRq+00nrp95IktWmbueJ2Yma7qtRDtdlSH6+lVbRxULrRfS2Aqel1UMZMrVZwvODTrggkXC8KrpdrsRZlXRDQc2Uoh9bDYo9H03WMs8JZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895925; c=relaxed/simple;
	bh=5nHLKp+sy0tnxXWnqkXfQhkOAjPNcQzLML8Vz6khoVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTXi5UEmta7yuvfXdOqKEMut5g7yAR7Pp3JbAEERZGaWzEc4YNYMkSoBLQrEFzbDwVw+V8a5M29LFjRmCu9MpCumuLi2G+aQ3gTMUO+dJYsMHa3CkUbRtjj0ptW3xVhsHVyI8711u4KXO4t1lvyIYV7vGkeh6L30O/jZ1n+JnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaGGD42N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaGGD42N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D1B1F000E9;
	Wed, 27 May 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895922;
	bh=sPB3GQXOChiJjIRbQ0GadVrki7VxeBUCGhJ+IYPxXck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FaGGD42Nqlqm9Nyx82W2AqDxkvBm80X77FAB3xKsnB+oVYWMGraAhP/mSIhzds8aU
	 rAdVdkgfpXi0zfoMtLHCnzHMYI8h4wVrNIJvZi0GpukC0Z2xP0WEMx4b6piMpwuxwu
	 Swrth+betjV7a3t+m6opjKJfj7sE8+8RGsReZVZp3AKobeajhKzNfp8QFh5rFW28c0
	 6QJjLJdtNa7ndhmgSLFzIHNshPz7tSIbDpSsmNU/Vu7pBO4OR3fw6ioR4bUcHlyQgG
	 vC11omiC6aVPZvCoxV6Ww88fHKvZdxYEjcPgf6jrBhhFmPTd09gPa3EsJdTZ6SrZ8h
	 oy6tsLFZtmWSw==
Date: Wed, 27 May 2026 16:31:48 +0100
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 15/23] mfd: tps6586: use platform_device_set_of_node()
Message-ID: <20260527153148.GC712405@google.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-15-88c324a1b8d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-pdev-fwnode-ref-v1-15-88c324a1b8d2@oss.qualcomm.com>

On Thu, 21 May 2026, Bartosz Golaszewski wrote:

> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Lee Jones <lee@kernel.org>

> ---
>  drivers/mfd/tps6586x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index f5f805446603315ba76ce1fc501c908f1cec0d16..3cfd2f02b62f3cc370e0d970ec2643b638fd0fec 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
>  
>  		pdev->dev.parent = tps6586x->dev;
>  		pdev->dev.platform_data = subdev->platform_data;
> -		pdev->dev.of_node = of_node_get(subdev->of_node);
> +		platform_device_set_of_node(pdev, subdev->of_node);
>  
>  		ret = platform_device_add(pdev);
>  		if (ret) {
> 
> -- 
> 2.47.3
> 

-- 
Lee Jones
