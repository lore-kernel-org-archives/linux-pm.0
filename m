Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582873;
	b=JDh8nQ/CKte/RZzFkDmBbJSoWBYOLAsqnJMGuSfnBPUsO5xV83mLyZIg/goKLn8uSABX
	 9odeTJiSEjI6GR9I3oFy8i0AeYu79nJ/oCtseto/XWhE/MocRKN1VOFb2unkcajY7HzHY
	 iQVw/Bhbtqq+ZC1Vg1puZo7IDwhXcpy3mI3rE8NewH3KABuAfHcGkUz+YUcD33TPGsTy3
	 2v/DEramqCf25aonXnNqdxtYJMa2/dPXQTBqtk+HiyCpO7toEAwqbU9VW3irqimtnqKTu
	 npSg6Vr5Typ2BbDuowh+QkeMXUPTmlT2qCbp5DdsN7cskynlGHxONBM3SB01vXJk2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7PZQk9at42RPP00VjylZfLgVP0j8otNjkZjY5qVieyc=;
	b=Vqvm+x8QSg428/wRPkPrJxZ58KiHoc6n3AnfAbxY6Y1sQTCTd/ZBI3kwpLwby/hJikX4
	 qlOSjHNATH1Vhv9c4iLQiMs/I18j7CSltDy9waLK3/XwH1AEAreXvE0LpuK8iVUauy3vd
	 qcrBkWatZFTc9IH6GjwIPK98bk8nI1xXkBsupgJj3e+7O/6QsArY7akH2I3udlrB0kZGJ
	 r+i6p2l0wnQoK34pSCEnzc1l32Begv8GtIgZ/Z1qLRJySsXYUljVOt7Fi7LklmAt1FWOs
	 FzZys5eNRL/9Z0CgmtsZ8R8mzZTGMEbSBQlC85I5l9psr4YHiQdTGzZo99q7X+l9xVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HJQad12g;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423D606A327;
	Fri, 13 Nov 2026 15:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B423D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HJQad12g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794582873; x=1826118873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0E09P4cshhR0pA962/xhxsk8LxaAyvozUk3q+5rP5tU=;
  b=HJQad12gBxW/YSELY9h6hvndzh7d1/Chy9oFShEqEyP53uHoN7Q/+8h8
   Vhn2IHzFXRaiAh1wquSxB2bGkPoRqcl3noPuuZdTiaJcrbk7e37ifht9B
   C4NX3K0SvjL60GsWnKjXO+3hZZd7owSc8X10IIOomU6YYXCbQP8/3Zuna
   Br1BHwZYfDotSjiDjZOqLzfWascZT+JIpFFHfQPW/Ifz9MbVmeFlxfITj
   YY47AjKNP8o87zA7nRZl1Q8+2xrdDQuCkaTXwROQORKfzp9OO/vOALC4w
   xEYnfXLA/MhsntANUIGPEZtXrOea6xyzEdwLYTnNkJsr1krktw9EkT738
   g==;
X-CSE-ConnectionGUID: G97+oQKiREi+48JkHadm4g==
X-CSE-MsgGUID: bff+tO2bT3qwrWPKxXKZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3265151"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3265151"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:14:32 -0800
X-CSE-ConnectionGUID: 1knF8BGSReeEVyZXaL2Llw==
X-CSE-MsgGUID: pZGnz9HKS3ysu7EE8Z9NtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9265561"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 07:14:29 -0800
Date: Fri, 13 Nov 2026 17:14:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH v2] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
Message-ID: <avcpU3P1jw8NESMu@ashevche-desk.local>
References: <20261113-adctm5_gen3_hardirq_removal-v2-1-a0c9c4800941@oss.qualcomm.com>
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
In-Reply-To: <20261113-adctm5_gen3_hardirq_removal-v2-1-a0c9c4800941@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 05:23:03PM +0530, Jishnu Prakash wrote:
> adc_tm5_probe() registers the ADC_TM interrupt with both a primary
> handler and thread function (adctm5_gen3_isr/adctm5_gen3_isr_thread)
> with IRQF_ONESHOT. The primary handler calls adc5_gen3_read(), which
> takes the SPMI regmap's lock (a regular, non-raw spinlock) from hardirq
> context. With CONFIG_PROVE_LOCKING enabled, this leads to a warning
> about an attempt to take a lock in an invalid wait context:
> 
>   swapper/0/0 is trying to lock:
>   ffff000b67201018
>   (qcom_spmi_pmic:259:(&spmi_regmap_config)->lock){....}-{3:3}, at:
>   regmap_lock_spinlock+0x20/0x40
>   other info that might help us debug this:
>   context-{2:2}
> 
>   Call trace:
>   regmap_lock_spinlock+0x20/0x40
>   regmap_raw_read+0x88/0x328
>   regmap_bulk_read+0x10c/0x340
>   adc5_gen3_read+0x38/0x50 [qcom_spmi_adc5_gen3]
>   adctm5_gen3_isr+0x90/0x130 [qcom_spmi_adc_tm5_gen3]
> 
> There is no requirement for any of the work done in the primary handler
> to run in hardirq context. Drop the primary handler and move all the
> actions in it to the threaded handler, which removes the invalid wait
> context warning.
> 
> Note that both handlers used a local variable to hold the index of the
> SDAM whose IRQ was triggered ('sdam_num' in the primary handler and
> 'sdam_index' in the thread function). These are the same value under
> different names and 'sdam_index' is kept now, since that is the name
> used for it at other places in the file.

But this is not the point. The point should be semantics of the variable
and not frequency of use.

...

> -static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>  {
>  	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> -	int ret, sdam_num;
> +	int sdam_index, ret;
>  	u8 tm_status[2];
>  	u8 status, val;

I probably missed to point that at the same time we can split semantically
different variables.

	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
	u8 tm_status[2];
	u8 status, val;
	int sdam_index;
	int ret;

-- 
With Best Regards,
Andy Shevchenko


