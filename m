Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECB3BB101;
	Thu,  9 Jul 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582428; cv=none; b=tsJMIL/fZodIHlWS8uxrQ7mzk21/CrTe3vxgcHBOFBta4+uPwhoposxkaOEeRSftO3Yc8NW4BzLxFdJteDdhv61jrX77OKK+DcEGs2q0OvK9eJwwBXlmocO3dbhfWAQOHBdYLsllt0zuPZ+B1lou4nnKlseQXp+x+poKPRenp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582428; c=relaxed/simple;
	bh=Z7l+gvXk3JDQmEUoKIVr9+b9SPFOlR8x569miOzasGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIpjln3ka0FhoR94iTSd72vIN7446GOVs483x2XL2opjGW5WmzED5KlYkffaKs/yu45jyNjNOZAVMztoYVX5M4sqsoMsf9Jm9KamWzJ/I8M+oB0xK/GNbxCBOZucpC4WmTPsBrUL5HdMTN2vYQTsvR/8EE2z4OaX4EfKueYxAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfdVb2gB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfdVb2gB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783582427; x=1815118427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7l+gvXk3JDQmEUoKIVr9+b9SPFOlR8x569miOzasGQ=;
  b=jfdVb2gBP7/Ttmnx0ZufdqOeMMIWUbAiH3RO099rlaPzIeks2j60Ck5D
   FecSmpKS27MwF/NVACRd4JZ+n2r8UrogN+G9dTeBK/mFCK/G7p89ygHdT
   96a8eAmiEC07jr8CPY7I+gj3EmNtuoDe56EtIXb550yeBnWvUT6kkIadb
   3LP0M6ax3kGUNTvmTUmfzdCxss5gaOenRKmIpYiJDhi0fSkUek4cgt5y5
   hVHt62zOL5zhWlnM0sS4W7hmhyXqnoQ6pvDyMnrdqTBXTCSiO8u2CTlSW
   4G/C7ZDkGgsHOlQ4RDTsLK9p/CVn8W6zk8e4aQ6e4pfVKqXIqofY12WaM
   g==;
X-CSE-ConnectionGUID: h/jKVMmMSl+w5FTxbb+z3A==
X-CSE-MsgGUID: wFW81mEmQROmK4IMImn3jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83367144"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83367144"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:33:46 -0700
X-CSE-ConnectionGUID: EN5Bw27PRyOtBsvhIkOV8A==
X-CSE-MsgGUID: zHTCZuw2SR6j4VFc8OGiRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254024272"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 00:33:43 -0700
Date: Thu, 9 Jul 2026 10:33:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:THERMAL" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 16/18] thermal/drivers/st: Remove redundant dev_err()
Message-ID: <ak9O1eHHS60r15nU@ashevche-desk.local>
References: <20260709023048.599150-1-panchuang@vivo.com>
 <20260709023048.599150-17-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709023048.599150-17-panchuang@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 10:30:19AM +0800, Pan Chuang wrote:
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.

Correct.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


