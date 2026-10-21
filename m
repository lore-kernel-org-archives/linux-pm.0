Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601198;
	b=SwXkfyAZm2uJR9Gvz+iIy8+Qw8n7TgvuDWc6FaUF7nToFRYG7YL/DmGUg/Rmh+Srez/m
	 OXbllWHR6nJd1HYEXpQ0VdHLxnb10gK8ePPUqEfh++SbIjpP0PteA75UQkZ4K3SJnOScI
	 7zu2CB0Yh+xMhbGJvXMnR2sO1rq15SnjQAkvnWf1qWpm59LSDgdD0QS/9Mgx1ens9ys6w
	 y2iKhrwNVicMjeRaGIweRRzokGUu9v40Nk8P5S0232R65PEAv9HMgESpoMK8VXq8xWXbo
	 IHA8HFwlA3HrmHgXScSyEFdTl6AMqLsZa9eWdprAs/pAixur9HSMw+Sh9F5SIbI+cdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601198;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=12cVaW8qyQ4A+oA0iNsvUhdy8lnlyr3wlT/HCpuy5bc=;
	b=WE0tl51gmh0j2nKX5vKqIjX44eyBLZ46QMpYULieImRQnIm9HcpjhLoJr/VBnXfGyqx8
	 FA0kMRxgfzmLjNTatdPFj/SKMLg0SClyW8mONOFyLMFxhZ9z3C55rCSzlbY8rav0OzYOv
	 rWRVpGykMLWKx7WcEdglwyByb8k1VUCbqp/jmIAzlSRlX7h6RsTlaKkRLlmstjAkXUaOw
	 6BtXz7VEldaxgQb7l8CVebc4d4C8s5QXV2PoQkodGKzHBUZo3CM/iotoWPmuwzK1cA6iz
	 rCOF67fHlKgtu96GoL+93V1E/T0of/YkeRaiWRYk/rkiYhB1hXZBMGwO4sVIyAoN1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOyUcjoU;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52F606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E52F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZOyUcjoU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792601198; x=1824137198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RQV58X5iYq8r22QLiCbBPhGWrDIYXMd2S8OP3SA2sqc=;
  b=ZOyUcjoUMadxHu5cbUql3BXV1It3ZEDx65+/1kaGIKUhj9QAEhxA94AE
   Xn7hv2HTNhYJzU3sHW5hgRqojLUJ3qy2uGolzLrXhtQ8KVh+KRyrbpF+o
   XzzrXam9VWV+K+7P4WY8gPGSpVqYp1hK/MUQi67/JKRypdUdbKIQCEsMi
   q/Qx0ikA4g8m68lKSavitN0tjLdU8j6cbMmjq3yNtYTCDuzMXVDwy3KVE
   ltsP36d+z6KzGc8OpYMoShNU54aFgslb8MJ7tKT3DhNreJi+rN/fkrEOR
   7A3g8Oo7g7QH19U/+/WaXPCwUI3i7rJqhw7l0JaAeNTtyL3o/bifQBlRD
   w==;
X-CSE-ConnectionGUID: HTmNvG4YS/mPrj7AtJW/cw==
X-CSE-MsgGUID: tHez2BnpQoO1bc52GPgzNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1313631"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1313631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:46:30 -0700
X-CSE-ConnectionGUID: fowASuT0R+GZ434mga/1GQ==
X-CSE-MsgGUID: clGXpCpuQuGLNEJY/+Ix2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3472536"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:46:29 -0700
Date: Wed, 21 Oct 2026 19:46:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 18/18] MAINTAINERS: Add x86_energy_perf_policy
Message-ID: <atjsYmOAyM60Vo8g@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <4ff2e5ee8ac95cef4ba20e0971bd87bf9f8b25f6.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <4ff2e5ee8ac95cef4ba20e0971bd87bf9f8b25f6.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:39PM -0400, Len Brown wrote:

> This entry should help direct patches to linux-pm.
> (rather than to lkml)

Indeed!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


