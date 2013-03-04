From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: how does serial driver suspend work
Date: Mon, 4 Mar 2013 10:37:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1303041034060.1750-100000@iolanthe.rowland.org>
References: <CANMsd03ckY9E_rAMPTivCSs5jkB-zarZZG4npA1hsK3aL5FCDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44962 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757973Ab3CDPho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 10:37:44 -0500
In-Reply-To: <CANMsd03ckY9E_rAMPTivCSs5jkB-zarZZG4npA1hsK3aL5FCDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On Mon, 4 Mar 2013, Ryan wrote:

> Hello everyone,
> 
> Could anyone explain to me how does serial driver suspend work.
> if i want to enable debug prints in suspend and resume functions. How
> are they displayed on the console.
> I could find a variable called "console_suspend_enabled". If this
> variable is passed over the bootargs. Why does the kernel go to
> suspend
> without the serial driver not being suspend. Isnt all the drivers
> required to go to suspend for the process to sleep.

If you put "no_console_suspend" on the kernel's boot command line, the 
console device will not be suspended.  This is a debugging feature, 
meant only for testing, not for normal use.  It's a big help for people 
who want to debug problems in the suspend/resume code, because without 
it there wouldn't be any way to see error messages during suspend.

If you don't put "no_console_suspend" on the boot command line then the 
console device will be suspended along with everything else.

Alan Stern

