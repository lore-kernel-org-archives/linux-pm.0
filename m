From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a macro
Date: Thu, 27 Feb 2014 16:26:23 +0100
Message-ID: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
References: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:52992 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaB0P0Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 10:26:25 -0500
Received: by mail-qa0-f42.google.com with SMTP id k15so911139qaq.29
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2014 07:26:23 -0800 (PST)
In-Reply-To: <Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On 27 February 2014 16:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 27 Feb 2014, Ulf Hansson wrote:
>
>> > So the main question from v1 remains: why use a macro, and not a function?
>> >
>>
>> I am no big fan of macros, but in this case I thought it make sense.
>> Using _a_ function would not be enough, since we would need three, one
>> for each runtime PM callback (suspend, idle, resume), right?
>>
>> I am happy to change to whatever you guys thinks best, I have no strong opinion.
>
> A reasonable compromise would be to define the macro, and then use it
> in those three new functions (and nowhere else).

Okay, let me send a v3 that tries this approach then.

>
> The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
> be changed to use the new functions.  And of course, the new functions
> could be called directly by subsystems or PM domains.

Not sure we should export these functions as a part of this patchset.
Would it not be preferred, to first see if there are any that needs
it?

Kind regards
Ulf Hansson

>
> Alan Stern
>
