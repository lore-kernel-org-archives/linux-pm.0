From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [RFC][PATCH 2/3] PCI PM:
	Introduce	platform_pci_power_manageable
Date: Mon, 16 Jun 2008 18:26:20 -0700
Message-ID: <1213665980.11712.120.camel__27650.7248556756$1213666109$gmane$org@localhost.localdomain>
References: <200806170206.26616.rjw@sisk.pl> <200806170214.51160.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806170214.51160.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org


On Tue, 2008-06-17 at 02:14 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Introduce function pointer platform_pci_power_manageable to be used
> by the platform-related code to point to a function allowing us to
> check if given device is power manageable by the platform.
> 
> Introduce acpi_pci_power_manageable() playing that role for ACPI.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |   11 +++++++++++
>  drivers/pci/pci.c      |    1 +
>  drivers/pci/pci.h      |    1 +
>  3 files changed, 13 insertions(+)
> 
> Index: linux-2.6/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-acpi.c
> +++ linux-2.6/drivers/pci/pci-acpi.c
> @@ -315,6 +315,16 @@ static pci_power_t acpi_pci_choose_state
>  }
>  #endif
> 
> +static bool acpi_pci_power_manageable(struct pci_dev *dev)
> +{
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> +
> +	if (!handle)
> +		return -ENODEV;

Seems like a bad idea to pass non-true/false values using a bool.
Wouldn't an int return type be more appropriate here?

<snip>

Cheers,
	-Matt Helsley
