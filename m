Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29531D366;
	Fri, 24 Jul 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905130; cv=none; b=DxhQ9mQPhTy8t44BnIm1uIonxuZlDQZvKBXm/+iCc4m36lqoU43CSYRZA3MKHbmv5NBCSZO7uaurVTgN/nwO5cX9PnOHxr0sfLFr1uFgRMVSle5xSmb7c0KIfcfwZTP0enM9pl/sS82cgre9SI38Md3CHwzc0i1Er4OPcv2y51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905130; c=relaxed/simple;
	bh=Z37F1Y/y5gZJSWE1m+vZX0+yXqCgiPgCG/Ql/3FzlKc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D5WrRLG1MX7hj/m/Yt4dLet9L0EhUDKRbHLQs+2MBGSbXmrHyz3sMhWvWIcO7TAzsOebSlpObrdgvpRcmk6MH/GxIvs118kMty+14lu58SVMjYhHqxUK0ynixALweATZb17eAfWi9XxAuHPgF/K6Dyu7SCweZQfUWVXIEeuEw6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmmidWge; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmmidWge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784905127; x=1816441127;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z37F1Y/y5gZJSWE1m+vZX0+yXqCgiPgCG/Ql/3FzlKc=;
  b=gmmidWge6s92dH258HyDH9xIOfXKSpIXu8Y3JKAVMNpiHwubk97GHU5p
   hzOubxcU5tIISJYHo3AbCNsUz2JqHVk7Pu4AQ/YYd7uysS+3nbDkZyLiY
   EVtkhzXOd3addPlpJ8uCffQlNZ4xuii5XbFEm2YLCHkaIMX9R2RxspVho
   QgPUrqMxt1nxttWdN7tjP9MC6I2pWpwHC6DGf8K01RUu2L9wE80HqG0+W
   +/KV+fbSLUaAPvAr7YF2n4gzysNj4udGf69Qi30nG7pjeeNQ+0X0FCb7P
   3euEn6QQEpZzR9QmuACpwT6Sslmq+395USmWdW8I0fVCzBZ3lvcVNyfWj
   Q==;
X-CSE-ConnectionGUID: MuVZOwa/S5q4eLP519HiOw==
X-CSE-MsgGUID: 38QSr4+DQcuevNeqxbgR8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85764053"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85764053"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:58:47 -0700
X-CSE-ConnectionGUID: i2h0bnRiSkmiUyIOuUZ3pw==
X-CSE-MsgGUID: lcUP54QYS9OEn4xfKJhLog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="262248862"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:58:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Jul 2026 17:58:41 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/intel/pmc: Update NVLS PCDS LPM request
 GUID
In-Reply-To: <20260722215259.1382305-1-xi.pardee@linux.intel.com>
Message-ID: <d332044c-c1e8-c3cb-113d-1bc79043f2a8@linux.intel.com>
References: <20260722215259.1382305-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Jul 2026, Xi Pardee wrote:

> The PMC SSRAM PMT telemetry GUID for Nova Lake S (NVLS) PCDS die
> changed due to a firmware version bump. The GUID is used by the PMC
> core driver to locate the correct PMT telemetry entry in SSRAM; if it
> doesn't match the firmware-reported value, the driver fails to find the
> LPM (Low Power Mode) data and cannot load properly.
> 
> Update PCDS_LPM_REQ_GUID from 0x01091102 to 0x01091103 to match the
> new firmware version.

Hi,

Unfortunately this still lacks the reason why it's okay to not have 
0x01091102 at all in the kernel.

Whenever there's two (or more) FW versions mentioned in the changelog 
and one is taken away, it should be explained why "removing" one does 
not result in taking away functionality for systems that have the old 
FW version.

It may be dead obvious to you at this moment such as that this thing 
hasn't launched but it should still be recorded into the changelog so 
others don't need to lookup such details.

It seems to become a theme these get updated so hopefully next time we 
don't need 3 patch versions. :-)

-- 
 i.

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
