From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] ACPI: Remove the wakeup.run_wake_count
	device field
Date: Thu, 3 Feb 2011 11:20:16 -0800
Message-ID: <20110203112016.56ed35c3__27152.6390723468$1296760948$gmane$org@jbarnes-desktop>
References: <201102032014.18102.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102032014.18102.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Feb 2011 20:14:17 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The wakeup.run_wake_count ACPI device field is only used by the PCI
> runtime PM code to "protect" devices from being prepared for
> generating wakeup signals more than once in a row.  However, it
> really doesn't provide any protection, because (1) all of the
> functions it is supposed to protect use their own reference counters
> effectively ensuring that the device will be set up for generating
> wakeup signals just once and (2) the PCI runtime PM code uses
> wakeup.run_wake_count in a racy way, since nothing prevents
> acpi_dev_run_wake() from being called concurrently from two different
> threads for the same device.
> 
> Remove the wakeup.run_wake_count ACPI device field which is
> unnecessary, confusing and used in a wrong way.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/button.c   |    2 --
>  drivers/acpi/scan.c     |    1 -
>  drivers/pci/pci-acpi.c  |   16 ++++------------
>  include/acpi/acpi_bus.h |    1 -
>  4 files changed, 4 insertions(+), 16 deletions(-)

Ack on the PCI bits.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
