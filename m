Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC834EEE5;
	Thu, 26 Mar 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515993; cv=none; b=mzxavYTbiXWzCAD9UJxXrREmw/5u1lV/vBGjR0t1fz2yXeGfw3AY3KUvWeuDZof7cc8ftYxde5BApo7CDswo51S+JXKimlJOELXs4NwXZ/e0YjzW1yovP+myXHx/kP/lW2HXinBiGtbFYCEOKe+IbAUpXFpB/6S4GVKaO+3zH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515993; c=relaxed/simple;
	bh=VVG1PDpzJGNO08z2wyalrmB59SeunrwDgcXd3F5RHFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5fRpH3Oq3ukvRp688Qw8803uxV5yBT04NZ9/M+UtLlIPt/cWEo/50SeVhDdxKPSXXlyFy8D3ofXxBfXKeDVPVRi+CHpcAKswiEa2jUTEDYi6om5ph69YIuc5fdntNzR31o7lt0AbzueWIrvkCNA+Lu9bW3IUSiChUERZU5l+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vorpC1U+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vorpC1U+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19E191AED;
	Thu, 26 Mar 2026 02:06:24 -0700 (PDT)
Received: from [10.57.16.191] (unknown [10.57.16.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BA123F915;
	Thu, 26 Mar 2026 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774515990; bh=VVG1PDpzJGNO08z2wyalrmB59SeunrwDgcXd3F5RHFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vorpC1U+9zOBuU9GNFBKPCIdpwDHl++FSf2le78/P4inNrd0DolcNLdaV4u0IuJTE
	 GWyZmbz/gfq/fl4oKNRSiVLZLW+XgwmYKgl4C8jP7Yy66ty4Q7QgzDqJi5F1kyRWVe
	 gBmlvs6sMvnuQn2V3lH0pKQED+wbVQlC1GG/yTQw=
Message-ID: <5951fb9e-cc57-47b1-8274-dea7b84c522c@arm.com>
Date: Thu, 26 Mar 2026 09:06:44 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: fix error condition for reading st,thermal-flags
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org, rui.zhang@intel.com
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com,
 m-chawdhry@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260325081844.13829-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260325081844.13829-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/25/26 08:18, Gopi Krishna Menon wrote:
> of_property_read_u32 returns 0 on success. The current check returns
> -EINVAL if the property is read successfully.
> 
> Fix the check by removing ! from of_property_read_u32
> 
> Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> * Changes have only been compile tested
> 
>   drivers/thermal/spear_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index 603dadcd3df5..5e3e9c1f32f8 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -93,7 +93,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
>   	struct device_node *np = pdev->dev.of_node;
>   	int ret = 0, val;
>   
> -	if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
> +	if (!np || of_property_read_u32(np, "st,thermal-flags", &val)) {
>   		dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");
>   		return -EINVAL;
>   	}

Good catch. It deserves the fixes tag, please find the commit
which introduced that. With adding that fixes info, feel free to
add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
