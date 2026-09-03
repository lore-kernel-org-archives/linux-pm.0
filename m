Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4448C8AF;
	Thu,  3 Sep 2026 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435734; cv=none; b=QEGO7G4QycWGVHl+foEXfWIYc4V3vpGFSPOlU1GRteEF7hBKgR8ulosJoSq5zknC6qTKdSKcP0IW4gdxYHCxyoHThyVZ3j4y48H6IrqlU34jnZVCivBI6xBrw7vajVq/6n+qlT9GqpamK8AtE835h3JTXMq/u8U63vSHLkpZuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435734; c=relaxed/simple;
	bh=l7pMTrcrpxi2soyjIsFC1foglwpNrwXml8OZYOTw2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Zj3MqBffKTS3HPRd+UU4rbWkNg0f00M8JVKzIZssoRBFNYfPHMwVkV1l7v5VCjIBn1HVR5ugm91OPU2VS2kc2Xotg2rMuaKx17zzzZfIb2pICyW2MzMutIvMeyhPUi4OSfJ2RI3YDxaISG2qHGt8pPAICLs9QCi2wyTkY8eGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8ATFYkU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8ATFYkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788435721; x=1819971721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l7pMTrcrpxi2soyjIsFC1foglwpNrwXml8OZYOTw2TE=;
  b=B8ATFYkUGmNW/dB3341wC3PUHYTyV7q11RoBGtI9ulwGV8JQili3YS8F
   oAoSeLb2IV/sLsOAwdOKpqk0cGZjSL0/ElZGWH2dWirTJWGqSgJmlxbx+
   xZ0EbdM7Tf0Y9XFt4JOfGrG2jdfj1QULJjkoMHsXIcnY5YQAPS8QEPMuc
   bGGka/SNVDBRJVpdJF1uGmmC6yLNxhklp9UTUtbqVmdiwfNawKUCYl6a2
   27Mm8poxuMfBTfAybTMR2UjSS2amI53uUtL0QmK/f0FOLWZWszJg+eIco
   ZLrEBVXuoB4UrdNmkmINGJVgtVdX58y0sWGiv0WPsBFn9WYrgZ6AENl3H
   w==;
X-CSE-ConnectionGUID: eWwEjzkmR4+j9I7qfTBLlA==
X-CSE-MsgGUID: fb6cgnbWRcejj1rPXp4sTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100272485"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100272485"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:41:58 -0700
X-CSE-ConnectionGUID: s3afxq93SkCskv9Xgxi6Ww==
X-CSE-MsgGUID: FJ6bO2apTGKqxxcB+9gzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="263502591"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:41:56 -0700
Date: Thu, 3 Sep 2026 14:41:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v1 1/1] thermal: sysfs: switch to use scnprintf() to
 suppress truncation warning
Message-ID: <apldAi15zjgHJO3S@ashevche-desk.local>
References: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817103324.1020212-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 12:33:24PM +0200, Andy Shevchenko wrote:
> Switch the sysfs code to use scnprintf() to avoid warnings about potential
> truncation of the names of the sysfs attributes. We can't increase the buffer
> size because the size is the part of an ABI for some reason. Note, with
> the current size of buffer the affected attributes have a room for up to
> 1000 names, which ought to be enough for all cases. There is no functional
> change, as the same limitation was implied before.

I still have the build issues, can we get this applied to v7.3-rcX, please?

> Fixes: c56f5c0342df ("Thermal: Make Thermal trip points writeable")

-- 
With Best Regards,
Andy Shevchenko


