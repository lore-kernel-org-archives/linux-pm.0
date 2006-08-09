From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 4/5] swsusp: Change the name of
	pagedir_nosave
Date: Wed, 9 Aug 2006 12:35:21 +0200
Message-ID: <20060809103521.GK3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091211.34615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608091211.34615.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-08-09 12:11:34, Rafael J. Wysocki wrote:
> The name of the pagedir_nosave variable does not make sense any more, so =
it
> seems reasonable to change it to something more meaningful.

Yes, that name was wrong from day 0. ACK.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/i386/power/swsusp.S         |    2 +-
>  arch/powerpc/kernel/swsusp_32.S  |    4 ++--
>  arch/x86_64/kernel/suspend_asm.S |    2 +-
>  kernel/power/power.h             |    2 --
>  kernel/power/snapshot.c          |   15 +++++++++------
>  5 files changed, 13 insertions(+), 12 deletions(-)
> =

> Index: linux-2.6.18-rc3-mm2/arch/i386/power/swsusp.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc3-mm2.orig/arch/i386/power/swsusp.S
> +++ linux-2.6.18-rc3-mm2/arch/i386/power/swsusp.S
> @@ -32,7 +32,7 @@ ENTRY(swsusp_arch_resume)
>  	movl	$swsusp_pg_dir-__PAGE_OFFSET, %ecx
>  	movl	%ecx, %cr3
>  =

> -	movl	pagedir_nosave, %edx
> +	movl	restore_pblist, %edx
>  	.p2align 4,,7
>  =

>  copy_loop:
> Index: linux-2.6.18-rc3-mm2/arch/powerpc/kernel/swsusp_32.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc3-mm2.orig/arch/powerpc/kernel/swsusp_32.S
> +++ linux-2.6.18-rc3-mm2/arch/powerpc/kernel/swsusp_32.S
> @@ -159,8 +159,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  	isync
>  =

>  	/* Load ptr the list of pages to copy in r3 */
> -	lis	r11,(pagedir_nosave - KERNELBASE)@h
> -	ori	r11,r11,pagedir_nosave@l
> +	lis	r11,(restore_pblist - KERNELBASE)@h
> +	ori	r11,r11,restore_pblist@l
>  	lwz	r10,0(r11)
>  =

>  	/* Copy the pages. This is a very basic implementation, to
> Index: linux-2.6.18-rc3-mm2/arch/x86_64/kernel/suspend_asm.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc3-mm2.orig/arch/x86_64/kernel/suspend_asm.S
> +++ linux-2.6.18-rc3-mm2/arch/x86_64/kernel/suspend_asm.S
> @@ -54,7 +54,7 @@ ENTRY(restore_image)
>  	movq	%rcx, %cr3;
>  	movq	%rax, %cr4;  # turn PGE back on
>  =

> -	movq	pagedir_nosave(%rip), %rdx
> +	movq	restore_pblist(%rip), %rdx
>  loop:
>  	testq	%rdx, %rdx
>  	jz	done
> Index: linux-2.6.18-rc3-mm2/kernel/power/power.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc3-mm2.orig/kernel/power/power.h
> +++ linux-2.6.18-rc3-mm2/kernel/power/power.h
> @@ -38,8 +38,6 @@ extern struct subsystem power_subsys;
>  /* References to section boundaries */
>  extern const void __nosave_begin, __nosave_end;
>  =

> -extern struct pbe *pagedir_nosave;
> -
>  /* Preferred image size in bytes (default 500 MB) */
>  extern unsigned long image_size;
>  extern int in_suspend;
> Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c
> +++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
> @@ -38,8 +38,11 @@
>   * the suspend and included in the suspend image, but have also been
>   * allocated by the "resume" kernel, so their contents cannot be written
>   * directly to their "original" page frames.
> + *
> + * NOTE: It cannot be static, because it is used by the architecture-dep=
endent
> + * atomic restore code.
>   */
> -struct pbe *pagedir_nosave;
> +struct pbe *restore_pblist;
>  =

>  /* Pointer to an auxiliary buffer (1 page) */
>  static void *buffer;
> @@ -824,7 +827,7 @@ void swsusp_free(void)
>  	}
>  	nr_copy_pages =3D 0;
>  	nr_meta_pages =3D 0;
> -	pagedir_nosave =3D NULL;
> +	restore_pblist =3D NULL;
>  	buffer =3D NULL;
>  }
>  =

> @@ -1203,7 +1206,7 @@ load_header(struct swsusp_info *info)
>  {
>  	int error;
>  =

> -	pagedir_nosave =3D NULL;
> +	restore_pblist =3D NULL;
>  	error =3D check_header(info);
>  	if (!error) {
>  		nr_copy_pages =3D info->image_pages;
> @@ -1562,8 +1565,8 @@ static void *get_buffer(struct memory_bi
>  	pbe->orig_address =3D page_address(page);
>  	pbe->address =3D safe_pages_list;
>  	safe_pages_list =3D safe_pages_list->next;
> -	pbe->next =3D pagedir_nosave;
> -	pagedir_nosave =3D pbe;
> +	pbe->next =3D restore_pblist;
> +	restore_pblist =3D pbe;
>  	return (void *)pbe->address;
>  }
>  =

> @@ -1628,7 +1631,7 @@ int snapshot_write_next(struct snapshot_
>  =

>  				chain_init(&ca, GFP_ATOMIC, 1);
>  				bm_position_reset(&orig_bm);
> -				pagedir_nosave =3D NULL;
> +				restore_pblist =3D NULL;
>  				handle->sync_read =3D 0;
>  				handle->buffer =3D get_buffer(&orig_bm, &ca);
>  				if (!handle->buffer)

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
