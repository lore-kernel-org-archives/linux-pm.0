Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2C3D3339;
	Fri, 10 Apr 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831334; cv=none; b=Azq9hpoU9iTWoOuA3m0QjV2TT7fbJqSTshJVkPQbeR/Do/Ordw087m9VFhigBfM1WbSNhHL1+AdD3paS61h0XoLdp5sAVW7ksNuL7qCarAWJO8kHYlrt1iNylNeOdQENO952pdMBlsNIDnrxcyQIzIyX0AAZpHas2lFbNeO71JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831334; c=relaxed/simple;
	bh=ikN4F3e5i/tDPUnih6E7ZrW1WkEamfFNPRHqotGPPPM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Od3HJHEcuzJNFLi5ZnLV1kHYVZA5qJWsIur+kmlrm3xJaZK40+Ekz0PfykZKfjcOoTSJfFOSyvb1jNObNZFX9fOyi8JC522OBZ1soW3C3NgTq92gZk9a4LRr2vHoL+ii9Azy7JUbUPxggIfG7sRhzH39x5WRx5EYiJTW874osxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGoWayPq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGoWayPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775831333; x=1807367333;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ikN4F3e5i/tDPUnih6E7ZrW1WkEamfFNPRHqotGPPPM=;
  b=LGoWayPqM+ItL1WJCTneycdL3sXvhb0EYql0QvCoOB5LtX1Ki3Qs4AQp
   7XcEmOJSQq2tCnGXiuT4M1qTgULz0bLc/LCeTSPPBJEuUJW8Ui9ykyu9I
   3OGg9g0lE9yt6/hTz8UEl1L8PUGMlCR8NBAXkwYNa1d4eKTXTRdEIYUb2
   8YSZgjGLzsoaPb7pCjMB7igQYbVMp4QWCI9qJUNEqC13ggYaAAN7QizF9
   wnoq/QngbrVJiONGaKE+LqjmOU8EfZyv/HGgyvIZlSRoxUGoqML3ttxZg
   dLEaZntH9bPXX+s39sgYJc7I+k776Tg19BGus6x3IKRUQDsZC4efzvwO3
   A==;
X-CSE-ConnectionGUID: i39xW6f1Rgm87JDnJed8ng==
X-CSE-MsgGUID: 6opCvnY4SuSyaLXPJMfTow==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76020250"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76020250"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:28:52 -0700
X-CSE-ConnectionGUID: +kUgFpl4RSKMJfG3x6NG+w==
X-CSE-MsgGUID: XLKBo/cSR1eRR04J17m/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="233175175"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 07:28:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 17:28:45 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] platform/x86/intel/pmc: Enable PkgC LTR blocking
 counter
In-Reply-To: <20260408222144.3288928-3-xi.pardee@linux.intel.com>
Message-ID: <58dafa5b-79a4-95df-786a-a11b4d663353@linux.intel.com>
References: <20260408222144.3288928-1-xi.pardee@linux.intel.com> <20260408222144.3288928-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Apr 2026, Xi Pardee wrote:

> Enable the Package C-state LTR blocking counter in the PMT telemetry
> region. This counter records how many times any Package C-state entry
> is blocked for the specified reasons.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 74 +++++++++++++++++++++++----
>  drivers/platform/x86/intel/pmc/core.h | 15 +++++-
>  2 files changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index c8a92d6235203..5c519942ec58c 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1071,6 +1071,29 @@ static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
>  
> +static int pmc_core_pkgc_ltr_blocker_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	const char **pkgc_ltr_blocker_counters;
> +	unsigned int i;
> +	u32 counter;
> +	int ret;
> +
> +	pkgc_ltr_blocker_counters = pmcdev->pkgc_ltr_blocker_counters;
> +	for (i = 0; pkgc_ltr_blocker_counters[i]; i++) {
> +		ret = pmt_telem_read32(pmcdev->pc_ep,
> +				       pmcdev->pkgc_ltr_blocker_offset + i,
> +				       &counter, 1);
> +
> +		if (ret)

Don't leve empty lines between call and its error handling.

> +			return ret;

Maybe put the empty line here instead?

> +		seq_printf(s, "%-30s %-30u\n", pkgc_ltr_blocker_counters[i], counter);
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc_ltr_blocker);

-- 
 i.
