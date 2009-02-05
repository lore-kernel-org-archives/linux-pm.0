From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
 pci_legacy_suspend
Date: Thu, 05 Feb 2009 11:40:10 +1100
Message-ID: <1233794410.4612.34.camel__23961.766184266$1233794679$gmane$org@pasglop>
References: <200902040154.36018.rjw@sisk.pl>
	<200902040159.10258.rjw@sisk.pl> <200902040159.10258.rjw@sisk.pl>
	<1233712613.16867.136.camel@pasglop>
	<200902041115.00842.elendil@planet.nl>
	<1233783502.4612.7.camel@pasglop>
	<alpine.LFD.2.00.0902041355320.3247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902041355320.3247@localhost.localdomain>
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
Cc: linux-pci@vger.kernel.org, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-02-04 at 13:56 -0800, Linus Torvalds wrote:
> 
> On Thu, 5 Feb 2009, Benjamin Herrenschmidt wrote:
> > 
> > How so ? I've had such backtraces with no other info in my log...
> 
> _with_ that patch?
> 
> It very much replaces a warning with no further info with
> 
> +                       WARN_ONCE(pci_dev->current_state != prev,
> +                               "PCI PM: Device state not saved by %pF\n",
> +                               drv->suspend);
> 
> And notice the "%pF" and the 'drv->suspend': it should tell you exactly 
> which suspend routine it was that messed up.

Yup, missed that change in the patch. In fact, I even missed the
existence of a WARN_ONCE that takes those text arguments... baaaah. I
suppose I should try to read more of lkml :-)

Cheers,
Ben.
