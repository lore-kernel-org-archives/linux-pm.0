From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2][RFC] PM / sleep: Expose DPM watchdog timeout to sysfs
Date: Fri, 12 Aug 2016 02:39:43 +0200
Message-ID: <CAJZ5v0i48QKjQPvh9uamKjO0FKF7KBkvnVDXqYpytyRby7hRHg@mail.gmail.com>
References: <cover.1470908324.git.yu.c.chen@intel.com> <20160811185441.GA15813@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34441 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbcHLAjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 20:39:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so112367wma.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Aug 2016 17:39:44 -0700 (PDT)
In-Reply-To: <20160811185441.GA15813@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>

On Thu, Aug 11, 2016 at 8:54 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Recently we have a new report that, the harddisk can not
>> resume on time due to firmware issues, and got a kernel
>> panic because of DPM watchdog timeout. Since the default
>> timeout has once been modified from 12 to 60 seconds, we
>> might still encounter new case which requires a longer timeout,
>> so expose the value to sysfs and let the users decide which
>> value is appropriate, meanwhile this can also ease the debugging
>> process.
>>
>> The first patch is to force DPM watchdog depending on CONFIG_PM_SLEEP,
>> thus the second patch which does the actual work, can use
>> CONFIG_DPM_WATCHDOG safely without checking CONFIG_PM_SLEEP.
>
> Kernel should just work. User should not have to configure random
> knobs to have working suspend/hibernation.
>
> We do not want "CONFIG_BREAK_SUSPEND" so I believe we don't want
> "CONFIG_DPM_WATCHDOG".

But this doesn't introduce CONFIG_DPM_WATCHDOG.  It makes it depend on
CONFIG_PM_SLEEP which is quite reasonable, because that watchdog is
only used during sleep transitions.

Thanks,
Rafael
