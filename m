Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598895;
	b=0xGVZP4Pcd9GFG27+ke9JwgVG+raOZhQOVmQ4VofeKfPoZL6QkTj1rpHQKscxRW35742
	 L2c+lESSmzG7IfOxUPWWSCr23N+l9YP8DmFFO37NJD+79RzJ5pUpwWXyxrbNm/WwrrAMd
	 +4cM4uGYd0w1rw+Wc9I2acztZQw3/t1vJ7pIOJCq07q1BStMoWmhVZ0ssd0b1kqcVxvrM
	 EZD3V86l/Vee2NssThb7P7/H3OxU5z8YUFbEQlUBbxzp+CLvPLwevrloHBOxzkQBKiFJi
	 SCVH1A0BPRkabKkA97rqDJ9STnoi8qxzSnXN7Xp+PSNMcLR/+JqkdYdhiu1rsjbhtIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598895;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=BfIuPi2PzsCCRzlgKhGMLtJTfCeu11FC5PErKOZR9Fk=;
	b=01RYSv/eJ16Znf29e4C6g7LR+1esBkC0Pj1LdfU5Yd4HVv65Avl/qtHNyhlgz2AQruiB
	 r456T/rJMQVdVw1obj61eH5Owg45xBBnRMN2NVhd5+yNIWvg/MZxTWUppLVDpYSJyMA/+
	 +dRY/JnA9JaiRx+zydctHOuCdMZyQVyrJo+9XpEVdcPkmgn3i/z+Uwt8/aqAbuM8ewjfp
	 RLjFofEd2V88b2ehHNAOvgsLEk+YVtO3jONjpd3OtPkHEGU5m6Zk3pxpl40ACg83jusNR
	 qmOdx/9f1cHtIoM+N4YFB509d4ZWVrS1YfPizE/rIXxUvQMD1kgOIM/qzJHWssDLtAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CvQ0u3aB;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6C606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CvQ0u3aB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792598894; x=1824134894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fynGI9IxOdP4nN1Vm43mUR4s3SAukKHw5gvQmkS8uig=;
  b=CvQ0u3aBFf5JLptpFh2k0afOAnWWuwJ9Pxm1mHqPwMhxunz8V3yYsbGU
   rWfa6gC0wvgeSQftYITTkV5wQPm61dgKzAGvHsk6kUy8jfhWGGuHSCzX5
   3kbORsfJc03OWsEQQ07fH22En8FvWq04sgfZdbHDOkkRN3m122qSp+HA0
   lOc7B75ckVGfJM/qh/IJH5wOOZ57ypt2khx1WQOFKtCQ8jCmSmiFnZT1F
   sJrwLcPGEyRaPMfEn4Uj0cbfYkBc2PgD7yLYM9CMdglTwUJqnwDogU4wE
   90xB2oyOwKC+ijnxvprL6cMi0OxqMwGe7TMtEvFukE/H6ZeY1ddTmNI3t
   A==;
X-CSE-ConnectionGUID: uUg76I9KSBmn+v7fDL6N6g==
X-CSE-MsgGUID: cU1N4dGmRBaoqNV/RKUwBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1205293"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1205293"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:08:14 -0700
X-CSE-ConnectionGUID: PRzBxMaJQPuIsKgY8+swqg==
X-CSE-MsgGUID: bQrhQdSPTRWn8kPLX4NZOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3071120"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:08:13 -0700
Date: Wed, 21 Oct 2026 19:08:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 08/18] x86_energy_perf_policy: Bound package iteration
Message-ID: <atjjajHqraAMSq0e@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <a9747d6a5342266267b4a4ce424c03b286206cb3.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <a9747d6a5342266267b4a4ce424c03b286206cb3.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:29PM -0400, Len Brown wrote:

> Add explicit bounds checking against MAX_PACKAGES in for_packages()
> to prevent potential out-of-bounds bit shift operations.

Can be done differently, but I believe it's not a hot-path or something that
needs (micro)optimisations.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


