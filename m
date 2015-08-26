From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Wed, 26 Aug 2015 14:09:21 +0100
Message-ID: <20150826130921.GB10956@e104805>
References: <20150820161402.GA4951@localhost>
 <20150826124736.GA10956@e104805>
 <20150826125158.GM8784@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:51857 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751275AbbHZNJa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 09:09:30 -0400
Content-Disposition: inline
In-Reply-To: <20150826125158.GM8784@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 26, 2015 at 01:51:58PM +0100, Viresh Kumar wrote:
> On 26-08-15, 13:47, Javi Merino wrote:
> > I missed this because I wasn't CCed :(  Thankfully, I'll be in
> > MAINTAINERS for this soon.
> 
> Yeah, I need to resend that patch soon :)
> 
> > > -		devm_kfree(&cdev->device, load_cpu);
> > 
> > This introduces a memory leak.  Keep the kfree() here, you can't drop
> > it.  Cheers,
> > Javi
> > 
> > > -	}
> > > -
> > >  	*power = static_power + dynamic_power;
> > >  	return 0;
> > > +
> > > +free:
> > > +	kfree(load_cpu);
> 
> Wouldn't this make that work ?

Nope, you're not reaching that code path from there.  Removing the
"return 0" would work, but I don't like it, since we would be calling
kfree() all the time, even when the trace is not enabled.  I'd rather
leave the kfree() where it is.

Cheers,
Javi
