Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407030;
	b=sGg68ZjpWycMv2V2OCwpyU6aACZ4lyXNX61C7qgm3gr/pfb6Q+8UpAnG5h5xTWJI+qfq
	 oZBQYHV4vj28JPAzYDdhAQKWaGB5dvIsUKBS/Oz4MppJsFpHNXJ4EqcGw3A0Vwg+ef+Xs
	 kj9t5nYt3ePtSRGrEs7ub2JUWhkkcGXB67DfMy3pLA5obeugfWOUEscVJjkE7dDIbOio+
	 Oj2hlqQ1lIL71tH/PvO3jW5S6DLw1x24B+AYS/sdTOXxezNhGixIFXgOlXvaDXIinjUhf
	 PTuuB6mQAoHSvk0cJabUiS4qZFBegIWILcoHeF7qnn+Nlz5vo0R75JmWb9/4if6q4cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407030;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J9peD3FmNAJ8Py2mhq4BiQJyBXkxoaWH4Z9OPwxhrLQ=;
	b=GircgwMA2XGx4QyNrvYvRDxuI4OQjxIaeyQ718eMa6w+YXz20PlzGvJIBJuIG8fb2kU4
	 ovTpE3rJAZWYRUfhGIkXhqR82nSyDnJS8aNLQURkXiEtwYqmPw3lW4Yin0v+HWUkIJETb
	 hjlZ4UEGzD4PtwkWB4l/dSGmG7k68yZxEd3cFjPNF4gtFKge8upq5FWYLyuOh1auuKyuV
	 ogih/9D5CMVEpeeNJ2qmarNQPyjZGw4tzInMLw7YXvCNj8Ufp2vDqmqsoo9lMOvXuCAYg
	 vkvfg7VTITyLIj//4J5BnoexV2j4Rm+TKwA93g+Z+CD3XY/OgKLM6WvuM4hb2oCcDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKisMnEa;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB7606A324;
	Wed, 11 Nov 2026 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADDB7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PKisMnEa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794407030; x=1825943030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E9Ms+lpn6wROc2vRuHAmM0fHlGdOGu+fQfzk2yqSffM=;
  b=PKisMnEaJkGz4l2s2nwo8gcDPKncBmy9QCCsuI2O2HqgX/csh3zWjXEY
   /GxvAIsO7sotd22iplfDxBiFHchIPQsfXmRj4e+apwkedTQOD9R/+wGr/
   irXKcM5bSLKttWYN3dWM7vTVApRUy0wZm+ApGzFR865GuMK8Er4bL8ZM0
   11f0FICGBvTCY3LbNsB/4z1MxSAcUKuBjK/ruY13Eh5XU0K4EI5L57ZJv
   atcbWGS5B//uKmuJk0uzKMg+GY8QjANrFHMphpXQSFkn0bIQ85NQz0UI2
   CFtHjWoZTSVJok8B2Jbp02bs0Vm66DlPGtC9RYFpw9ebth6R9FNCiM1Aq
   g==;
X-CSE-ConnectionGUID: 50hu5kkrQNOq5RTb/wWTRQ==
X-CSE-MsgGUID: ZrxZtn3dR9SfE34c/xB/ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099094"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3099094"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:23:49 -0800
X-CSE-ConnectionGUID: Hu7Q5wG2QiOr65g2q6hhwA==
X-CSE-MsgGUID: 0UAAlj1mRc2DdytDISo8FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8761253"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:23:46 -0800
Date: Wed, 11 Nov 2026 16:23:44 +0200
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
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5-gen3: move hardirq actions
 into threaded handler
Message-ID: <avR6cHb6ZUsDzIV2@ashevche-desk.local>
References: <20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com>
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
In-Reply-To: <20261111-adctm5_gen3_hardirq_removal-v1-1-536ed503396c@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 02:12:01PM +0530, Jishnu Prakash wrote:
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
>   locks held by swapper/0/0: 0, last CPU#0
>   stack backtrace:
> 
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc1 #1 PREEMPT(full)
> 
>   Call trace:

>   check_wait_context.isra.0+0x2d8/0x380
>   __lock_acquire+0x2ec/0x840
>   lock_acquire.part.0+0xe0/0x250
>   lock_acquire+0x8c/0x1e0

Please, drop unneeded churn, since regmap_lock_spinlock() the rest is not needed.
It's all documented in Submitting Patches, take your time to read and study that
document.

>   _raw_spin_lock_irqsave+0x6c/0xd8
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

...

> -static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>  {
>  	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> -	int ret, sdam_num;
> +	int sdam_index, ret;

Was the variable rename so important for the fix? Can we defer it to the later
cleanups, if ever needed?

>  	u8 tm_status[2];
>  	u8 status, val;

...

> -	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
> -	u8 tm_status[2];
> -	int sdam_index;

Okay, I see the reason now why it's done, but I noticed no mention of this in
the commit message. Also it's unclear which variable is used more often and
what is the real semantics of its value. Is it number or index? With all this
in mind, please at bare minimum elaborate in the commit message and, if it's
actually a number, replace the other part instead.

-- 
With Best Regards,
Andy Shevchenko


