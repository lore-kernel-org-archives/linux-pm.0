From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using
 a macro
Date: Thu, 27 Feb 2014 10:04:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
References: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42648 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751048AbaB0PEn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 10:04:43 -0500
In-Reply-To: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>

On Thu, 27 Feb 2014, Ulf Hansson wrote:

> > So the main question from v1 remains: why use a macro, and not a function?
> >
> 
> I am no big fan of macros, but in this case I thought it make sense.
> Using _a_ function would not be enough, since we would need three, one
> for each runtime PM callback (suspend, idle, resume), right?
> 
> I am happy to change to whatever you guys thinks best, I have no strong opinion.

A reasonable compromise would be to define the macro, and then use it 
in those three new functions (and nowhere else).

The existing rpm_idle, rpm_suspend, and rpm_resume routines should then 
be changed to use the new functions.  And of course, the new functions 
could be called directly by subsystems or PM domains.

Alan Stern

