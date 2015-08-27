From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: Re: [PATCH v2] thermal: cpu_cooling: Remove usage of devm functions
Date: Thu, 27 Aug 2015 07:01:26 +0530
Message-ID: <CAK-LDbJh9Dz1mQCcyGEJixg4bQkAoHPsHr9Mu2upaWjsTOfLVA@mail.gmail.com>
References: <20150820161402.GA4951@localhost>
	<20150826124736.GA10956@e104805>
	<20150826125158.GM8784@linux>
	<20150826130921.GB10956@e104805>
	<20150826131402.GN8784@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34657 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbH0Bb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 21:31:27 -0400
In-Reply-To: <20150826131402.GN8784@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 26, 2015 at 6:44 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-08-15, 14:09, Javi Merino wrote:
>> On Wed, Aug 26, 2015 at 01:51:58PM +0100, Viresh Kumar wrote:
>> > On 26-08-15, 13:47, Javi Merino wrote:
>> > > I missed this because I wasn't CCed :(  Thankfully, I'll be in
>> > > MAINTAINERS for this soon.
>> >
>> > Yeah, I need to resend that patch soon :)
>> >
>> > > > -               devm_kfree(&cdev->device, load_cpu);
>> > >
>> > > This introduces a memory leak.  Keep the kfree() here, you can't drop
>> > > it.  Cheers,
>> > > Javi
>> > >
>> > > > -       }
>> > > > -
>> > > >         *power = static_power + dynamic_power;
>> > > >         return 0;
>
> So, the change I suggested on V1 removed this as well :) and Vaishali
> missed it completely.

Yes. I missed the point that kfree was called at 2 places previously.
Would you like me to send v3 with changes having just new label with
'goto' at both of these places or you would like to apply v1 of the patch?

>> > > > +
>> > > > +free:
>> > > > +       kfree(load_cpu);
>> >
>> > Wouldn't this make that work ?
>>
>> Nope, you're not reaching that code path from there.  Removing the
>> "return 0" would work, but I don't like it, since we would be calling
>> kfree() all the time, even when the trace is not enabled.  I'd rather
>> leave the kfree() where it is.
>
> Hmm..
>
> --
> viresh



-- 
Vaishali
