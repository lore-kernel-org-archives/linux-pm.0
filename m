From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Wed, 17 Feb 2010 13:10:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002171006450.1913-100000@iolanthe.rowland.org>
References: <201002162222.31075.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002162222.31075.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Feb 2010, Rafael J. Wysocki wrote:

> > > Is the problem reproducible with init=/bin/bash vga=0?
> > 
> > Yes.  I tried booting with no initramfs and with "init=/bin/bash
> > vga=0".  Just as before the suspended machine didn't do anything when I
> > pressed keys on the keyboard, and pressing the power button caused it
> > to come back up totally unresponsive with the screen blank and the
> > CapsLock and ScrollLock lights blinking.
> 
> Hmm.  What about X86_CHECK_BIOS_CORRUPTION and friends?

CONFIG_X86_CHECK_BIOS_CORRUPTION was not set.  I created a new kernel 
with:

CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW_64K=y

And then I booted with "memory_corruption_check=1 vga=0 init=/bin/bash" 
on the command line just to be sure.  There was a log message saying 
that low memory would be checked every 60 seconds, but no error 
messages appeared after waiting for a few minutes.

The behavior during resume was unchanged.

> Perhaps the BIOS steps onto the early wakeup code.

The difficulty is that I have no way to find out what's going on.  The
serial port isn't working (or nothing gets sent to it, or both) and the
system hangs before the video output gets enabled.

Alan Stern
