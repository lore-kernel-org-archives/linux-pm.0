From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [patch 0/5] powercap/intel_rapl: Fixes, hotplug conversion and simplifcation
Date: Thu, 24 Nov 2016 22:04:26 +0100
Message-ID: <CAJZ5v0i9U9LHtsnLpw_ZbOivc-PEe6ZUBH5jVGVcunj0Xxw-YA@mail.gmail.com>
References: <20161122210518.079483154@linutronix.de> <20161123110647.37485542@icelake>
 <CAJZ5v0hCtb42GOaLOA2CPBQjGAaTDxH6qTMrRQSYCOVjQGyVMQ@mail.gmail.com> <alpine.DEB.2.20.1611240931580.3434@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36740 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965980AbcKXVEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 16:04:30 -0500
In-Reply-To: <alpine.DEB.2.20.1611240931580.3434@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@sisk.pl>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On Thu, Nov 24, 2016 at 9:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Rafael,
>
> On Wed, 23 Nov 2016, Rafael J. Wysocki wrote:
>> On Wed, Nov 23, 2016 at 8:06 PM, Jacob Pan
>> > Looks good to me. The cpu topology management is much more streamlined.
>> > Thanks. I also sent out this patch below on top of yours.
>> >
>> > [PATCH] powercap/intel_rapl: fix and tidy up error handling
>>
>> OK
>>
>> Thomas, I'm assuming that this series will go in via tip.  Please let
>> me know if you want me to take it instead.
>
> It does not depend on anything in tip, so please route it through your tree.

OK, I'm queuing it up, then.

Thanks,
Rafael
