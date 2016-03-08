From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/4] powercap/rapl: reduce ipi calls and misc clean up
Date: Tue, 8 Mar 2016 18:14:41 +0100
Message-ID: <CAJZ5v0iODV3wzERdcpFUK5Ydph_HGm43qnBxbf56zOsF4wh2cw@mail.gmail.com>
References: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20160307170642.31af8b7e@icelake>
	<alpine.DEB.2.11.1603080857310.3859@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36073 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbcCHROn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 12:14:43 -0500
In-Reply-To: <alpine.DEB.2.11.1603080857310.3859@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>

On Tue, Mar 8, 2016 at 8:57 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 7 Mar 2016, Jacob Pan wrote:
>
>> On Wed, 24 Feb 2016 13:31:34 -0800
>> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
>>
>> > Changes since v5:
>> >     - Split changes into seprate patches. No code change.
>> > Changes since V4:
>> >     - Deleted unnecessary cpumask_any_and() call, assign first
>> > cpu as lead Changes since V3:
>> >     - Avoid for_each_online_cpu() search for per package MSR
>> > access. This is achieved by tracking a per package lead cpu via
>> > cpumask_xx() calls. (suggested by Thomas Gleixner
>> > <tglx@linutronix.de>)
>> >         - Add direct reference of RAPL package for each RAPL
>> > domain.
>> >
>> > Jacob Pan (4):
>> >   cpumask: export cpumask_any_but
>> >   powercap/rapl: reduce ipi calls
>> >   powercap/rapl: add package reference per domain
>> >   powercap/rapl: track lead cpu per package
>> >
>> >  drivers/powercap/intel_rapl.c | 220
>> > ++++++++++++++++++++++--------------------
>> > lib/cpumask.c                 |   1 + 2 files changed, 115
>> > insertions(+), 106 deletions(-)
>> >
>> Hi Thomas,
>>
>> Do you have more comments?
>
> No. Looks reasonable now.

OK, thanks!

I'll apply the patches then.
