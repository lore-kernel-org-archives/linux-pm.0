From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using
 a macro
Date: Thu, 27 Feb 2014 11:22:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
References: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42539 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751048AbaB0QWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 11:22:24 -0500
In-Reply-To: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On Thu, 27 Feb 2014, Ulf Hansson wrote:

> > A reasonable compromise would be to define the macro, and then use it
> > in those three new functions (and nowhere else).
> 
> Okay, let me send a v3 that tries this approach then.
> 
> >
> > The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
> > be changed to use the new functions.  And of course, the new functions
> > could be called directly by subsystems or PM domains.
> 
> Not sure we should export these functions as a part of this patchset.
> Would it not be preferred, to first see if there are any that needs
> it?

I don't understand.  V2 of the patchset exports 
pm_runtime_force_suspend and pm_runtime_force_resume.  Why wouldn't you 
want to export them in V3?

Alan Stern

