From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] intel_telemetry_debugfs: fix oops found while
 load/unload module test
Date: Sat, 27 May 2017 13:52:22 +0300
Message-ID: <CAHp75VecHUoxP2cYv3chTmJL=ok5_TMUMirdcH8pmcJEgdSFdw@mail.gmail.com>
References: <6718d6200ee45ae58b496225d148d275a2776756.1495897832.git.priyalee.kushwaha@intel.com>
 <20170527054929.GA118811@localhost.localdomain> <20170527065430.GA24739@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34309 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755977AbdE0KwX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 May 2017 06:52:23 -0400
In-Reply-To: <20170527065430.GA24739@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Darren Hart <dvhart@infradead.org>, priyalee.kushwaha@intel.com, souvik.k.chakravarty@intel.com, Andy Shevchenko <andy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, May 27, 2017 at 9:54 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Sat, May 27, 2017 at 08:17:39AM -0700, priyalee.kushwaha@intel.com wrote:

>> +Rafael, Len, Pavel, linux-pm: Is there a preferred approach for dealing with
>>                                CONFIG_PM_SLEEP?
>
> Yeah, empty "unregister_pm_notifier" in !CONFIG_PM_SLEEP case sounds
> like a good idea.

I like the idea, though I would let Rafael to speak up.

-- 
With Best Regards,
Andy Shevchenko
