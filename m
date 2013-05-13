From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCHv2 2/2] PM: compile-time configuration of device suspend/resume
 watchdogs.
Date: Mon, 13 May 2013 09:03:14 -0700
Message-ID: <51910EC2.8090501@linaro.org>
References: <1368221329-1841-1-git-send-email-zoran.markovic@linaro.org> <1368221329-1841-3-git-send-email-zoran.markovic@linaro.org> <CAMbhsRT2rc5A3zeKA2Om+y-Kv2HVh0pa6YjQ9BLC2jBBfWfxsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59184 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab3EMQDS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2013 12:03:18 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so2670886pbc.4
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2013 09:03:17 -0700 (PDT)
In-Reply-To: <CAMbhsRT2rc5A3zeKA2Om+y-Kv2HVh0pa6YjQ9BLC2jBBfWfxsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: Zoran Markovic <zoran.markovic@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Todd Poynor <toddpoynor@google.com>, San Mehat <san@google.com>, Benoit Goby <benoit@android.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 05/10/2013 11:23 PM, Colin Cross wrote:
> On Fri, May 10, 2013 at 2:28 PM, Zoran Markovic
> <zoran.markovic@linaro.org> wrote:
>> +#ifdef CONFIG_DPM_WD
>> +/**
>> + * dpm_wd_action - recovery from suspend/resume watchdog timeout
>> + * @wd: Watchdog. Must be allocated on the stack.
>> + */
>> +#if defined(CONFIG_DPM_WD_ACTION_STACKTRACE)
>> +static inline void dpm_wd_action(struct dpm_watchdog *wd)
>> +{
>> +       show_stack(wd->tsk, NULL);
>> +}
>> +#elif defined(CONFIG_DPM_WD_ACTION_PANIC)
>> +static inline void dpm_wd_action(struct dpm_watchdog *wd)
>> +{
>> +       panic("%s: unrecoverable failure\n", dev_name(wd->dev));
> The panic here is not very useful, it's going to print the stack of
> the task that was running when the timer fired which is likely to be
> the idle task if the suspend task is deadlocked.  This should call
> show_stack and panic.  If you take out the log action, then all this
> can stay inline with the handler and be:
>
> dev_emerg(wd->dev, "**** DPM device timeout ****\n");
> show_stack(wd->tsk, NULL);
> #ifdef CONFIG_DPM_WD_ACTION_PANIC
> panic("%s: unrecoverable failure\n", dev_name(wd->dev));
> #endif

#ifdefs in functions are usually to be avoided. Thus why I suggested he 
use the config dependent dpm_wd_action() function to handle this.

thanks
-john

