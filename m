From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: T30 boot hang with CONFIG_PM_LEGACY=n
Date: Wed, 27 Sep 2006 15:47:31 +0100
Message-ID: <20060927144731.GA3641@srcf.ucam.org>
References: <20060927024628.GA29182@redhat.com> <200609270000.40760.len.brown@intel.com> <20060927042029.GA3571@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060927042029.GA3571@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 27, 2006 at 12:20:29AM -0400, Dave Jones wrote:

> Good question.  There's no real replacement for pm_active in the non-legacy
> config afaik. Perhaps the cleanest alternative is to undeprecate that macro?
> The only other option I can think of is doing something like this in apm.c ...
> 
> +#ifdef CONFIG_ACPI
> -        if (PM_IS_ACTIVE()) {
>                  printk(KERN_NOTICE "apm: overridden by ACPI.\n");
>                  apm_info.disabled = 1;
>                  return -ENODEV;
> -         }
> +#endif

That's not a good choice - it needs to be a runtime check, not a 
compile-time one. Don't we have an acpi_enabled() function?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
