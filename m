From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 5 May 2015 15:35:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505051532000.1639-100000@iolanthe.rowland.org>
References: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52007 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751445AbbEETf4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 15:35:56 -0400
In-Reply-To: <CAJFHJrp=h=jxSNLTyszYs3Ac3PoZKFy-dVJXLehO36r-4p-8=w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chirantan Ekbote <chirantan@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Olof Johansson <olof@lixom.net>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, 5 May 2015, Chirantan Ekbote wrote:

> This is our plan for the next version (see my email earlier in this
> thread).  Keeping a hybrid power state with hacks in the drivers isn't
> really maintainable, scalable, or upstream-able and has caused us some
> headaches already.  Unfortunately we were working with the 3.14 kernel
> at the time, which didn't have the framework necessary to do anything
> else.  The new version of lucid sleep will have the power manager
> runtime suspend power-hungry devices before a suspend so that they
> remain powered off at resume time.  The power manager can then decide
> to resume those devices based on whether the wakeup event was
> user-triggered.
> 
> Being able to determine the wakeup type from userspace is the only
> functionality we need from the kernel that doesn't already exist in
> mainline.

Maybe you can simplify the problem.  You don't really need to know the 
wakeup type, or to determine which device was responsible for the 
wakeup.  All you really need to know is whether the wakeup was 
user-triggered.  That may be much easier to discover.

Alan Stern

