From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Thu, 29 Jan 2009 15:47:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901291541340.2417-100000@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0901291234020.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901291234020.3123@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Jan 2009, Linus Torvalds wrote:

> On Thu, 29 Jan 2009, Daniel Qarras wrote:
> > 
> > > https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html
> > > 
> > > Hmm. Does suspend/resume (STR) have the same issue? Or is
> > > this purely a hibernation thing?
> > 
> > Only with hibernation, suspend stays put.
> > 
> > > > After unplugging the mouse the system also resume when
> > > > plugging the mouse back.
> > > 
> > > Sounds suspiciously like auto-suspend getting turned off.
> > > What's surprising is that it was on in the first place - I thought
> > > we defaulted to autosuspend off (for non-hub devices) regardless of
> > > any suspend issues.
> > 
> > FWIW, I have usbcore.autosuspend=1 in grub.conf...
> 
> Ahh. Can you try removing that, and see if it causes that whole 
> hibernation thing?

I doubt it will make any difference.  That parameter setting merely
changes the delay time before an idle device is autosuspended from its
default value (2 seconds) to 1 second.

Besides, the real problem isn't autosuspend at all, as far as I can
tell.  The first problem is that the computer wakes up immediately
after going into hibernation.  The second problem is that the computer 
wakes up from suspend immediately when a USB mouse is plugged in.

> And it does sound like we probably then ignore your autosuspend 
> preferences at resume time and force it off. Adding Alan and Greg to the 
> cc, since they may actually know what is up..

I don't know what's causing the first problem (which has been around 
since 2.6.24).  Maybe a firmware bug.  Perhaps doing "rmmod ehci-hcd" 
before hibernating will help.

To attack the second problem, it would help to see a dmesg log showing
the immediate wakeup from a kernel with CONFIG_USB_DEBUG enabled.

Alan Stern
