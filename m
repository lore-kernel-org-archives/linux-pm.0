Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596419;
	b=KmpYH7865bJAQTyL9jabccwFYuPjfGu25YCpKGlQAC7nT8Lz6HlNA0r0hb+D31MTMNxu
	 jFpK2f6jQYGD4KcHdrW5XP8goegNrlSTzfa4Nsvu1MBiLPDmjThZbcV84d/wg0V5i7hcY
	 LUdcds6AEdK3K2HUbYa17+4SeIKmsnyMq+B7aeuLerT31q+54aTCM+0wAWsnsgiFXMkZ/
	 jcWTmUuZZJUW6NPEQ8MYi59ixp66CXgJJSngAQ/ooWSRpq4dQdo1u98QALQ+qoYbpGcRJ
	 mh+8NxQPB/sLLdD7cqJYYkHmcRfVhFHGMmpeoDfZ0kpkWM4ruzGmh6QwZnhuTm5j7hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=46LJk3TZobukCFqYlnEQoPn8+XtFKOEqqL5lCkoAPWQ=;
	b=vyPAKGXMyQK0kbwvGGL77lCw6v9WyD296hcZ6DyS9B7o3vjfRNkREYUpEdTIXNuUXeEh
	 rZe7/FgvwiZFK8viNONWTXQ615vPEQfzvjyykzQCe1Iv23sA1WzO9hIXOqtBEhcnV4cMw
	 9phO0JnZGvNAxXSRJ4JHE+6D9p5jq7XZwcyiM9i5CRclN4eK0uvTaVhJsLnsINw6LVe2V
	 Jqz/1163TIyPOqdODLI2fFV/QjRL9R+sz/2g/MPvMs9KFHMCPULCFml09ifpwDAeHwsSW
	 7uXS2nvSmT8WLiJyWjpNR3JIaggf6kcegYB9LczTTmnB2bA/cKwAaZlyVFA39RnYNIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NOc9sUet;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D804606A338
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 08:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D804606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NOc9sUet
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795596419; x=1827132419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H9lc7gaOvAIKawIbRVS6ojxGIJsVi/jj/Se/VsDrnTU=;
  b=NOc9sUethe16ktmcnd4LVZyXoRF7ccqW25GeXmlKOwYPXsgpr4fARI1U
   gtyG1FMNWOkbH+byCKMBVc9z22pRLqDyapu5m18od4I4QoJb0lAhKaupY
   a7Ff5p2+mKq8E6QwSfwOlzivXx0Z/E/2zTeg/BnIsP3G/A7fbCB462un9
   vca7vTLNyju7/oKfVaF0Mdu7q46Yihef18FLZN/t3gXQ1CDJO+cCc2+dY
   nfS8yqtoYDham+7CcGeXfFbtKKpfneAk3YDumlzPOiwHbhduR7/cxeT3F
   477DonUOBk5EAzh1dNQNtOjptoEXCGEyeKkEJJYedoHInkfmcYedeyFb5
   A==;
X-CSE-ConnectionGUID: nJuE7KwNTv6jCGPgMOgwKg==
X-CSE-MsgGUID: cJXUUPd7RV6CehiazA4xbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4365841"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4365841"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 00:46:59 -0800
X-CSE-ConnectionGUID: tJDNE9WfTyGMmWtXvp2Vsw==
X-CSE-MsgGUID: E2tDNko3SO+ToIriwzOtlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="13591526"
Received: from alekseim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 00:46:56 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A429E121B6D;
	Wed, 25 Nov 2026 10:46:59 +0200 (EET)
Date: Wed, 25 Nov 2026 10:46:59 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux Driver Core Development <driver-core@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
Message-ID: <awagg6rPEkkJR6nJ@kekkonen.localdomain>
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>

Hi Rafael,

On Tue, Nov 24, 2026 at 05:36:41PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.
> 
> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks! This is a nice cleanup.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
