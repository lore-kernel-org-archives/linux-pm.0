From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: Suspend/resume regressions on Lenovo S10-3
Date: Wed, 06 Jun 2012 07:48:52 -0700
Message-ID: <4FCF6DD4.4090608@linux.vnet.ibm.com>
References: <4FC2DA8C.7050401@linux.vnet.ibm.com> <4FCF5249.2070600@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FCF5249.2070600@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Tomas M." <tmezzadra@gmail.com>, Ferenc Wagner <wferi@niif.hu>, Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@ti.com>, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>, Trinabh Gupta <g.trinabh@gmail.com>, linux-pm@lists.linux-foundation.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, preeti@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On 06/06/2012 05:51 AM, Deepthi Dharwar wrote:
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 24fe3af..6e35293 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -895,8 +895,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
>  	if (unlikely(!pr))
>  		return -EINVAL;
> 
> -
>  	if (acpi_idle_suspend) {
> +		local_irq_disable();
> +		local_irq_enable();
>  		cpu_relax();
>  		return -EINVAL;
>  	}

Heh, that is quite the hack. :)

However, it does at least work around my problem: I can suspend again
with 46bcfad + your patch.
