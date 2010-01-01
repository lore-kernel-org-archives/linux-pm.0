From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] PCI / PM: Use per-device D3 delays
Date: Fri, 1 Jan 2010 21:12:35 +0100
Message-ID: <20100101201235.GA31960__8614.02904051847$1262376913$gmane$org@rhlx01.hs-esslingen.de>
References: <20100101170729.GA22252@rhlx01.hs-esslingen.de>
	<201001011955.27407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001011955.27407.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andreas Mohr <andi@lisas.de>, pm list <linux-pm@lists.linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, "Maciej J. Woloszyk" <mat@esi.com.pl>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Jan 01, 2010 at 07:55:27PM +0100, Rafael J. Wysocki wrote:
> On Friday 01 January 2010, Andreas Mohr wrote:
> > Hi,
> > 
> > While the bug report mentions "So it's just quirky hardware.",
> > the implementation of your patch makes it seem like this delay attribute is
> > totally "norm"al behaviour - I'm missing some more aggressive wording.
> 
> That's because it works both ways (please look at the changelog).

Ah, ok.

> I know of a few devices that don't need the PCI-prescribed 10 ms wait when
> going from D3 to D0 and their drivers may use the d3_delay field to actually
> set a _shorter_ delay.

Then why is the value lower-bounded by pci_pm_d3_delay
(which, puzzlingly, was initialized to PCI_PM_D3_WAIT and thus 10
before, which the patch now removes!), in pci_dev_d3_sleep()?
(and pci_pm_d3_delay is being quirked in drivers/pci/quirks.c only,
to 120)

Confused,

Andreas Mohr
