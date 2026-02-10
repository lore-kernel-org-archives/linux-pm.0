Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216231B11E;
	Tue, 10 Feb 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725799; cv=none; b=W5VqkSkPosI2s26abNbbPXKBZr8dP4KANyA3QMBQxrq7//+IOCVkM4UMKY/ac+1cIuJndf/AJ2KEjfRk4KIhLv2ZBClOfYBUxPz4IxgSZJnXbaJ5u0jWCPkyQlts+G/weixZ6DW5cWXuvVd+eg+sMCyrstl7kv4wYwKSRkXhHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725799; c=relaxed/simple;
	bh=Vsl82wTVGHxBGouLrnPGIwzMws2HTm59b4l8xWGMBXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUKCyY515Ko9zBy05EtnXQW+GNOzGSrNDYPi8Cznuc/VCVzePE8rALna9goM9X/+aBx/PtHPjSBw/OfM6u47j1Gm9DrLj01DJe637oUzUag7guhENqudK0RIes7bPsZzM/pDFbImlz27b78OvEmXzAizNMYWSPatt4RE/v72a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xcl/860p; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xcl/860p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770725798; x=1802261798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vsl82wTVGHxBGouLrnPGIwzMws2HTm59b4l8xWGMBXw=;
  b=Xcl/860pRihzv1KqO1lJlTn32UXvmAP6PQcM8NAfEbB7c6WB+Xp8rvYJ
   faeLY5wNdn+oSS04UdKRl90tvVO/F6OYs2jXbU0BSFJYUstRm0qS+bg8W
   XBWnCKteofnJtblRCboZ2ZyrO12bmO6U5qmDbgLR2OD01d8A6q9rBiVLI
   jHG0h4tq2U5HlyRl+NPNMoWOw5eyHpYKtBtkNE4nqwJt8s4thopqFqHwV
   zHgddKniF3X9mNSRQ5YVdJo+X2Pj3HZtdPuIFOK83gEmL3wtDyc86+o/6
   nVUszdRvCE88pz+VzJvGI/rg4NbLlFcWq2aHPml1Yi67KEewj963opKiD
   A==;
X-CSE-ConnectionGUID: J+TkkfgyRYioANGLzQ4JXQ==
X-CSE-MsgGUID: mt8jJW/kQqa6GxfiRALHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="82175415"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82175415"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 04:16:38 -0800
X-CSE-ConnectionGUID: fRMyhIK2SOy4UkOSimVp1g==
X-CSE-MsgGUID: KhRtkdbuSMqkO7lHM614jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211233693"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha) ([10.124.223.110])
  by orviesa010.jf.intel.com with SMTP; 10 Feb 2026 04:16:33 -0800
Received: by kuha (sSMTP sendmail emulation); Tue, 10 Feb 2026 14:16:01 +0200
Date: Tue, 10 Feb 2026 14:16:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 4/5] usb: typec: ucsi: ucsi_glink: Add support for
 Glymur and Kaanapali
Message-ID: <aYshgbUfxnhFdC1v@kuha>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-5-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-5-anjelique.melendez@oss.qualcomm.com>

Mon, Feb 09, 2026 at 12:49:14PM -0800, Anjelique Melendez kirjoitti:
> Add Glymur and Kaanapali compatible strings which both need
> UCSI_DELAY_DEVICE_PDOS quirk.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 11b3e24e34e2..c7878ea0d37a 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -373,6 +373,8 @@ static unsigned long quirk_sc8280xp = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_P
>  static unsigned long quirk_sm8450 = UCSI_DELAY_DEVICE_PDOS;
>  
>  static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
> +	{ .compatible = "qcom,glymur-pmic-glink", .data = &quirk_sm8450, },
> +	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &quirk_sm8450, },
>  	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
> -- 
> 2.34.1

-- 
heikki
