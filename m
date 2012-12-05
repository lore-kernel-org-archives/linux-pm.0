From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / PM: Fix header of acpi_dev_pm_detach() in acpi.h
Date: Wed, 5 Dec 2012 14:48:46 +0200
Message-ID: <20121205124846.GV3117@intel.com>
References: <3898205.CQSHFfLUWL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3898205.CQSHFfLUWL@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 05, 2012 at 12:08:12PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The header of acpi_dev_pm_detach() in include/linux/acpi.h has an
> incorrect return type, which should be void.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  include/linux/acpi.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/include/linux/acpi.h
> ===================================================================
> --- linux.orig/include/linux/acpi.h
> +++ linux/include/linux/acpi.h
> @@ -506,7 +506,7 @@ static inline int acpi_subsys_resume_ear
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> -int acpi_dev_pm_detach(struct device *dev, bool power_off);
> +void acpi_dev_pm_detach(struct device *dev, bool power_off);
>  #else
>  static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
