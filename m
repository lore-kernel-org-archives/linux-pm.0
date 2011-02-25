From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Subject: Re: [PATCH v2 2/3] sdhci-pci : Enable runtime PM support
Date: Fri, 25 Feb 2011 19:28:22 +0100
Message-ID: <201102251928.22328.rwys__6270.63612123511$1298658819$gmane$org@fuw.edu.pl>
References: <cover.1297014479.git.pierre.tardy@intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69935212DEA0@irsmsx501.ger.corp.intel.com>
	<20110225145440.GA31620@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110225145440.GA31620@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pierre Tardy <tardyp@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Yunpeng" <yunpeng.gao@intel.com>, "Tardy,
	Pierre" <pierre.tardy@intel.com>, Chris Ball <cjb@laptop.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, February 25, 2011, Matthew Garrett wrote:
> On Fri, Feb 25, 2011 at 07:33:12AM +0000, Tardy, Pierre wrote:
> 
> > My understanding is the pci driver is not supposed to do any set_power_state/pci_save_state/wake_enable.
> > Everything is supposed to be generically handle by pci frameworks's runtime_pm impl.
> > Need confirmation from Rafael.
> 
> The core can only enable PME generation, it can't configure what 
> generates PMEs. There's a register in sdhci that needs to be programmed 
> to enable wakeups on card insert/removal/interrupt. If you don't then 
> you won't get a PME no matter what the core does.

That's correct.  The driver shoulnd't touch the generic-PCI part of wakeup
preparation, but it _should_ configure the device-specific part of it.

It's quite similar to network adapters where you have to configure the adapter
to react to magic packets, for example, in addition to the PCI PME setup done
by the core.

Thanks,
Rafael
