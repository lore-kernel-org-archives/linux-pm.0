From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 13:30:37 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812061324260.13426-100000__32488.3368485191$1228588448$gmane$org@netrider.rowland.org>
References: <200812061843.59495.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061843.59495.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:

> On Saturday, 6 of December 2008, Linus Torvalds wrote:
> > 
> > On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > > 
> > > USB doesn't use that for PCI suspend-resume, it uses it for suspend-resume of
> > > USB devices behind the controller.
> > 
> > Oh, in that case there are no PCI users of this at all, and what the PCI 
> > driver does is immaterial ;)
> > 
> > > But then we will save the device's registers in the "sleeping" state. 
> > 
> > No no. The rule would be that a PCI driver - if it uses the new 
> > infrastructure, which apparently nobody does _as_ a PCI driver - simply 
> > would never do the whole "pci_set_power_state(PCI_D3hot)" etc crud AT ALL.
> 
> Now _that_ sounds good. :-)
> 
> > So a PCI driver would only do higher-level stuff in its suspend/resume 
> > code. For example, a USB host controller would initiate the USB bus level 
> > stuff, and likely just stop the controller (not suspend it - just stop 
> > it).
> 
> I like this idea very much.

Rafael, I'd be happy to help with fixing up the USB PCI PM code.  At
this point I'm not sure exactly what's needed, though.  For instance,
is there any compelling reason to switch over to the new dev_pm_ops
approach?  And what should the correct sequence of calls be?

Alan Stern
