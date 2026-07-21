Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E943B4EB7;
	Tue, 21 Jul 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622279; cv=none; b=Tkzh9qMmPOFSpt5F37VITA0+1+0CdVkoBsfd+w85uBaETJYhfnPsNCljmDUc1elBrt5JL/3qOTJHkia+yI/IflaoXJAwKpJFu/Sh1/bemtvCWk2EYBvx0LvO/Y70F4+W5xBR3dzioStS/VakbpAAhgdi4bnbiCblgOWjMQ0w7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622279; c=relaxed/simple;
	bh=Iz3hgGuTUl3Zn7E2HnO+ANEaXHOTLFX0kWsksu+bKjE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IycjagntiCQgBjJdo1SXWM7TiPvzwmnsAXPfs3YLhCVT1/LNhrSjoV/qBIThLwKgfpqFD5GUNuSukZSpB2xVZh1WhEsQkTAw376D73cKWUy5owAxmSNIAtr/UdE3tsSsUBAg52TghGGaZ4IOLrV6+Z1WgjBDC7EpEyyfCOxNWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAlpBo1N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAlpBo1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784622278; x=1816158278;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Iz3hgGuTUl3Zn7E2HnO+ANEaXHOTLFX0kWsksu+bKjE=;
  b=LAlpBo1Nm0V8LjeYNSN+FYc7VC5UPCuofJCy+DOHsZTX6eZ1CMn4ZZLB
   Pyw6vIVMhbKe+CSC02trrHv6fy6urMN73uQP3ES1+TIdYOhdWMSfzu1i3
   UjDR5rwH2ntivfJZXpU1Ctjue6rTonoO4ll9kFwcVYvOuRvQvvGtYTNmt
   ddDBBndYGU5nim3/tpImBxD/MoZD/OZaVGiFESDRJSXwOpFeRznXjVE2l
   xR+uM6rGBrQZYp1IkteDPsQUNKP1K6U/tKyJz5WBIZ2H3DqS0g7AyQWkd
   Opkbws+6J/MLN+e0HFHnGYBDLHobfcjyMD1hKHpANSVvxTG7wh6W1hwEY
   g==;
X-CSE-ConnectionGUID: c8fb7lZ+Tt67suYGeBoY7w==
X-CSE-MsgGUID: j8FwEt3CSB2qD6VTn67ZLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85306674"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85306674"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:24:37 -0700
X-CSE-ConnectionGUID: Gs7+8AW2SZaxvr2Xe1jRSw==
X-CSE-MsgGUID: BOy5TSkrQuec/qN2vCinvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261472685"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:24:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 11:24:32 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmc: Update NVLS PCDS LPM request
 GUID
In-Reply-To: <20260720231219.1278923-1-xi.pardee@linux.intel.com>
Message-ID: <4f188cff-9339-4677-c686-ff5f6f66b6f0@linux.intel.com>
References: <20260720231219.1278923-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jul 2026, Xi Pardee wrote:

> Now that NVL support is available, update the PCDS_LPM_REQ_GUID for
> Nova Lake S (NVLS) from 0x01091102 to 0x01091103. The PMC core driver
> requires the correct GUID to load successfully.

Hi,

You need to explain why this has to be changed. Preferrably so that it is
followable to anyone without inside knowledge.

> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/nvl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/nvl.c b/drivers/platform/x86/intel/pmc/nvl.c
> index 8dabf2511dd9d..1ed02332dbfce 100644
> --- a/drivers/platform/x86/intel/pmc/nvl.c
> +++ b/drivers/platform/x86/intel/pmc/nvl.c
> @@ -14,7 +14,7 @@
>  /* PMC SSRAM PMT Telemetry GUIDS */
>  #define PCDH_LPM_REQ_GUID 0x01093101
>  #define PCHS_LPM_REQ_GUID 0x01092101
> -#define PCDS_LPM_REQ_GUID 0x01091102
> +#define PCDS_LPM_REQ_GUID 0x01091103
>  
>  /*
>   * Die Mapping to Product.
> 

-- 
 i.

