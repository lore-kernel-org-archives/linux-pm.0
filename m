From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type
 in argument 2 (different modifiers)
Date: Wed, 24 Oct 2012 12:05:13 +0530
Message-ID: <CAKohpomnBQ=6zX5v0zBWYUHggDAefsKLULpLGQKPkAxTQhuAqg@mail.gmail.com>
References: <50862255.Foit2oXcLVE39lAk%fengguang.wu@intel.com>
	<CAKohpo=PF-MkG8KDRWSfoBXkK102r7WwToQ01UmfetvarRyK3w@mail.gmail.com>
	<1574211.OHQpWS6lzF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40160 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348Ab2JXGfN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Oct 2012 02:35:13 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so134540iag.19
        for <linux-pm@vger.kernel.org>; Tue, 23 Oct 2012 23:35:13 -0700 (PDT)
In-Reply-To: <1574211.OHQpWS6lzF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, linux-pm@vger.kernel.org, Lists linaro-dev <linaro-dev@lists.linaro.org>

On 24 October 2012 06:03, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 23 of October 2012 10:55:51 Viresh Kumar wrote:

>> @Rafael: Most of these are due to mixed use of u64 and cputime64_t. Both of
>> which are u64 if i am not wrong. Any specific reason that we used cputime64_t
>> instead of u64? Or can i make everything u64 instead in governors?
>
> Well, there might be a reason in the past, but I'm not sure it's still there. :-)
>
> I _think_ you can use u64 everywhere.  It would be more correct than the current
> situation anyway.

Great. I will send another set for these warnings..

--
viresh
