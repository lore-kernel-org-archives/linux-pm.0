From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] scripts: AnalyzeSuspend v4.2
Date: Thu, 14 Jul 2016 23:37:01 +0200
Message-ID: <CAJZ5v0hiT-of=P=+k74Jrb1BL3yW3Q-y4Oi7zNcgZX7QJ2m9xA@mail.gmail.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
 <CAJZ5v0gSrwcBC-A-g6Pf_eMJ904zZdRkB591w844bwU6pL8qEQ@mail.gmail.com> <1468531998.15887.4.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34617 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbcGNVhE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 17:37:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so326098wma.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2016 14:37:02 -0700 (PDT)
In-Reply-To: <1468531998.15887.4.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com

On Thu, Jul 14, 2016 at 11:33 PM, Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
> On Thu, 2016-07-14 at 23:22 +0200, Rafael J. Wysocki wrote:
>> On Thu, Jul 14, 2016 at 11:09 PM, Todd Brandt
>> <todd.e.brandt@linux.intel.com> wrote:
>> > AnalyzeSuspend v4.2
>> >
>> >   kprobe support for function tracing
>> >   config file support in lieu of command line options
>> >   advanced callgraph support for function debug
>> >   dev mode for monitoring common sources of delay, e.g. msleep, udelay
>> >   many bug fixes and formatting upgrades
>> >
>> > Todd Brandt (5):
>> >   AnalyzeSuspend v4.2 part1
>> >   AnalyzeSuspend v4.2 part2
>> >   AnalyzeSuspend v4.2 part3
>> >   AnalyzeSuspend v4.2 part4
>> >   AnalyzeSuspend v4.2 part5
>> >
>> >  scripts/analyze_suspend.py | 3641 ++++++++++++++++++++++++++++++--------------
>> >  1 file changed, 2474 insertions(+), 1167 deletions(-)
>> >
>> > --
>>
>> Can you please tell me what specifically goes into each of the patches?
>
> It's just a 5 way splitdiff on the original patch, it seems it was too
> large to be accepted on the mailing list as a single patch, so I broke
> it into 5 ~1000 line pieces. The patch is just meant to upgrade the
> kernel analyze_suspend version from 3.0 to 4.2.
>
> Someone suggested that I do a pull request, but I don't want the
> analyze_suspend git log included in the kernel git log, so I'm just
> describing the changes by version number in the kernel git log.
>
> When you include the patch just set it to be a single commit message.

OK

I'll fold the 5 into one patch, then.

Thanks!
