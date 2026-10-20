Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489621;
	b=lvQtgF0X5NePxiRC8n7csOTDWb7yzMVn2j0BZXRCiuAlGCZPBBH+o/XEsmc0tAjOj83m
	 TKMRayUCG3h7rISzdpVNuHMOR+UR6Z6awFtj4qXGS3319ST2UB/m35pf52C1wlVCtbjV6
	 cRDDma6iZkDCE5JIDAIKehZwdkePnGwEhQNMUX4DwR8UuG2dV890Q7304+M91cs8dDVk6
	 6DH5es80IErpRWN3D/EEPFbjoYVqTDhRQU1Ru0pzWizLuJT/xuwjZHMqx3X4mNIt7Yzul
	 LD7dN3iwgpCnRqS33g9WB/oPxTGgIQowl5wXv5B/b3K9OEGmfiG49CAJtksIC8awoxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489621;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=59Psuj31G0JVByohcVSm9vJ4tHZfjF6uKxdttbLpGs0=;
	b=G7j4oAdQJVm+16ZZJlKMUjmQoNC//CWFsIiprXDEzmh8UxDUOCCa6lkmt8cnnarzjNBT
	 DXGI7GO62F236G6ik4QoP/0oVWK7Pcoejl07YTF/Ft3dPAyIfhoqhVo3BfzfzUg+tLIE4
	 if2BAgFfLAZNYW2lQng0Bk3ALVF5P0UbKaREyT18wkptgDkEOARloV/pPa0zHu/OBLwCS
	 1TcNtldy0wPypAXghvR9HR1gPyfvcSb0wNmDUKQqx1p8/gtma6y0XztmKd5s0c6sUxM9J
	 JX+hDtcuyjs84tmqUqMKc5z9TTo7vFccXfcFev4Vu8SPQNTYVF8eh8H88r01fo9gp6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mej+8oo4;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CE606A319
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 09:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E4CE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mej+8oo4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792489620; x=1824025620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UqYT7KpqEfxkn37ydS7WN5/k/wG1UIuKK8r8f4p8jzo=;
  b=mej+8oo4j3MD0HdNAW91L+8cEbam5OyWA82l+0xIl1m0TfEGtmo1g+tO
   yo05FprL/AwoLRIsVIj0vPjAWbeE1eeZCnIETz1+agD9xyCOPej5TzpXO
   svBVZcr24PpB6VapEWUWNONkKAhazRpogG8vPtYLiaO2CKe5DmdY/JQgV
   xqWe24DyG1yEBbMANHgvGfSjG6g8L4p1rcprv0Muza4Zbs/QSuNVxwjR5
   9X4Tuk7dlo3ALCHxFW7n2LZ2oUZ+TQZc7tIC08CQ/Jocuhy19m9BXMNuk
   d4mU5+M2akedzbnAV9NXj9rB/MeLDmP0G9btkYZGaSRQHxc+ZMVuB7629
   w==;
X-CSE-ConnectionGUID: vaozPkRZTZutXYL35xpxaA==
X-CSE-MsgGUID: QZZxKOATSki/WqjCSko0Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1076960"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1076960"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:47:00 -0700
X-CSE-ConnectionGUID: VfCjqVGeRFm0LphwnOEBNg==
X-CSE-MsgGUID: 6LI399XPQE23LJ9W3gGivg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2839696"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 02:46:58 -0700
Date: Tue, 20 Oct 2026 12:46:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 03/18] x86_energy_perf_policy: Prevent unlikely buffer
 overflow
Message-ID: <atc4jv7SyIYI7xE7@ashevche-desk.local>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <3a763b979bb1a9a7f76f2b3c9134ca0b580108b6.1792428130.git.len.brown@intel.com>
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
In-Reply-To: <3a763b979bb1a9a7f76f2b3c9134ca0b580108b6.1792428130.git.len.brown@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:43:24PM -0400, Len Brown wrote:

> Protect update_cpufreq_scaling_freq() from buffer overflow
> if somehow it was called with a huge CPU number.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


