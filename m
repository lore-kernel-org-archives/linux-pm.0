Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AD352027;
	Wed, 12 Aug 2026 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522747; cv=none; b=AOwKdTnppygaiIOrtdahISp5JQWukYoQZNNvu6DV9YqVhOHpGDwC9LJNYRWV7cI+VQbsah/eOG5MNqCOqcJ3uEBXHbkYG7Pi4bE1AqMp+ijMptpNyMyHD/+xI/Hsa8Rkjo3NPtwiK4+K81YCjanSKWRmxLIvesRkmYSOnP5KObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522747; c=relaxed/simple;
	bh=UbL3iC09wFptwQM3guce+Y0s7k/vjg+ZL4Ya8Dofdfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWIDYElpMdRCVsVW2f+SJqFlJ2Kp963eks8LdmtCeS/OJPKNCBbXMMHW5OhJSJQMebBuxuST/iy85DuN+XJQy45BiZpUtRl/UKOUHjKeNWY3c4555R196qeJWwC0fjQ5hPHOHZKcvZT1TfSom6UkjIEFaQgdJH5kt/b2KIDrN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf1R0GNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf1R0GNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A71F000E9;
	Wed, 12 Aug 2026 08:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786522746;
	bh=tg2d+uSxSfnEQ+/wwkTn7ftgs1qXWrlfLkCgiC/frqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bf1R0GNVZA16GWAATXUlPxuJ4mfMJXiDCQdYgqoD7y80q/FqN0jKELPlZTl9YTSrq
	 pLpN5vvXrB/Hpwb2Qie70vFXzOaEtxgUQfwS1VvVVj/ntwWHq8sJ4V7c4wUqra+tJl
	 Yu7Hd+z0rnMOw9KFYuMF/fE7zPPyOoJJ+gE0mIJ27Q1qkAQ1YstVhugQlPW/8W8DAF
	 AbLBTUPp2Un1B907c7J1kcG/3mPgE6+afRtmm6eywgjLeY/vvyoDNRVwK1xLJYBz8l
	 BdoJ382q3izk1A2BvnJTdmKd9ULzUj4G1OsjAwisEQrhF8vecaPPNkpzWjNr7I1jAb
	 wPgPPC2subyLA==
Date: Wed, 12 Aug 2026 09:18:56 +0100
From: Lee Jones <lee@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v24 08/12] mfd: psci-mfd: Add psci-reboot-mode child cell
Message-ID: <20260812081856.GF1072730@google.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>

On Mon, 03 Aug 2026, Shivendra Pratap wrote:

> The PSCI "reboot-mode" node does not define a compatible because it is a
> configuration of boot-states provided by the underlying firmware. With
> the new firmware-node based cells in mfd-core, this node can now be
> exposed as a proper child cell.
> 
> Add the psci-reboot-mode child cell to the psci-mfd driver with a
> named_fwnode. Add psci-cpuidle-domain cell first to isolate it from
> reboot-mode failures.
> 
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/mfd/psci-mfd.c      | 27 ++++++++++++++++++++++++++-
>  drivers/power/reset/Kconfig |  2 +-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
> index 7affd6bb09dd..7befc4fa86f5 100644
> --- a/drivers/mfd/psci-mfd.c
> +++ b/drivers/mfd/psci-mfd.c
> @@ -14,10 +14,35 @@ static const struct mfd_cell psci_cells[] = {
>  	},
>  };
>  
> +static const struct mfd_cell psci_reboot_mode_cell[] = {
> +	{
> +		.name = "psci-reboot-mode",
> +		.named_fwnode = "reboot-mode",
> +	},
> +};
> +
>  static int psci_mfd_probe(struct platform_device *pdev)
>  {
> -	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
> +	int ret;
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
>  				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
> +	if (ret)
> +		goto out;
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> +				   psci_reboot_mode_cell,
> +				   ARRAY_SIZE(psci_reboot_mode_cell),
> +				   NULL, 0, NULL);
> +	if (ret) {
> +		if (ret == -ENOMEM)
> +			goto out;
> +		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);

Okay Yoda, but why is this okay?

Needs a comment.

> +		ret = 0;
> +	}
> +
> +out:
> +	return ret;
>  }
>  
>  static const struct of_device_id psci_mfd_of_match[] = {
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 143f3260f04a..1810482d52e6 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -362,7 +362,7 @@ config NVMEM_REBOOT_MODE
>  
>  config PSCI_REBOOT_MODE
>  	bool "PSCI reboot mode driver"
> -	depends on ARM_PSCI_FW || COMPILE_TEST
> +	depends on (ARM_PSCI_FW && MFD_PSCI) || COMPILE_TEST
>  	select REBOOT_MODE
>  	help
>  	  Say y here will enable PSCI reboot mode driver. This gets
> 
> -- 
> 2.34.1
> 

-- 
Lee Jones
