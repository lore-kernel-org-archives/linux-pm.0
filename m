Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10532F75B;
	Mon,  5 Oct 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222327; cv=none; b=J6RS615O3aI3AlnedKlFUFfD15tWlRDZ35B0yKE0bQJ/5XxqAtXgcvYHxQg6RWtgaCn7ChA617ArVCwYDAAqD0r3oBXz/4qYzLYdHEzup3bfESJ+GaKDWsNlazukF7GKdXtlzQdCqERU2jlkrJov8yau7c8CJs4iwhwWN1nz+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222327; c=relaxed/simple;
	bh=IwsxrNH+EERJhHnXgxoH8s/TyW3qc7oljlQpmLF3eEs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tpb9W/tYPujQ3r4B0RCmolymn+nRkopc6WwHe2kZGFIkCDFzzAIwEEm2g9A4BzvxBtnNEhVxQyaio3G22xQg3aodhOT7hLoxpRKeZZ/WB9hFht++0Aa1ebtfA/olWAVvDmkE3VJq+/1LGjUVSBoypBtozK1ZtK8IrlntexOiz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCOhz+LA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCOhz+LA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222326; x=1822758326;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=IwsxrNH+EERJhHnXgxoH8s/TyW3qc7oljlQpmLF3eEs=;
  b=aCOhz+LAHrY8oGPuM6p2or25A0j3ztPmf9q2Vb2EJVBaChJDBpUSdJOA
   guM0iivypGrpy/6T+otNl5UyvNcqd2JnQu8YqXdwrBbLK+2OU4m4OWc7C
   RuX+XkOngeFlvSI3yXAozkXLCraPWlwfvlXToq6zwL+7zNcLeh+U47lGo
   L3ztKuKSN4HMyFxRQTibarQbcekeaZp0zBEyaacjs2TvGE1WDPNRFxLvi
   8BuNp59DwnYO0hcZgx8Uar8N5TJSEDrq94TdfxK6bAQFyHFnCsyzHAuS1
   mV+R4nphQRs6ZVXZdxNeGn/h1iHaNxDNkDjR4UG72WRZx/oyIXEo19SJK
   A==;
X-CSE-ConnectionGUID: qZGlOkTaQhyCQf9i4tnOSw==
X-CSE-MsgGUID: aKFXR40XTn2pG3pF1Ku+Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102064029"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102064029"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:45:25 -0700
X-CSE-ConnectionGUID: rOkuFnvaSKmWv75+idvWAg==
X-CSE-MsgGUID: AX+4CZ0hSP6SNCCGI9dBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="937401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:45:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20260919051830.565240-1-xi.pardee@linux.intel.com>
References: <20260919051830.565240-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Fix stale NVL PCD-S S0ix_LPM
 telemetry constants
Message-Id: <179122231918.27048.14002305732775722679.b4-ty@b4>
Date: Mon, 05 Oct 2026 20:45:19 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 18 Sep 2026 22:18:28 -0700, Xi Pardee wrote:

> The Nova Lake PCD-S S0ix_LPM telemetry layout changed. The PCD-S telemetry
> GUID was changed to reflect the layout change, per the client GUID
> revision rule.
> 
> nvl_pcds_d3_status_1_map[] was correctly updated, but two companion
> constants were never updated to match:
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86/intel/pmc: Fix stale NVL PCD-S S0ix_LPM telemetry constants
      commit: fcad4877a04ea40d0402015a3c4bae89677aea12

--
 i.

