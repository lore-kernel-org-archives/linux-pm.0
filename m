Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061B541CB53;
	Mon, 20 Jul 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552348; cv=none; b=GLjbBBzBBZ35tFOdNkV9lJ2AGgzVaJZzLpxNJrv8okexrFsAQR81G9R/mYbqqKxZXbZTRG3nNInFAFwzhdGAf9rDJSAJfCde76gCjQMt88n1kO9t2JqgljDJrhsqeaotdCiojrsH6Pit1KqStNx6tk6M1doPyJ17/bsZj/VF9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552348; c=relaxed/simple;
	bh=tj7DETiWrYqcYhPQBV0lQIQF5ojnhC7kaKJUMMnBNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha7a6JI/Q8Qa7cJlqBoarXuf5GxaV4FbmAPkqvVdJX+IH1jcKS8gBD213bMuuS5JflyoFFVUw7ilp8LURO6LWY56KjH+/4vrYUFAVzcjVbP0479yf3PFDRApcAFyRcfC+ScUU2d0PrMcdDKANcufYN1/SEVKEWIEfyx7YUpfiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dKmABXHE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dKmABXHE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F0EC2B;
	Mon, 20 Jul 2026 05:59:01 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B928E3F99C;
	Mon, 20 Jul 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784552345; bh=tj7DETiWrYqcYhPQBV0lQIQF5ojnhC7kaKJUMMnBNUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKmABXHEllSGT7FeFg6oxaG2ujJktWVxIXZ3hFzKw45EJWrXdCv86Cdi8Lk3ybb+P
	 2eyzZw9sSqz4kKd+F7OoRuZNUZsH093wu+fiiSmVRvRLMFKAt3uEPGr18dcBdv9V/F
	 kKFNdv+XlRp4DjEuV/4GCCvpzaekEZeXf66xmNSY=
Message-ID: <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
Date: Mon, 20 Jul 2026 13:58:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.

This is very much non-portable code specific to OF-only platforms, but 
if the intention is to remove platform_device_set_of_node() again 
already, then FWIW,

Acked-by: Robin Murphy <robin.murphy@arm.com>

(Although I'm slightly puzzled by the cover letter - AFAICS in -next, 
platform_device_set_of_node() is itself very much a user of 
platform_device_set_fwnode(), however in terms of symbol exports, 
perhaps the former could now just be a static inline wrapper?)

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>   drivers/iommu/fsl_pamu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index c83bbc3faad56d6ee1c89b0a7f74028af02c81e9..268a1f752fbceab4fd24013aeea5df1b6982fbb1 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -975,7 +975,7 @@ static __init int fsl_pamu_init(void)
>   		goto error_device_alloc;
>   	}
>   
> -	platform_device_set_of_node(pdev, np);
> +	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
>   
>   	ret = pamu_domain_init();
>   	if (ret)
> 

