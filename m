Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B739334C1D;
	Thu, 27 Aug 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835182; cv=none; b=URMBBg8O5kJXRKDeMUWrZVdqKQeDThB8CElq8oaJYxIYzIkjd1TllKoz1rEnyT+gO3zewiFTuIGXd0H6GOdAnvWI0IeBe62MJFTNDLYYapa72OHkcDtx7sXOiinkWN7ClYEV+eXdMV8pLR08kASGWFeVqtjrg4RYHEb7Qw8oTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835182; c=relaxed/simple;
	bh=cWMqsYyhgOMCauTHPl5SX2JinPbM/WNNkUFbgOFH9bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1jzXK8hTov1SF4efnjnp8qV2IBXp80xHvVGvPA2KwFS/XlQexraO403OeaxLea0lCiPhglCqkw+lXveg2oFRDFY3mUOZhX0WfGG/ZvUA6rnEA/qF4DISbsh8wQ/WTKhOk4z5ZccXT7Q3PVPMM4mrlQBRozPLCmBnPlsoQoKq2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2NyS9LB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2NyS9LB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787835174; x=1819371174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWMqsYyhgOMCauTHPl5SX2JinPbM/WNNkUFbgOFH9bU=;
  b=c2NyS9LBbPO9HlxySyQRr0KZyS1mYBQqng70GvInz4Dh7faL3KXxFU2O
   twEOsr41RNTADJtmjL5Z2up8N+NkOJG7ke5bBUPbHnv+0DAaCDkBgv9XC
   KMQIQAHm3oZN7c6wSANm4lpGRHa5QCbr+swqqTsvf28pOSsooHq7n23F6
   Ea8JknJGLyYihGOjGTnh971EmnVwdfPDXWI7xuz2Mv7ecFQBCU/CrEuor
   SoCHiQOijo68fIgLYhcd86iRgxGaTwZW+Re4WqCP6/+pew5/QBClOTZb0
   DzD51QuV04SnyaC+ZNvWXvJc++hgkL4ZWOeNXrIIGXSpamSufbLxmboc5
   g==;
X-CSE-ConnectionGUID: BpdGasMnR+SW1Fyofi4j0A==
X-CSE-MsgGUID: L58OPdmtQsWH4723Y+311w==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87277039"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87277039"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:52:48 -0700
X-CSE-ConnectionGUID: pLVIn83PRxq0EEvk+Q/VOA==
X-CSE-MsgGUID: 7KPoMQCwTZimaaMjNox/QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="306080245"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:52:44 -0700
Date: Thu, 27 Aug 2026 15:52:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, Vinod Koul <vkoul@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom/spmi-mbg-tm: Import IIO_CONSUMER
 namespace
Message-ID: <apAzGkXpnMYHcnqJ@ashevche-desk.local>
References: <20260827103555.883018-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827103555.883018-1-shengchao.guo@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 06:35:55PM +0800, Shawn Guo wrote:
> The IIO consumer interface symbols moved into the IIO_CONSUMER namespace,
> so consumers must import it explicitly.  Without it modpost fails on

> 'iio_read_channel_processed' and 'devm_iio_channel_get':

iio_read_channel_processed()
devm_iio_channel_get()

>   ERROR: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses
>   symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but
>   does not import it.

> Fixes: ebf1d03dab96 ("iio: inkern: Use namespaced exports")

Shouldn't this be backported to stable kernels?

...

Code wise looks good.

-- 
With Best Regards,
Andy Shevchenko


