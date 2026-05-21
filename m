Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C52363C55;
	Thu, 21 May 2026 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356692; cv=none; b=PStu+flMocwASBKo5jMsK05F0/5ljQfnJjJP38AcdVgQ7dqiNrvrc3vSMqvOh6+LZAyYVuSL53l5rJ6JXCtj9VvcbfJab0QKD02pDeGHDDg++xguu/rNl6rBtJdxlGhPVz00PLDRQE2TTsbC+CMp/XMt19GD4ko1eYbA9uREAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356692; c=relaxed/simple;
	bh=2rSja1deBM1iWbRkxcvTnfwNvq3KSkNDXw0R+RFBDSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaTfbLKeYuNA1KGPBz0+RNetn7iL/zptkCgZKJuH8GS3eB1PD0YB74FRpGLPoXgwM1nsuJQpJt3/pqW2o7/JMOala7JNBRcyLaYyk13ZMYxZRlNMBPsKJAGFj81W77wmD0U+0XE53uhFOSqvr+NO1ismwlWxHN2MokdfSMNOe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V8bj1nfh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V8bj1nfh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F25A3D4F;
	Thu, 21 May 2026 02:44:44 -0700 (PDT)
Received: from [10.57.36.52] (unknown [10.57.36.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 339163F7B4;
	Thu, 21 May 2026 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779356689; bh=2rSja1deBM1iWbRkxcvTnfwNvq3KSkNDXw0R+RFBDSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V8bj1nfhEwDhWcowxYHmM7Xnhl5rgFZyeqahTQ0ZRV9mLcDf3Ozjm5MGzpI+c1910
	 XJnMbe6wjO4t7P/70yn6macR20HahHT1WyAarLF6Wb7rYAgJ6Mt3h0WXN9SXMbK7F5
	 uXAKXzo6njxuRMgh1oQmzIpBuzaBPmmeqI3TXRP8=
Message-ID: <ddc7098e-5674-4f40-a46b-776c5334bda0@arm.com>
Date: Thu, 21 May 2026 10:44:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] iommu/fsl: use platform_device_set_of_node()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-21 9:36 am, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.

FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

Although I'm not sure the whole lot couldn't just be replaced with 
of_platform_device_create(), but then frankly this driver is on life 
support anyway as it only serves one very niche VFIO use-case and it's 
not clear whether it has any real mainline users left.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/iommu/fsl_pamu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 25aa477a95a95cb4fa4e132727cde0a936750ee2..012839fa0d8a27cafc6a441373f4f6da794388c1 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -973,7 +973,8 @@ static __init int fsl_pamu_init(void)
>   		ret = -ENOMEM;
>   		goto error_device_alloc;
>   	}
> -	pdev->dev.of_node = of_node_get(np);
> +
> +	platform_device_set_of_node(pdev, np);
>   
>   	ret = pamu_domain_init();
>   	if (ret)
> @@ -985,12 +986,10 @@ static __init int fsl_pamu_init(void)
>   		goto error_device_add;
>   	}
>   
> +	of_node_put(np);
>   	return 0;
>   
>   error_device_add:
> -	of_node_put(pdev->dev.of_node);
> -	pdev->dev.of_node = NULL;
> -
>   	platform_device_put(pdev);
>   
>   error_device_alloc:
> 

