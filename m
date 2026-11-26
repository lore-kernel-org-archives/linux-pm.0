Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706296;
	b=WIYXDra5E93BIzwA+qvRE6ZkNEMfsmYCtwJjfNjSfp56m6TjKclbRT1kaO8wbPMKyP/X
	 wwZQGfTSgDxLd/ioulGmuvlqdBzg3Jpx/7bYBygT9iGbXeh84RTHBUhSonGUfRPKWEPaP
	 jcDkxTXVeVbiNT5vjHcCtcsqGUPrpXKakmgTrA3HzmXD93dIVIDIvFpUfYFbo1tgqAelB
	 tpUs2wrFHYnBcPUm+dSe/cA8WRSbcDi/MRlTnTzFO3mCIKBE+OZ5g+pcPAPSVoy5Muixe
	 SetJRYvyOm9mSPY1s3kthV3Cxdssvq9eBIS5AfNj2ZLLcDoYUFBj8Zk01V+BL3YeY3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cUxJ5+vz3HqpESBBQ5P9MCq5YUn5ysg932DIfopikmI=;
	b=3zoymrKAR0uaMkGxS4dxkY0NAyit76+/M3ZNP7CytkDuMAHm8c6VQMRGLW9fs1OE5+5s
	 48PwHe3kxv9pR4FDur8jv7sOP+t1rpZ4tV/UpedOz3i2HcaLRCcs3wzTK85rEGQxfDAFN
	 73/OKqCYDpQn7TUhnek4uwEHXTHgqwjrSZoDpkiwvG2+Lay8CRjpqIRE/Cj/fbT+8bmNa
	 smKct/lf2ztK5WbTbheeiFhGNKsefAw4dyWmyn0Wh/Ox/VmaHWiGaSAvKi/hKddXZIOQE
	 +Tm89u1hkFa0H54H4YR8z+UkHndxlLHN1gbn/lDH4meOKqyIYj6F9sOWzWe6+8H4Snw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5N4YJFa;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31769606A31E;
	Thu, 26 Nov 2026 15:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31769606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b5N4YJFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795706296; x=1827242296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+3bHNrCLHeyCRwxnq9xjmETbfGAoigECLJgAOSy7mgs=;
  b=b5N4YJFalrVw57wIlsgUtDyOSByzP159Biqg/yQ9s7jn63kfpRZmXv4V
   KXI7kjzozHLYhXhFStfow8S7vJovwhQcCA6FBehAndk6BZD+E2FEBWbhN
   QH7VZvcRdF8fSrcClzVMEBaP/Ts1zQIsuQzN/yaMPwN+ihjd0UKM8eeYm
   sv1ufgreZx+9iSbcYR5BHd0GVpPYzC4r1XqSZc7ViuQYwpR3CStlE62s+
   z+11eWwrX351UmzzfFycI936sUsOOGME4HIEpgLgWKDBLal4QHdGRSOAS
   Mv8xQOjrSA/6+RAWZg0+xLrqZwl2nm2KdNAV+Jw/4Ei+pPyf+3HMKsz4y
   w==;
X-CSE-ConnectionGUID: xMC7X1p6RpOyLdupS6Lixw==
X-CSE-MsgGUID: 6eSEv3c8Ra210L6BYy3kdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4526874"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4526874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:18:08 -0800
X-CSE-ConnectionGUID: B9IPGhkDTWeJvrCl7nJGSw==
X-CSE-MsgGUID: Oq2Vp0HoStmqsNX/mQe2TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12354822"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:18:04 -0800
Date: Thu, 26 Nov 2026 17:18:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in
 enable/disable stub functions
Message-ID: <awhNqrbdy_pJ9r0T@ashevche-desk.local>
References: <20261126081155.501493-1-wenst@chromium.org>
 <20261126081155.501493-2-wenst@chromium.org>
 <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>
 <awgoaQTep07E_w6i@shikoro>
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
In-Reply-To: <awgoaQTep07E_w6i@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 01:39:09PM +0100, Wolfram Sang wrote:

...

> > >  static inline int pwrseq_enable(struct pwrseq_desc *desc)
> > >  {
> > > +       if (!desc)
> > > +               return 0;
> > > +
> > >         return -ENOSYS;
> 
> Bike-shedding alert: What about the ternary operator? It is nicely
> concise here:
> 
> 	return desc ? -ENOSYS : 0;

In long term this may grow to something else and ternary would be harder
to read. (Gave a comment with my true love to ternary and Elvis in particular.)

-- 
With Best Regards,
Andy Shevchenko


