Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629341;
	b=FK/6qqhOv8h4E9+L8advckEW+ErnOaoy6Gq+3ChetEV5fjHtGP/elVTAMpy9gVjN43e8
	 leKAfPdx109AO36NWHW/wEKhFv4u7CoHkJe92/5zIWKqAcMlW40Dwkb59V62rRFhulGNb
	 1bKAGWI1vRw7URZYEI3EQ5cvRmcTdQ6FhnCERkW2WYgkRSmkZAlG5006N3A1G+kCoNAfv
	 7DcC3tJ55NxfeXttilFnY+IIdzCBC1cl/xByegrq3dn5mwyv3q74gahk644xOxvSCKLsh
	 Tjzs7HDIiSJtTw+nEWKW62f06DSrxRT25pqLqxRlcmDKrh7uTBG8656RdMIEGAu0ipA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629341;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=NCBMb+fRDE48ZcNNicVw/07a1Enbi+Cv3BOnNHYih0g=;
	b=G5kRDyQgYLyhSXjN7vAw3GveWpMy+Zgi95P0D3+McqdYOLR+zhYAHWbUYjr3TShfsiO5
	 rntE3K1bqC2utVfOcZ7eSYZ/RUfI9MmnJFcjUbZpW8QkOWoIkRsBjRXPRcyeFv7hjQ+wJ
	 o40V0zli0/4eeRLPsshIKxBdb398TAPqHbEA63n+UpzcHc5MvjPGs7eu/Qzl8YjUS/zaj
	 3QXzFS1WWsn2ZPvk82PxxLzDH9czvjTVmj0zX1warxDqueU5tV5UT+qjJbHOhBSlJRlfN
	 kDe0A5csAQ9OTCJVQnxbCfBOTPrHVZeuzEhw5Gybm4EzrlXgSocxNd3TY03KGGrjd5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QM+Jiek5;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34957606A332;
	Wed, 25 Nov 2026 17:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34957606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QM+Jiek5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795629341; x=1827165341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rA2lUPNkARdhTd0hP030stD9tcEZV1j4L1lVJaMUMYw=;
  b=QM+Jiek5n61YxbmreW7UWnpKmP7gGGfD9RwuurmeqgGTdGWXq3w8C1oy
   QtokKwrE+l6+Mx0koorCGXECJ7oHOlJ3LyWpyDeXJwsEvzSPf0iOTNJfm
   9dyo9bpXI0DSY5d9PQEBQpkNA0oAUxbSc9DvgnqMuexr1VvR/kaFWHT9q
   8dsdBTgz6HFeAtHgE4DAvGXmKeIIDjp4QZJQq5393CuiFuHCOTLfqCGrY
   aCUGthYsg3V+izeLpfhqkwgCYXb3KnVX/a7LX4MOjSsXHvtecWsUgv43t
   rgApe7zJug5/2+AsS5QbT4n3+ppC2ws4p1WW1rMGnyVe+JfShljmF8jaa
   Q==;
X-CSE-ConnectionGUID: cGhy+CBKQuuPUpEaTJBTSw==
X-CSE-MsgGUID: 3Yv4+5qKR+WY/NOUPuvRSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4521359"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4521359"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:22:29 -0800
X-CSE-ConnectionGUID: Fc6brtQlRj69WkWFcaem3g==
X-CSE-MsgGUID: 9s/lg8fJT6+izAtQi1IaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11956144"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:22:28 -0800
Date: Wed, 25 Nov 2026 19:22:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: Re: [PATCH v2 2/5] ACPI: fan: Stop using driver_data pointer from
 struct acpi_device
Message-ID: <awcZUWf-p2x8QAiG@ashevche-desk.local>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <14143841.uLZWGnKmhe@rafael.j.wysocki>
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
In-Reply-To: <14143841.uLZWGnKmhe@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 03:07:30PM +0100, Rafael J. Wysocki wrote:
> 
> Instead of using the driver_data pointer under struct acpi_device,
> make the ACPI fan driver use the driver data under the dev member of
> struct acpi_device and clean it up properly on driver removal and on
> probe failures.
> 
> While at it, unify the code ordering of acpi_fan_delete_attributes()
> with the rollback path in acpi_fan_create_attributes().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


