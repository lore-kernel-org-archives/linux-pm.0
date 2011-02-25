From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Xen-devel] Re: [PATCH] xen: fix XEN_SAVE_RESTORE
	Kconfig dependencies
Date: Fri, 25 Feb 2011 19:19:26 +0100
Message-ID: <201102251919.26713.rjw__17676.843077834$1298658055$gmane$org@sisk.pl>
References: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
	<1298459402.16356.10779.camel@zakaz.uk.xensource.com>
	<4D677B260200007800033A60@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D677B260200007800033A60@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

On Friday, February 25, 2011, Jan Beulich wrote:
> >>> On 23.02.11 at 12:10, Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:
> > On Wed, 2011-02-23 at 10:58 +0000, Jan Beulich wrote:
> >> >>> On 23.02.11 at 10:08, Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:
> >> > On Wed, 2011-02-23 at 07:27 +0000, Shriram Rajagopalan wrote:
> >> >> Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
> >> >> if this option is enabled.
> >> > 
> >> > I was under the (perhaps mistaken?) impression that selecting user
> >> > visible Kconfig symbols was verboten since it has side-effects which
> >> > make it hard for users to figure out why something cannot be switched
> >> > off and/or how to turn things on etc.
> >> > 
> >> > In any case I think I preferred the "depends HIBERNATION" idea -- I
> >> > thought that was the consensus of the thread too?
> >> 
> >> Why HIBERNATION (and SWAP) instead of SUSPEND? Xen doesn't
> >> support the former (other than the latter)...
> > 
> > HIBERNATION provides the FREEZE, THAW and RESUME methods which we would
> > like to use to integrate save/restore/checkpoint with the PM core i.e.
> > choose THAW vs. RESUME based on whether the suspend was cancelled (aka a
> > checkpoint) or not. See Shriram's other recent patch for details.
> 
> But imo it's nevertheless wrong to select HIBERNATION (and bogus
> to select SWAP), as that'll create to user space the impression that
> the kernel is capable of doing hibernation, which is wrong. If you
> need the particular PM operations but no hibernation, then an
> intermediary option will need to be introduced.

I think we can introduce CONFIG_HIBERNATE_INTERFACE that will be user-visible
option instead of CONFIG_HIBERNATION and will select the latter.  Then,
CONFIG_XEN_SAVE_RESTORE will also be able to select CONFIG_HIBERNATION without
building the hibernate interface in, which will prevent user space from being
confused, but that will cause too much code to be built anyway.

Thanks,
Rafael
