Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732208;
	b=kGsVq7AiDNnXxoyBscDuXx0kL8BxygZZW8MJhSs2ECxJ0RpKwqViU30C1ZZsgE3/5PHN
	 sOz0VQy3V2eD4/ZOmT1f5DPoeOMB04we+H8AHhI03/b3LX7sG0emg+WzRNNGaIiUc32Qr
	 u2OqzARfoQP+e3O0JBFY7cv+/PHSZ0gOAlS8JzC5PYhIwcbcLX3n6hpJA6nQWE1k0kDx8
	 Fp6fvOFqTgtPz1YiHZ1PTcih7V1DOFQQF6JZM2gQvnzpwiYSO6ih5IOL26Dvkn20I7J5K
	 N1Tg2VM77Vn/6Yym9J9g0ZmlB2Nnm7tRzeZGtRobjHyKM3JJmXrtMxBfYsQrDPB+9qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wRcJeTmmkbqKC3feAPZY23rAZsMzyV2oOaQQ8Iw65Qo=;
	b=khDw/zCRFSAqDQFq5BGoVCh9RsB+VyD3HM1DBdgrgALMhKHMUSPstolUjh8QNcv0V2QB
	 XoK94k60kJdscjAtWqZsU0VrCt7/dV1bWHF+r5bUjGexoS3b8XIQeUDoo9EIST+zvDenz
	 E4PzFLL4jCiyJ4tr5rPLSt/uRLim0uU17CpTFxIAK6u/g3JlcEwpZ5AaHDWBTR7iOgaPJ
	 njDYNkyI5/qTnYeVkzksgNzvCwO5YNA8D4oeGOEkD2Zbq17+J/aNNszhCxRAlYVmdOImk
	 O62E5CEUzJHbYmGeMIfJKGeYF1LEoiOmFRP9CErvzx57NTvKyBuNwBRfugMI5DybcdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvbTIh0F;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13E606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 18:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C13E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvbTIh0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793732205; x=1825268205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evphzxnAajVKYn9c2uzNzMHvZXbZvR+hQ+5mwC5qY1w=;
  b=PvbTIh0FEfO6rUcPKR1J1e/bPVYPqnNV5rki7Izfh67qDT+0/3vSiAKQ
   DXtwD66T9d1Wtz2KMrUBaqEtS6XBx/Ukhl8vzZarMUlB+9A40HWUJoe2k
   BynNAKTfkNjMDdiT4rTn9zDstoVrS62S60DbSrkeE4K/FArEf9PLz/wYK
   p80Gy61GD11lkFDLIBgZ/lY60Z49Ck6ykM7UuZBGfNlqJbK5J1MCUsjR7
   fW9w+RvK01fk3ySUEtvIA1c8T7ePmhC4vK34NY7mu80TT/j0JIAV7A5Ij
   nAjMU5VYqgVseL62bMW99PDG2t5ri3fXJ0s2zjZSfdv4kc/B2CglfIXpI
   A==;
X-CSE-ConnectionGUID: nRrlz3EYSui6IF40n2Qeqw==
X-CSE-MsgGUID: h8EULKH8Qpe8zjaJNkFcMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2480971"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2480971"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:56:44 -0800
X-CSE-ConnectionGUID: khzT1K44S4OmwCzkvU6tdA==
X-CSE-MsgGUID: 42BTS2V3SMqnFviE2hhF3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6379004"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:56:42 -0800
Date: Tue, 3 Nov 2026 20:56:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	Amarjeet <amarjeet@intel.com>
Subject: Re: [PATCH 15/16] x86_energy_perf_policy: Simplify write_sysfs()
 return type
Message-ID: <auouZseRPAFn2q4J@ashevche-desk.local>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
 <ff01e8e75e397380db5fd5ead7c93aca00d11f1a.1793124601.git.len.brown@intel.com>
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
In-Reply-To: <ff01e8e75e397380db5fd5ead7c93aca00d11f1a.1793124601.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:02:00PM -0400, Len Brown wrote:

> Simplify error check in write_sysfs().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -static unsigned int write_sysfs(const char *path, char *buf, size_t buflen)
> +static int write_sysfs(const char *path, char *buf, size_t buflen)
>  {
>  	ssize_t numwritten;
>  	int fd;
>  
>  	fd = open(path, O_WRONLY);
>  	if (fd == -1)
> -		return 0;
> +		return -1;

I haven't checked for the consistency, but I would put this as

	if (fd == -1)
		return fd;

-- 
With Best Regards,
Andy Shevchenko


