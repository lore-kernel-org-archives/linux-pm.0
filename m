From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 26 Aug 2015 18:21:58 +0530
Message-ID: <20150826125158.GM8784@linux>
References: <20150820161402.GA4951@localhost>
 <20150826124736.GA10956@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33682 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbHZMwE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 08:52:04 -0400
Received: by pacti10 with SMTP id ti10so87631269pac.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 05:52:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150826124736.GA10956@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 26-08-15, 13:47, Javi Merino wrote:
> I missed this because I wasn't CCed :(  Thankfully, I'll be in
> MAINTAINERS for this soon.

Yeah, I need to resend that patch soon :)

> > -		devm_kfree(&cdev->device, load_cpu);
> 
> This introduces a memory leak.  Keep the kfree() here, you can't drop
> it.  Cheers,
> Javi
> 
> > -	}
> > -
> >  	*power = static_power + dynamic_power;
> >  	return 0;
> > +
> > +free:
> > +	kfree(load_cpu);

Wouldn't this make that work ?

-- 
viresh
