From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Wed, 31 Aug 2016 13:58:05 +0200
Message-ID: <CAJZ5v0hyJrVgCR+ziZokug7hoMvj-Y9AEtZUB32_UAeMvrjZrQ@mail.gmail.com>
References: <20160819110032.GM1041@n2100.armlinux.org.uk> <2310664.2BksGViL4r@vostro.rjw.lan>
 <20160824131316.GI25143@ubuntu> <1496109.Jd9MGDryNS@vostro.rjw.lan> <20160831041137.GE5539@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36916 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbcHaL6G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 07:58:06 -0400
Received: by mail-it0-f49.google.com with SMTP id e124so2901225ith.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Aug 2016 04:58:06 -0700 (PDT)
In-Reply-To: <20160831041137.GE5539@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@armlinux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 31, 2016 at 6:11 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31-08-16, 03:26, Rafael J. Wysocki wrote:
>> On Wednesday, August 24, 2016 06:43:16 PM Viresh Kumar wrote:
>> > On 22-08-16, 19:32, Rafael J. Wysocki wrote:
>> > > But it will be called in that path during physical CPU hot-add, won't it?
>> >
>> > What about something like this instead (completely untested) ?
>>
>> Inline, please?
>
> I am not sure what that means. I pasted that inline in my previous mail only.

I wanted to say that I'd prefer patches to be sent in the message
proper instead of as inline attachments.  It is easier to respond to
them this way (to me at least).

>> > @Russell: Can you please try this ??
>>
>> I was thinking about something similar, but won't the WARN_ON()s in
>> cpufreq_add/remove_dev_symlink() still trigger, say if there's more
>> than one CPU in a policy and both happen to be online initially?
>
> real CPUs should already be online and their device structure should be
> available, isn't it ?

Not if the driver has already been registered when cpufreq_add_dev()
runs AFAICS (which is the case in question).

Thanks,
Rafael
