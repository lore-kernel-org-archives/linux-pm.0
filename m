From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Tue, 29 Apr 2008 13:32:13 -0700
Message-ID: <200804291332.14489.david-b__49103.657101705$1209501703$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<20080428213553.GA3489@khazad-dum.debian.net>
	<200804281520.05683.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804281520.05683.david-b@pacbell.net>
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
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 28 April 2008, David Brownell wrote:

> When I last did a survey of what drivers use PCI wakeup mechanisms,
> the result was pretty weak:  a handful of network drivers, and the
> USB host controllers.  Such support has been, if anything, declining
> since we acquired "pm_message_t".  But I believe that most of those
> drivers actually behave, at least on non-ACPI systems.
> 
> Try "cd linux-2.6; grep -lr pci_enable_wake *" for current results...

linux-2.6$  grep -lr pci_enable_wake *
Documentation/power/devices.txt
Documentation/power/pci.txt
drivers/memstick/host/jmb38x_ms.c
drivers/message/fusion/mptbase.c
drivers/misc/tifm_7xx1.c
drivers/mmc/host/sdhci.c
drivers/net/3c59x.c
drivers/net/8139cp.c
drivers/net/amd8111e.c
drivers/net/atlx/atl1.c
drivers/net/e100.c
drivers/net/e1000/e1000_main.c
drivers/net/e1000e/netdev.c
drivers/net/forcedeth.c
drivers/net/igb/igb_main.c
drivers/net/ixgbe/ixgbe_main.c
drivers/net/r8169.c
drivers/net/skge.c
drivers/net/sky2.c
drivers/net/tulip/dmfe.c
drivers/net/tulip/uli526x.c
drivers/net/typhoon.c
drivers/net/via-rhine.c
drivers/net/via-velocity.c
drivers/net/wireless/airo.c
drivers/pci/pci.c
drivers/scsi/megaraid/megaraid_sas.c
drivers/scsi/nsp32.c
drivers/usb/core/hcd-pci.c
include/linux/pci.h
linux-2.6$ 
