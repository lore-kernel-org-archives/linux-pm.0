From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V3
Date: Thu, 18 Jun 2009 09:21:19 -0700
Message-ID: <87r5xhqzr4.fsf@deeprootsystems.com>
References: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
	(Magnus Damm's message of "Wed\, 10 Jun 2009 21\:16\:59 +0900")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> writes:

> From: Magnus Damm <damm@igel.co.jp>
>
> Allow architecture specific data in struct platform_device V3.
>
> With this patch struct pdev_archdata is added to struct
> platform_device, similar to struct dev_archdata in found in
> struct device. Useful for architecture code that needs to
> keep extra data associated with each platform device.
>
> Struct pdev_archdata is different from dev.platform_data, the
> convention is that dev.platform_data points to driver-specific
> data. It may or may not be required by the driver. The format
> of this depends on driver but is the same across architectures.
>
> The structure pdev_archdata is a place for architecture specific
> data. This data is handled by architecture specific code (for
> example runtime PM), and since it is architecture specific it
> should _never_ be touched by device driver code. Exactly like
> struct dev_archdata but for platform devices.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Since there is no 'Feature-desired-by:' tag, I'll addd

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

For PM on ARM in general, and OMAP in particular we definitely need a
generic way to handle arch-specific data per platform_device.

Kevin

>
>  Applies to next-20090610.
>
>  Changes since V2:
>  - updated commit message, thanks to Rafael for feedback
>
>  Changes since V1:
>  - post to lkml, keep linux-pm cc:ed
>  - add struct pdev_archdata to asm-generic
>  - add struct pdev_archdata to non-generic architectures
>  - drop Kconfig bits
>
>  arch/arm/include/asm/device.h        |    3 +++
>  arch/ia64/include/asm/device.h       |    3 +++
>  arch/microblaze/include/asm/device.h |    3 +++
>  arch/powerpc/include/asm/device.h    |    3 +++
>  arch/sparc/include/asm/device.h      |    3 +++
>  arch/x86/include/asm/device.h        |    3 +++
>  include/asm-generic/device.h         |    3 +++
>  include/linux/platform_device.h      |    3 +++
>  8 files changed, 24 insertions(+)
>
> --- 0001/arch/arm/include/asm/device.h
> +++ work/arch/arm/include/asm/device.h	2009-06-01 12:19:51.000000000 +0900
> @@ -12,4 +12,7 @@ struct dev_archdata {
>  #endif
>  };
>  
> +struct pdev_archdata {
> +};
> +
>  #endif
> --- 0001/arch/ia64/include/asm/device.h
> +++ work/arch/ia64/include/asm/device.h	2009-06-01 12:18:11.000000000 +0900
> @@ -15,4 +15,7 @@ struct dev_archdata {
>  #endif
>  };
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_IA64_DEVICE_H */
> --- 0001/arch/microblaze/include/asm/device.h
> +++ work/arch/microblaze/include/asm/device.h	2009-06-01 12:19:32.000000000 +0900
> @@ -16,6 +16,9 @@ struct dev_archdata {
>  	struct device_node	*of_node;
>  };
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_MICROBLAZE_DEVICE_H */
>  
>  
> --- 0001/arch/powerpc/include/asm/device.h
> +++ work/arch/powerpc/include/asm/device.h	2009-06-01 12:16:28.000000000 +0900
> @@ -30,4 +30,7 @@ dev_archdata_get_node(const struct dev_a
>  	return ad->of_node;
>  }
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_POWERPC_DEVICE_H */
> --- 0001/arch/sparc/include/asm/device.h
> +++ work/arch/sparc/include/asm/device.h	2009-06-01 12:18:57.000000000 +0900
> @@ -32,4 +32,7 @@ dev_archdata_get_node(const struct dev_a
>  	return ad->prom_node;
>  }
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_SPARC_DEVICE_H */
> --- 0001/arch/x86/include/asm/device.h
> +++ work/arch/x86/include/asm/device.h	2009-06-01 12:17:28.000000000 +0900
> @@ -13,4 +13,7 @@ struct dma_map_ops *dma_ops;
>  #endif
>  };
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_X86_DEVICE_H */
> --- 0001/include/asm-generic/device.h
> +++ work/include/asm-generic/device.h	2009-06-01 12:16:20.000000000 +0900
> @@ -9,4 +9,7 @@
>  struct dev_archdata {
>  };
>  
> +struct pdev_archdata {
> +};
> +
>  #endif /* _ASM_GENERIC_DEVICE_H */
> --- 0001/include/linux/platform_device.h
> +++ work/include/linux/platform_device.h	2009-06-01 12:14:43.000000000 +0900
> @@ -22,6 +22,9 @@ struct platform_device {
>  	struct resource	* resource;
>  
>  	struct platform_device_id	*id_entry;
> +
> +	/* arch specific additions */
> +	struct pdev_archdata	archdata;
>  };
>  
>  #define platform_get_device_id(pdev)	((pdev)->id_entry)
