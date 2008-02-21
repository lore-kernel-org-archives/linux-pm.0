From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] patch power_state-remove-it-from-usb.patch added to
 gregkh-2.6 tree
Date: Thu, 21 Feb 2008 17:18:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802211717230.4990-100000@iolanthe.rowland.org>
References: <1203630196303@kroah.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935167AbYBUWSn@vger.kernel.org>
In-Reply-To: <1203630196303@kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: pavel@ucw.cz, greg@kroah.com, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Feb 2008 gregkh@suse.de wrote:

> This is a note to let you know that I've just added the patch titled
> 
>      Subject: power_state: remove it from usb
> 
> to my gregkh-2.6 tree.  Its filename is
> 
>      power_state-remove-it-from-usb.patch
> 
> This tree can be found at 
>     http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/
> 
> 
> From pavel@ucw.cz  Thu Feb 21 13:36:03 2008
> From: Pavel Machek <pavel@ucw.cz>
> Date: Thu, 21 Feb 2008 14:01:45 +0100
> Subject: power_state: remove it from usb
> To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <greg@kroah.com>, stern@rowland.harvard.edu, linux-usb@vger.kernel.org
> Message-ID: <20080221130145.GA3789@elf.ucw.cz>
> Content-Disposition: inline
> 
> 
> 
> power_state is scheduled for removal, and it is used only write-only
> by USB. Remove it.

Greg, this patch is incomplete.  Some of the settings that Pavel 
removed are used by the host controller drivers.  Please revert this; 
I'll send a more complete patch later.

Alan Stern
