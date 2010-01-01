From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] PCI / PM: Use per-device D3 delays
Date: Fri, 1 Jan 2010 22:56:24 +0100
Message-ID: <20100101215624.GA16354__29192.1436707073$1262383047$gmane$org@rhlx01.hs-esslingen.de>
References: <20100101170729.GA22252@rhlx01.hs-esslingen.de>
	<201001011955.27407.rjw@sisk.pl>
	<20100101201235.GA31960@rhlx01.hs-esslingen.de>
	<201001012242.28322.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001012242.28322.rjw@sisk.pl>
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

On Fri, Jan 01, 2010 at 10:42:28PM +0100, Rafael J. Wysocki wrote:
> On Friday 01 January 2010, Andreas Mohr wrote:
> > Then why is the value lower-bounded by pci_pm_d3_delay
> > (which, puzzlingly, was initialized to PCI_PM_D3_WAIT and thus 10
> > before, which the patch now removes!),
> 
> That's because dev->d3_delay is initialized to PCI_PM_D3_WAIT for all devices.

Doh, I should have viewn the altered mechanism correctly, sorry.
Seems quite correct and useful after all.

Andreas Mohr
