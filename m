From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [linux-pm] [PATCH 1/6] [-mm]: ACPI: add a Kconfig option for
 ACPI procfs interface
Date: Sat, 6 Jan 2007 09:14:50 -0800
Message-ID: <20070106091450.60fcc032.randy.dunlap@oracle.com>
References: <1168083310.5619.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1168083310.5619.35.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, 06 Jan 2007 19:35:10 +0800 Zhang Rui wrote:

> From: Zhang Rui <rui.zhang@intel.com>
> 
> Add a kconfig option CONFIG_ACPI_PROCFS to make procfs interface a configurable attribute of ACPI.
> No procfs interface is actually deprecated, and no sysfs interface is added in this patch.
> CONGI_ACPI_PROCFS is used to mark procfs interface as deprecated once the same function is duplicated in sysfs.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+)
> 
> Index: linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig
> ===================================================================
> --- linux-2.6.20-rc2-mm1.orig/drivers/acpi/Kconfig	2007-01-05 17:20:09.000000000 +0800
> +++ linux-2.6.20-rc2-mm1/drivers/acpi/Kconfig	2007-01-05 17:21:51.000000000 +0800
> @@ -77,6 +77,16 @@ config ACPI_SLEEP_PROC_SLEEP
>  	  Create /proc/acpi/sleep
>  	  Deprecated by /sys/power/state
>  
> +config ACPI_PROCFS
> +	bool "Procfs interface (deprecated)"
> +	depends on ACPI
> +	default y
> +	---help---
> +	  Procfs interface for ACPI is made optional for back-compatible.
> +	  As the same functions are duplicated in sysfs interface
> +	  and this proc interface will be removed some time later,
> +	  it's marked as deprecated.
> +

If it's going to be removed, it should be listed as such in
Documentation/feature-removal-schedule.txt .

---
~Randy
