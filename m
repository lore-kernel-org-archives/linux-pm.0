From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
Date: Thu, 5 Jan 2006 17:06:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601051701560.6460-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.50.0601051342470.17046-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932244AbWAEWGs@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0601051342470.17046-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jan 2006, Patrick Mochel wrote:

> > It would be good to make the details available so that they are there when
> > needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
> > "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
> > for "D3".
> 
> Do it in userspace; the kernel doesn't need to know about "on" or
> "suspend". It should just validate and forward requests to enter specific
> states.

The problem is that the set of devices, drivers, and states is not 
bounded.  A single userspace tool might not know about all the 
device-specific states some weird driver supports.  The tool should still 
be able to ask the kernel to suspend the device without needing to know 
exactly which device state corresponds to "suspended".


On Thu, 5 Jan 2006, Pavel Machek wrote:

> Its okay with me to add more states _when they are needed_. Just now,
> many drivers do not even handle system suspend/resume correctly.

> We are not adding random crap to kernel just because "someone may need
> it". And yes, having aliases counts as "random crap". Perfectly legal 
> but totally useless things count as a random crap, too.
> 
> Bring example hardware that needs more than two states, implement
> driver support for that, and then we can talk about adding more than
> two states into core code.

Embedded devices are a great example.  Consider putting Linux on a 
portable phone.  The individual components can have many different power 
states, depending on which clock and power lines are enabled.  "on" and 
"suspend" won't be sufficient to handle the vendor's needs.

Alan Stern
