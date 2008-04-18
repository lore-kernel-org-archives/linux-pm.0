From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.25-mm1: not looking good
Date: Fri, 18 Apr 2008 11:22:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804181120270.6252-100000@iolanthe.rowland.org>
References: <20080418094220.GB23572@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418094220.GB23572@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-usb@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Stephen Smalley <sds@tycho.nsa.gov>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 18 Apr 2008, Pavel Machek wrote:

> On Fri 2008-04-18 00:53:23, Andrew Morton wrote:
> > On Fri, 18 Apr 2008 00:50:34 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > dmesg: http://userweb.kernel.org/~akpm/x.txt
> > > config: http://userweb.kernel.org/~akpm/config-t61p.txt
> > 
> > oop, there's more:
> > 
> > 
> > sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > firewire_core: created device fw0: GUID 00016c2000174bad, S400
> > PM: Device usb4 failed to restore: error -113
> > eth0: Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
> > eth0: 10/100 speed: disabling TSO
> > PM: Device usb5 failed to restore: error -113
> > PM: Device usb7 failed to restore: error -113
> > sd 0:0:0:0: [sda] Starting disk
> > PM: Image restored successfully.
> > Restarting tasks ... done.
> > PM: Basic memory bitmaps freed
> > 
> > Those USB restore failures are new.  They're similar to the ones on the
> > doesnt-resume-properly-any-more Vaio.  They came out from the machine's
> > second (successful) resume-from-disk.
> 
> Try rmmod usb / insmod usb around suspend to see if it is
> usb-specific, or if something went seriously wrong in core.
> 
> Or you might just bisect it ;-).

There's no need to worry about them.  They merely indicate that the 
root hubs didn't resume along with everything else, because they were 
already suspended when the system went to sleep and so they were left 
suspended.  The return codes in usbcore will be changed soon so that 
this won't appear to be an error.

Alan Stern
