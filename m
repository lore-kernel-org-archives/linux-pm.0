Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096947F2D3;
	Wed,  1 Jul 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905478; cv=none; b=YwNDtqqawxVF382pIiLiYJhay1Fbl1vqd4H7pXN46oAKxxN9xEifKwAOSjvNkH8ugpAyN2wPlUmxJgpQfDzZGPTXliMtgS4LCmCXKiWSbJfiyr0qZTQUZcmIR70TOFddupFzbkxWhSHUTitRtlTlc2XPd+QH46soGJgkiFqZzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905478; c=relaxed/simple;
	bh=GKjno9HFuSbao2xvBNrebi2Q4+5znXdp6HvAOPQVjsU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RLBDusbdjLz1rYSKxCTyJEA+D674d7cWCMcxTEQvthDkV3Il4eWwPu6NgILfyiAq4joC4iaPaHYnzywQRI7vvOwkjTUZQhTdrLAUNrqf1EpRuRdEO0hDVX8HyRgbIfQvNU3TUEKui5wRZxzvhgi/6WZlSVcGGKVSz/Z3rmQ4B5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj9ckOMC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj9ckOMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782905477; x=1814441477;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=GKjno9HFuSbao2xvBNrebi2Q4+5znXdp6HvAOPQVjsU=;
  b=Fj9ckOMC/ewhvuSfaCu/VUT3nJsR/y/UC680h05O150hGYqlg9C4wIcQ
   22WvNLpAOxEqKjeHAtlQLD0Jv+LvGSRYfzQXYAjUuBPg0ZKTp7xDtm+/R
   7lwWe/vB10W1r/2s0wwkbsQZqR7NsktrRrVDKOY2cRTMVva7HrhDsyc/8
   Nt6Tc+4EpkYWY79VBYlRdM5WakywwIegNQgpSajvBAIzm9ODaB1dnVdbh
   8AErSD7KsxZYqB2YcyjXOuboeqlQddBCASXxiWpMfgXIjleWlK3ix6YQv
   nMg8kMHx8hj8FqAtL7mPvjZb2S2kg5jUgnx9Y7uRoJGApbunXugoJyg1c
   g==;
X-CSE-ConnectionGUID: FF0qrSkYQSO8llEeR8Do3g==
X-CSE-MsgGUID: aSgAv7h6RmmvdcQiGqHiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94235246"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="94235246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:31:16 -0700
X-CSE-ConnectionGUID: 4orjbU/QQjeDltdBM6+f/A==
X-CSE-MsgGUID: ShK3hB1XRnmE0ww8nie0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="256889036"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:31:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
References: <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1] power: supply: surface_{battery,charger}:
 Consistently define ssam_device_ids using named initializers
Message-Id: <178290546835.22449.8997171259957042077.b4-ty@b4>
Date: Wed, 01 Jul 2026 14:31:08 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Mon, 15 Jun 2026 14:51:37 +0200, Uwe Kleine-König (The Capable Hub) wrote:

> The .driver_data member of the the two struct ssam_device_id arrays were
> initialized by list expressions. This isn't easily readable if you don't
> work with the Surface System Aggregator core regularily. Using named
> initializers is more explicit and thus easier to parse and also more
> robust to changes of the struct definition. This robustness is relevant
> for a planned change to struct ssam_device_id replacing .driver_data
> by an anonymous union.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent or clearly a regression fix.

The list of commits applied:
[1/1] power: supply: surface_{battery,charger}: Consistently define ssam_device_ids using named initializers
      commit: 2f0fab3e8ef925e10dcfa04d1df9cdf1015eda8a

--
 i.

