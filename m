From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 10:06:23 +0530
Message-ID: <CAKohponWM+RxgK-50BXH-gk3-bX2no7NojT5-6ZRWJAtSizO7A@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<20140514150255.GA8330@amd.pavel.ucw.cz>
	<CAKohpo=MFxUHL22TxXPk4B=JX9AD3RGdgXPPGK9sD3GD6AEV+g@mail.gmail.com>
	<CAOqmu80j2q6hQLThVt60QkjqcZTXwJ6ddwDLvqBEW1ejrVh_hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48898 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaEOEgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 00:36:24 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so617292oag.20
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 21:36:24 -0700 (PDT)
In-Reply-To: <CAOqmu80j2q6hQLThVt60QkjqcZTXwJ6ddwDLvqBEW1ejrVh_hw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inderpal Singh <inderpal.s@samsung.com>
Cc: Pavel Machek <pavel@ucw.cz>, "[Chander Kashyap" <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>

On 15 May 2014 10:02, Inderpal Singh <inderpal.s@samsung.com> wrote:
> I feel freeing of opps are needed at least at the driver unregistration
> time, like we free cpufreq_table.
> Otherwise it amounts to memory leak unless we assume that the same driver is
> going to re-register and re-use the same opps.

Its memory leak only if we have lost the pointer to allocated memory, which
we haven't. Yes, it will keep occupying some space but there is only
one instance
of that per 'cluster' and is very much affordable instead of building it again..

There is a high chance that it will be used again by this or any other driver,
cpufreq or outside of it.

But, yes I do agree that the OPPs not added from dts, i.e. added from
platform should be freed when they don't make a sense. But that's a different
issue altogether.
