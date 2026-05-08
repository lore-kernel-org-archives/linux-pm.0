Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410A3E51E3;
	Fri,  8 May 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266472; cv=none; b=pzmo/KOBAtRoa0oevWc7ye0CZmDoKf6oemL/aVCBcXeaezc1oKKWRyr/Wk9GVcQB9G/fbnm6iMnBZ9GKMshU6bxWDLvYvLQ2S3wooaAP+4LpDsB/wE99vVDbjHF82PTNaWsGWaUSsKkm6Qie6ztRcGLbyAEb+ZLqkWjDMCZKCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266472; c=relaxed/simple;
	bh=uIdL8/fLOPsOkGJNDM45smulPXjw6aAf4dO5G05Gt2w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MfBQwOiF+wgr1V7iDKuhrSsOZ7vbUj3o1DB/VKAZrQZzBAdAytAHe74k4krS54uqeNZNGyPOObCwPPgeDI4e8uwaofTWtKmRcfWh9kpXkkTvugCmKp+K/FsUTufmHaYxlR1WWOarf27C7F0POUPLXy7f35c3xXLTM0ESJ8z6tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4HxuWG8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4HxuWG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778266470; x=1809802470;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=uIdL8/fLOPsOkGJNDM45smulPXjw6aAf4dO5G05Gt2w=;
  b=a4HxuWG8TnNiS0AyDpJ4nbzyHZCRuvwYFFMxOZK56ChU7iPTO4nRbUJH
   QKRX5moxpgmB3E/0xePg4VgseS3EOyGRnMy1iBTT3C3qXkKhrWIayTlPj
   fHbIHMSGPoYBdQg7neAbHa7YHKhwakRsvmiPaoPvjM5AlIvjeTArN33ry
   KdZVjhvUPDBgvrlSMKo0Rprh1VaD8NO2/Ed7u6YWsmYJon82x3XleSAfg
   DXcanWJNmFygr+TCxYf+xuavPO1L20+UgAKNvaluFa28ht1UPmuNHvrKH
   7u2YpiS4kL7+h4452Z/WMjmXqQmj2YyQSERieQa2c+YreTXTSq6WbOD6b
   w==;
X-CSE-ConnectionGUID: X0rXTeKaTcmZk4mg4zwnWA==
X-CSE-MsgGUID: CpF4O8BMTeaIjSiruW95HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82865092"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="82865092"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 11:54:30 -0700
X-CSE-ConnectionGUID: rsdERbEJS8Gvutq6KCQN4Q==
X-CSE-MsgGUID: a9+2AxUYTzOql4OrFE18Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="236016453"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 11:54:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
References: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v3 0/7] Enable NVL support in intel_pmc_core
Message-Id: <177826646106.13514.14306221058288030989.b4-ty@linux.intel.com>
Date: Fri, 08 May 2026 21:54:21 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 04 May 2026 21:33:31 -0700, Xi Pardee wrote:

> This patch series introduces two new features, enhances existing
> functionalities, and adds NVL support to the intel_pmc_core driver.
> 
> The first three patches add new attributes to improve Package C-state
> debugging. The fourth and fifth patches refine current functionality
> for better support. The sixth patch enables the intel_pmc_core driver
> retrieves PMC information only for available PMCs. Finally, the last
> patch adds support for Nova Lake platforms.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/7] platform/x86/intel/pmc: Use __free() in pmc_core_punit_pmt_init()
      commit: dfe614f82e445a65cb2afd01859b06b01fce8889
[2/7] platform/x86/intel/pmc: Enable PkgC LTR blocking counter
      commit: 38c79dd63b72e36919ef097d4e5025ca0fa17f34
[3/7] platform/x86/intel/pmc: Enable Pkgc blocking residency counter
      commit: d727eb1c3ede7c21f885ded1f1ad65b47434a9b9
[4/7] platform/x86/intel/pmc: Use PCI DID for PMC SSRAM device discovery
      commit: 11de0586ecf40aa747972f1b0bf88bac192d7b06
[5/7] platform/x86/intel/pmc: Add support for variable DMU offsets
      commit: ebbf33380896cc489e870d88004ad3750e908a6c
[6/7] platform/x86/intel/pmc: Retrieve PMC info only for available PMCs
      commit: a7d5916d132300b1ff6ac0c5f6d7a7cb7817a7fc
[7/7] platform/x86/intel/pmc: Add Nova Lake support to intel_pmc_core driver
      commit: 41354f4c8a791d3059f4355945e550693ac87ce8

--
 i.

