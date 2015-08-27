From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Thu, 27 Aug 2015 10:00:17 +0100
Message-ID: <20150827090017.GB5653@e104805>
References: <20150820161402.GA4951@localhost>
 <20150826124736.GA10956@e104805>
 <20150826125158.GM8784@linux>
 <20150826130921.GB10956@e104805>
 <20150826131402.GN8784@linux>
 <CAK-LDbJh9Dz1mQCcyGEJixg4bQkAoHPsHr9Mu2upaWjsTOfLVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:15908 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751285AbbH0JAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 05:00:23 -0400
Content-Disposition: inline
In-Reply-To: <CAK-LDbJh9Dz1mQCcyGEJixg4bQkAoHPsHr9Mu2upaWjsTOfLVA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 27, 2015 at 02:31:26AM +0100, Vaishali Thakkar wrote:
> On Wed, Aug 26, 2015 at 6:44 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-08-15, 14:09, Javi Merino wrote:
> >> On Wed, Aug 26, 2015 at 01:51:58PM +0100, Viresh Kumar wrote:
> >> > On 26-08-15, 13:47, Javi Merino wrote:
> >> > > I missed this because I wasn't CCed :(  Thankfully, I'll be in
> >> > > MAINTAINERS for this soon.
> >> >
> >> > Yeah, I need to resend that patch soon :)
> >> >
> >> > > > -               devm_kfree(&cdev->device, load_cpu);
> >> > >
> >> > > This introduces a memory leak.  Keep the kfree() here, you can't drop
> >> > > it.  Cheers,
> >> > > Javi
> >> > >
> >> > > > -       }
> >> > > > -
> >> > > >         *power = static_power + dynamic_power;
> >> > > >         return 0;
> >
> > So, the change I suggested on V1 removed this as well :) and Vaishali
> > missed it completely.
> 
> Yes. I missed the point that kfree was called at 2 places previously.
> Would you like me to send v3 with changes having just new label with
> 'goto' at both of these places or you would like to apply v1 of the patch?

I vote for v1.  I've acked it.

Cheers,
Javi
