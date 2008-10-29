From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] hibernation should work ok with memory hotplug
Date: Wed, 29 Oct 2008 13:25:00 +0100
Message-ID: <200810291325.01481.rjw@sisk.pl>
References: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753916AbYJ2MU0@vger.kernel.org>
In-Reply-To: <20081029105956.GA16347@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 29 of October 2008, Pavel Machek wrote:
> 
> hibernation + memory hotplug was disabled in kconfig because we could
> not handle hibernation + sparse mem at some point. It seems to work
> now, so I guess we can enable it.

OK, if "it seems to work now" means that it has been tested and confirmed to
work, no objection from me.

Thanks,
Rafael


> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> 
> diff -ur linux/mm/Kconfig linux.tmp/mm/Kconfig
> --- linux/mm/Kconfig	2008-10-27 10:10:59.000000000 +0100
> +++ linux.tmp/mm/Kconfig	2008-10-29 10:02:41.000000000 +0100
> @@ -128,12 +128,9 @@
>  config MEMORY_HOTPLUG
>  	bool "Allow for memory hot-add"
>  	depends on SPARSEMEM || X86_64_ACPI_NUMA
> -	depends on HOTPLUG && !HIBERNATION && ARCH_ENABLE_MEMORY_HOTPLUG
> +	depends on HOTPLUG && ARCH_ENABLE_MEMORY_HOTPLUG
>  	depends on (IA64 || X86 || PPC64 || SUPERH || S390)
>  
> -comment "Memory hotplug is currently incompatible with Software Suspend"
> -	depends on SPARSEMEM && HOTPLUG && HIBERNATION
> -
>  config MEMORY_HOTPLUG_SPARSE
>  	def_bool y
>  	depends on SPARSEMEM && MEMORY_HOTPLUG
> 
