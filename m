From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Generic governors support
Date: Tue, 15 Nov 2016 23:37:11 +0100
Message-ID: <CAJZ5v0gUnkuBRbe62aV=ze9A6rAt6QMQ6sQ+7moJox4=G0GKAA@mail.gmail.com>
References: <000601d23f62$7cf1ec20$76d5c460$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35018 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbcKOWhN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 17:37:13 -0500
In-Reply-To: <000601d23f62$7cf1ec20$76d5c460$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Nov 15, 2016 at 6:05 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.11.13 16:08 Rafael J. Wysocki wrote:
>
>> Rebased on top of my linux-next branch, which in turn is based on 4.9-rc5 now.
>>
>> I'm running this on my IVB laptop w/ the schedutil governor, no problems so
>> far (fingers crossed).
>
> I did the exact same tests as I did with your earlier RFT/RFC version
> of this patch, with the exact same results. I still think something is wrong.

Thanks for the report!

> Reference:
> http://marc.info/?l=linux-kernel&m=147803469901959&w=2

As far as I can test it, both ondemand and schedutil governors work as
expected with it (I haven't tested conservative directly, but it is
similar enough to ondemand).

What happens with the powersave and performance governors is that
->target() is only called once by each of them (during initialization)
and each time the min/max limits change.  That's why you won't see new
requests coming when using any of those two.

Thanks,
Rafael
