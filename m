From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: selective wakeups
Date: Tue, 3 Feb 2015 10:33:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502031030410.1130-100000@iolanthe.rowland.org>
References: <54D09AC7.5080503@collabora.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35630 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S966008AbbBCPdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 10:33:24 -0500
In-Reply-To: <54D09AC7.5080503@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Tue, 3 Feb 2015, Tomeu Vizoso wrote:

> Hello,
> 
> I'm looking at how to support wakeup sources that resume a subset of the
> suspended devices. The goal is for the machine to be able to wakeup the
> CPU but not the display or sound card when the wakeup source isn't
> user-initiated, such as RTC or a network card (we can call it automatic
> resume).

That's a terrible name.  Most resumes are automatic, in the sense that 
the computer carries out the resume automatically in response to some 
input.

A better name would be "partial resume".

> http://www.chromium.org/chromium-os/packages/power_manager/suspend-and-resume#TOC-Dark-Resume
> 
> My first idea is for userspace to be able to configure via sysfs which
> devices aren't going to be resumed when a given wakeup source fires.

In general, the computer doesn't know which wakeup source has fired.  
ALl it knows is that it was asked to wake up.

Alan Stern

