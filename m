Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600945;
	b=V1QLUwbjzC9eBFfOGfXmlc8WUQ5BLBdCP/iXvP5J2auCM8E16r6Qn6CYTnWydM/7nQSA
	 mC9riwjtKdSF7BpM0BXryH/icenurvDqikpmcl7Fan+mtXds4C1uuPW9o39IEAlMGj9/F
	 2T1AWTrxWRSdlCPe/gB6xbZHc4tGj62X4ACVpX8NRFayNfe3UyxPd/km0TcVc5/1gLiUj
	 JBoOAl05CS0dHVLrMI9VxUhX0XbW6I06cmNAdPx4XDRYhzA8CWHhEZQZq+BMjK+rhMkCF
	 czSa0O27JoyDjOJFmh0Kot4KouJJiLVFD5YUiX1c+M8+Fyj7oxBmNMoWzyGXwZKxt+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600945;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UVOU3FQ6JgpK5H31nZJuuLifqX3OO1LlbRASqFqVEu0=;
	b=dWhtnIzTSNTQP6pRGCPfGzbWzZipAtbg1ZQpWZy2bGpWqAwWgYaY77uPyl7cW/Xkn1iV
	 +d8wn21158g37KbKkU1YiIhJm30OFrTasTO0YyK58W/hS1GWQjcbCpURYcV/OyPhuUHBC
	 IqJ0kyrpnQNZ4XPH8mfW9GQjC76g4bvzL7+E9HJ1C8yYfTHUEwJxWxS80nR6rsSwaOi3B
	 ak1vT1CYt1yXWLHJLHLb0rcqLd3anpew0kekn9q1Jge9Vm5TbETgV2Is4kDccAelp2LCR
	 /97bqpGEkxUw3EWt0ADkbMQh5nTDykAaKOUA4xl8nJV1kZ4wKu3R0iN1/AV41qh/kjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExyAzhqr;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D98606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExyAzhqr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792600944; x=1824136944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e/nbM+pJwea/63usDwj3YHPS9L9ZC0Itz4Gf7QJplAQ=;
  b=ExyAzhqrahxdRkEcAuWbZ0TmQlGhpYq+fFZftIexvPOfLtcLLePXSV53
   S+fBKtZbM1m/5symQi01N9Th4yGXSM+7VgPm/Yw3kxolCSxQyKNfi2i++
   8n3/bf2mWPa5SfEYQcrbw0CJI/6lLtth1Ug14pyWkOMaLFV9pg/xtVp3g
   2YnGmUUp4j310myJq2VpCAh3LHtyrWLzit6Wj/nYVD3gjqREviJb8DzRG
   vwglGN10XtPTWMtq9ugIkSQQzH2Q9Fn2RB4fZkM8Up6Pnp9Q5NcTJzBgN
   c8TI5ViG1X8YKG5Zyy3m+TKcrI8uCTOLAPnhAeSso6gAwlzUqPQBYI5g5
   Q==;
X-CSE-ConnectionGUID: AFIKus/XRnmLmMVhp/YYgQ==
X-CSE-MsgGUID: Hm0tGsNFSnyzHLbPfyBKAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1235199"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1235199"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:42:24 -0700
X-CSE-ConnectionGUID: AwgJFi81TyenrAQWOCzBsQ==
X-CSE-MsgGUID: D2BdtMXiSk2RQ1af/o74Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3063692"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:42:22 -0700
Date: Wed, 21 Oct 2026 19:42:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 16/18] x86_energy_perf_policy: Fix use-after-free in
 err_on_hypervisor()
Message-ID: <atjrbNImC5BK4qKv@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <77e30731aaa7d6321dbae7bd58e111d4a73dfd4e.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <77e30731aaa7d6321dbae7bd58e111d4a73dfd4e.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:37PM -0400, Len Brown wrote:

> Avoid testing a pointer into a freed buffer.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


