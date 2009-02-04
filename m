From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
 pci_legacy_suspend
Date: Thu, 05 Feb 2009 08:38:22 +1100
Message-ID: <1233783502.4612.7.camel__15458.313530735$1233783940$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl>
	<200902040159.10258.rjw@sisk.pl> <200902040159.10258.rjw@sisk.pl>
	<1233712613.16867.136.camel@pasglop>
	<200902041115.00842.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902041115.00842.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-02-04 at 11:14 +0100, Frans Pop wrote:
> Benjamin Herrenschmidt wrote:
> > Minor nit: Should the warning be preceeded by a message ? The reason is,
> > right now, all we get is a backtrace, it doesn't actually tell you which
> > device or driver caused it which makes it pretty pointless.
> > 
> > I think you should add a printk(KERN_ERR... just before that which gives
> > those informations along with a little blurb along the lines of "driver
> > changed device state without saving config space state").
> 
> That is actually already included in the patch (through drv->suspend):

How so ? I've had such backtraces with no other info in my log...

Ben.
