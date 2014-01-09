From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 9 Jan 2014 11:14:56 +0100
Message-ID: <CAPDyKFrnGvLOQRBKz-V5SsGPNMLXRjSS1iSBPxXj+KW9sMbrRA@mail.gmail.com>
References: <52CDC069.6050703@ubuntu.com>
	<Pine.LNX.4.44L0.1401081627110.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53486 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaAIKO4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 05:14:56 -0500
Received: by mail-qa0-f46.google.com with SMTP id j5so2676757qaq.19
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2014 02:14:56 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1401081627110.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Phillip Susi <psusi@ubuntu.com>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On 8 January 2014 22:34, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 8 Jan 2014, Phillip Susi wrote:
>
>> On 1/8/2014 3:44 PM, Alan Stern wrote:
>> > Right now the PM core does pm_runtime_get_noresume() during the
>> > prepare phase of system sleep, and pm_runtime_put() during the
>> > complete phase. Maybe we should cut down the range of coverage.
>> >
>> > For example, we could do the pm_runtime_put() during dpm_resume(),
>> > or even earlier.  That way, the resume routine could do something
>> > like:
>> >
>> > if (!pm_runtime_in_use(dev)) { pm_runtime_disable(dev);
>> > pm_runtime_set_suspended(dev); pm_runtime_enable(dev); return 0; }
>> >
>>
>> I'm a little unclear on the problem you are describing.  Is it just
>> with pm_runtime_in_use()?
>
> Note that currently there is no pm_runtime_in_use().  One of the things
> I'm proposing is to add it.
>
> If it were already present and you used it properly, you would find
> that it always returned non-zero.  Therefore you would never execute
> the pm_runtime_set_suspended.  _That_'s the problem I'm trying to
> address here.
>
>>  Because in one of my earlier patch
>> iterations, I had used the disable/set_suspended/enable to force the
>> device into suspend without checking runtime_in_use.
>
> That is not a valid thing to do.  The user may have disabled runtime
> suspend for the disk; you must not override the user's policy.

Allowing userspace to disable/enable runtime PM, does in many cases
add complexity to subsystems and drivers when they handle system
suspend/resume. This seems to be the case for SCSI as well?

To simplify for these subsystems and drivers, what do you think about
inventing something like "pm_runtime_sysfs_forbid", which in principle
will prevent userspace from enable/disable runtime PM? Typically this
function will be called from ->probe.

Kind regards
Ulf Hansson

>
>>  It worked, but
>> that allowed the port device to auto suspend since its use counter
>> dropped to zero, so I couldn't issue the REQUEST SENSE command
>> disable/set_active/enable to reverse the process ( since the port was
>> suspended ).
>
> That's a separate problem, to be discussed back in the earlier email
> thread.
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
