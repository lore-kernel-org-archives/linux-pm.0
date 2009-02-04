From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
	pci_legacy_suspend
Date: Wed, 4 Feb 2009 22:53:15 +0100
Message-ID: <200902042253.17447.elendil__31480.4175789051$1233784548$gmane$org@planet.nl>
References: <200902040154.36018.rjw@sisk.pl>
	<200902041115.00842.elendil@planet.nl>
	<1233783502.4612.7.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233783502.4612.7.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 04 February 2009, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 11:14 +0100, Frans Pop wrote:
> > Benjamin Herrenschmidt wrote:
> > > Minor nit: Should the warning be preceeded by a message ? The
> > > reason is, right now, all we get is a backtrace, it doesn't
> > > actually tell you which device or driver caused it which makes it
> > > pretty pointless.
> > >
> > > I think you should add a printk(KERN_ERR... just before that which
> > > gives those informations along with a little blurb along the lines
> > > of "driver changed device state without saving config space
> > > state").
> >
> > That is actually already included in the patch (through
> > drv->suspend):
>
> How so ? I've had such backtraces with no other info in my log...

Previous versions did not have the info, but with this patch I get:
WARNING: at drivers/pci/pci-driver.c:374 pci_legacy_suspend+0x9b/0xde()
Hardware name: HP Compaq 2510p Notebook PC
PCI PM: Device state not saved by iwl_pci_suspend+0x0/0x4c [iwlagn]
[...]

Driver and function causing the warning are in the last line.

Cheers,
FJP
