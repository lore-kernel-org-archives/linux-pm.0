From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Wed, 24 Feb 2010 10:39:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002241024530.2436-100000@iolanthe.rowland.org>
References: <20100223214920.GA14313@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100223214920.GA14313@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2010, Dmitry Torokhov wrote:

> Yes, I agree, we need a genric mechanism for PNP to emable wakups. It
> was discussed a bit here:
> 
> 	http://bugzilla.kernel.org/show_bug.cgi?id=8286
> 
> but David was too hung up on the fact that number of devices in ACPI
> does not map directly onto number of serio ports when i8042 is in active
> multiplexing mode that it id not go anywhere.

I tend to agree with your views.  Although there still is a question
about why my system has both /sys/devices/pnp0/00:09 and
/sys/devices/platform/i8042/serio0.  Since they refer to the same
keyboard device, why should there be two different sysfs nodes and two 
different drivers?

(Somewhat tangentially, why do the "i8042 aux" and "i8042 kbd"  
drivers on the pnp bus have names containing space characters?  Isn't
that likely to mess up shell scripts?)

At any rate, can the wakeup matter get fixed?  On my system I see two
issues related to the keyboard/mouse devices.  The first is that they
are not enabled for wakeup by default.  The second is that doing

	echo enabled >/sys/devices/pnp0/00:09/power/wakeup

does not actually enable the keyboard for wakeup; only writing to 
/proc/acpi/wakeup works.

Rafael's suggestion for a PNP analog of pci_enable_wake() should solve 
the second issue.  I don't know what's needed to solve the first.

Alan Stern
