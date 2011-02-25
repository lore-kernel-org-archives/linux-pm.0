From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [PATCH 0/3] xen: Use PM/Hibernate events for
 save/restore/chkpt
Date: Fri, 25 Feb 2011 16:19:52 +0000
Message-ID: <1298650792.5034.551.camel__48190.5613946312$1298650948$gmane$org@zakaz.uk.xensource.com>
References: <Pine.LNX.4.44L0.1102211135170.15325-100000@netrider.rowland.org>
	<1298308650.16356.8102.camel@zakaz.uk.xensource.com>
	<201102212123.17720.rjw@sisk.pl>
	<alpine.DEB.2.00.1102251610160.19277@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1102251610160.19277@kaball-desktop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2011-02-25 at 16:17 +0000, Stefano Stabellini wrote:
> On Mon, 21 Feb 2011, Rafael J. Wysocki wrote:
> > > For a PV guest only the Xen PV drivers really matter.
> > > 
> > > But for a PVHVM guest you are right since there are the emulated "PC"
> > > devices though which could be problematic. There's nothing especially
> > > thrilling in that set of devices although I don't think that invalidates
> > > your point.
> 
> This is a genuine concern because it currently breaks save/restore for
> all PV on HVM guests (dummy_hcd being the offending driver).

Only if !CONFIG_HIBERNATION, right?

> > > > Shouldn't the CONFIG_XEN_SAVE_RESTORE option select CONFIG_HIBERNATION?
> > > > In which case the #ifdef lines in pm_op() wouldn't need to be changed.
> > > 
> > > I think selecting user-visible symbols is generally frowned upon.
> > > 
> > > But apart from that I was concerned that tying the Xen functionality
> > > into the hibernation option was a bit odd/artificial. Perhaps it's the
> > > only solution though.
> > 
> > I'd very much prefer it if the patchset didn't touch drivers/base/power/main.c.
> > 
> > However, if you want to select CONFIG_HIBERNATION from CONFIG_XEN_SAVE_RESTORE,
> > you should make sure that CONFIG_HIBERNATION is really selectable (ie.
> > CONFIG_SWAP is set and CONFIG_ARCH_HIBERNATION_POSSIBLE is set).
> 
> I think we should follow this suggestion.

See the thread "[PATCH] xen: fix XEN_SAVE_RESTORE Kconfig dependencies"
from Shriram <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>

Ian.
