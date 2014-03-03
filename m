From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 0/8] PM / Sleep / Runtime: Fixup some driver's system suspend
Date: Mon, 3 Mar 2014 08:29:17 +0100
Message-ID: <CAPDyKFq5=Zdexm_YdBSmqvPhtAi3pUktqUWU7vc4NzrawDZSXA@mail.gmail.com>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
	<7021741.2WcVMr4q95@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33697 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaCCH3S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 02:29:18 -0500
Received: by mail-qc0-f171.google.com with SMTP id x13so2161660qcv.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Mar 2014 23:29:17 -0800 (PST)
In-Reply-To: <7021741.2WcVMr4q95@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On 2 March 2014 00:38, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, March 01, 2014 11:56:03 AM Ulf Hansson wrote:
>> Patch 1 -> 2:
>> These patches provides two new runtime PM helper functions which intend to be
>> used from system suspend/resume callbacks, to make sure devices are put into low
>> power state during system suspend and brought back to full power at system
>> resume.
>>
>> The prerequisite is to have all levels of a device's runtime PM callbacks to be
>> defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
>> for CONFIG_PM.
>>
>> By using the new runtime PM helper functions especially the two scenarios below
>> will be addressed.
>>
>> 1) The PM core prevents .runtime_suspend callbacks from being invoked during
>> system suspend. That means even for a runtime PM centric subsystem and driver,
>> the device needs to be put into low power state from a system suspend callback.
>> Otherwise it may very well be left in full power state (runtime resumed) while
>> the system is suspended. By using the new helper functions, we make sure to walk
>> the hierarchy of a device's power domain, subsystem and driver.
>>
>> 2) Subsystems and drivers need to cope with all the combinations of
>> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME. The two new helper functions smothly
>> addresses this.
>
> OK, I've queued up [1-2/8] for 3.15.  The rest generally didn't apply for me
> and I think it'd be better to push them through the respective subsystem trees
> later anyway.

Thanks Rafael!

Agree, regarding 3->8, they were at this point mostly included for
your reference.

Kind regards
Uffe

>
> Thanks!
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
