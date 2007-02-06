From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
Date: Tue, 6 Feb 2007 13:40:47 +0100
Message-ID: <20070206124047.GC8662@elf.ucw.cz>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070205185838.029827000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> This implements suspend and resume code for the dart iommu.
> =

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> @@ -54,6 +54,9 @@ static unsigned long dart_tablesize;
>  =

>  /* Virtual base address of the DART table */
>  static u32 *dart_vbase;
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static u32 *dart_copy;
> +#endif
>  =

>  /* Mapped base address for the dart */
>  static unsigned int __iomem *dart;
> @@ -346,6 +349,52 @@ void iommu_init_early_dart(void)
>  	pci_dma_ops =3D &dma_direct_ops;
>  }
>  =

> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static int iommu_init_late_dart(void)
> +{
> +	unsigned long i;
> +	struct page *p;
> +
> +	/* this 16MB area is left unmapped because of caching
> +	 * considerations. that happens early so we can't mark
> +	 * it there, do it now instead */
> +	for (i =3D 0; i < (1<<24); i+=3D PAGE_SIZE)
> +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i))=
);
> +

80 columns rule?

> --- mb-wireless.orig/include/asm-powerpc/iommu.h	2007-02-05 14:24:05.0145=
26864 +0100
> +++ mb-wireless/include/asm-powerpc/iommu.h	2007-02-05 14:24:40.684526864=
 +0100
> @@ -108,6 +108,10 @@ static inline void pci_iommu_init(void) =

>  #endif
>  =

>  extern void alloc_dart_table(void);
> +#if defined(CONFIG_SOFTWARE_SUSPEND) && defined(CONFIG_U3_DART)
> +extern void iommu_dart_save(void);
> +extern void iommu_dart_restore(void);
> +#endif

You can go without the ifdef; extra prototype does not do any harm.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
