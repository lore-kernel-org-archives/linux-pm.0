From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/7] PCI PM: Fix saving of device state in
 pci_legacy_suspend
Date: Wed, 4 Feb 2009 13:56:46 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902041355320.3247__45328.8061581135$1233784741$gmane$org@localhost.localdomain>
References: <200902040154.36018.rjw@sisk.pl> <200902040159.10258.rjw@sisk.pl>
	<200902040159.10258.rjw@sisk.pl>
	<1233712613.16867.136.camel@pasglop>
	<200902041115.00842.elendil@planet.nl>
	<1233783502.4612.7.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1233783502.4612.7.camel@pasglop>
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
Cc: linux-pci@vger.kernel.org, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org



On Thu, 5 Feb 2009, Benjamin Herrenschmidt wrote:
> 
> How so ? I've had such backtraces with no other info in my log...

_with_ that patch?

It very much replaces a warning with no further info with

+                       WARN_ONCE(pci_dev->current_state != prev,
+                               "PCI PM: Device state not saved by %pF\n",
+                               drv->suspend);

And notice the "%pF" and the 'drv->suspend': it should tell you exactly 
which suspend routine it was that messed up.

		Linus
