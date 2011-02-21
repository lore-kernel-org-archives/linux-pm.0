From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] xen: Use PM/Hibernate events for
	save/restore/chkpt
Date: Mon, 21 Feb 2011 21:23:17 +0100
Message-ID: <201102212123.17720.rjw__20438.5534082123$1298321792$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102211135170.15325-100000@netrider.rowland.org>
	<1298308650.16356.8102.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298308650.16356.8102.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, Shriram Rajagopalan <rshriram@cs.ubc.ca>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
List-Id: linux-pm@vger.kernel.org

On Monday, February 21, 2011, Ian Campbell wrote:
> On Mon, 2011-02-21 at 16:40 +0000, Alan Stern wrote:
> > On Mon, 21 Feb 2011, Ian Campbell wrote:
> > 
> > > On Sun, 2011-02-20 at 07:49 +0000, Pavel Machek wrote:
> > > > On Sat 2011-02-19 15:12:35, Shriram Rajagopalan wrote:
> > > > > The current implementation of xen guest save/restore/checkpoint functionality
> > > > > uses PM_SUSPEND and PM_RESUME events. This is not optimal when taking
> > > > > checkpoints of a virtual machine (where the suspend hypercall returns
> > > > > non-zero, requiring the devices and xenbus to just pickup from where they left
> > > > > off instead of a complete teardown/reconnect to backend). 
> > > > > 
> > > > > The following set of patches modify this implementation to use Hibernate style
> > > > > control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
> > > > > which is merely a cancelled save akin to failed swsusp() ).
> > > > > 
> > > > > These patches are against Ian Campbell's PVHVM tree at
> > > > > git://xenbits.xen.org/people/ianc/linux-2.6.git for-stefano/pvhvm
> > > > > 
> > > > > at commit 8a8d1bc753c4e2dda5f2890292d60c67d6ebb573
> > > > > kernel version: 2.6.38-rc4
> > > > 
> > > > Series looks ok to me...
> > > 
> > > Thanks Pavel, may we take that as an Acked-by?
> > > 
> > > For my part the Xen side is:
> > > Acked-by: Ian Campbell <ian.campbell@citrix.com>
> > 
> > There's one part of this which could be troublesome.  The new code 
> > generates FREEZE, THAW, and RESTORE events even in kernels where 
> > CONFIG_HIBERNATION isn't set.  In such kernels, drivers are not 
> > obliged to handle these events correctly.
> 
> The dependencies on CONFIG_HIBERNATION which I can see appear to be more
> often at the bus level (e.g. in drivers/acpi drivers/pci/pci-driver.c
> etc) is that right?
> 
> For a PV guest only the Xen PV drivers really matter.
> 
> But for a PVHVM guest you are right since there are the emulated "PC"
> devices though which could be problematic. There's nothing especially
> thrilling in that set of devices although I don't think that invalidates
> your point.
> 
> > Shouldn't the CONFIG_XEN_SAVE_RESTORE option select CONFIG_HIBERNATION?
> > In which case the #ifdef lines in pm_op() wouldn't need to be changed.
> 
> I think selecting user-visible symbols is generally frowned upon.
> 
> But apart from that I was concerned that tying the Xen functionality
> into the hibernation option was a bit odd/artificial. Perhaps it's the
> only solution though.

I'd very much prefer it if the patchset didn't touch drivers/base/power/main.c.

However, if you want to select CONFIG_HIBERNATION from CONFIG_XEN_SAVE_RESTORE,
you should make sure that CONFIG_HIBERNATION is really selectable (ie.
CONFIG_SWAP is set and CONFIG_ARCH_HIBERNATION_POSSIBLE is set).

Thanks,
Rafael
