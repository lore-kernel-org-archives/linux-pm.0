From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] x86/suspend: fix false positive KASAN warning on
 suspend/resume
Date: Fri, 2 Dec 2016 13:54:31 +0100
Message-ID: <20161202125431.GB5869@amd>
References: <8f4c4a62-d912-0cd9-3462-8df20a868834@virtuozzo.com>
 <20161201145821.imkcgizo4thmiei2@treble>
 <20161201164551.52xlcftamleam6vq@treble>
 <CACT4Y+YXxcFAvBGsStZv8LC_30JvaC==UHznJre1z3UmsoqGsQ@mail.gmail.com>
 <20161201171306.swnvi4f2ezavloxd@treble>
 <CACT4Y+anS0XniR7ZxoEQ1nnAKPsGNvgc5L72uiSThOi3F742gA@mail.gmail.com>
 <20161201173438.bfe5eq23i6ezfxsq@treble>
 <CACT4Y+Z62RBTkiAjTG_ZF1zCZKA=S92fobENzRcq001XOTj36A@mail.gmail.com>
 <20161201175611.gf63mwzomt4wrlxy@treble>
 <20161201203154.mwt5x736g7z6jh3o@treble>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161201203154.mwt5x736g7z6jh3o@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Scott Bauer <scott.bauer@intel.com>, "x86@kernel.org" <x86@kernel.org>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>
List-Id: linux-pm@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Resuming from a suspend operation is showing a KASAN false positive
> warning:

> KASAN instrumentation poisons the stack when entering a function and
> unpoisons it when exiting the function.  However, in the suspend path,
> some functions never return, so their stack never gets unpoisoned,
> resulting in stale KASAN shadow data which can cause later false
> positive warnings like the one above.
>=20
> Reported-by: Scott Bauer <scott.bauer@intel.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wake=
up_64.S
> index 169963f..1df9b75 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -109,6 +109,22 @@ ENTRY(do_suspend_lowlevel)
>  	movq	pt_regs_r14(%rax), %r14
>  	movq	pt_regs_r15(%rax), %r15
> =20
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * The suspend path may have poisoned some areas deeper in the stack,
> +	 * which we now need to unpoison.
> +	 *
> +	 * We can't call kasan_unpoison_task_stack_below() because it uses %gs
> +	 * for 'current', which hasn't been set up yet.  Instead, calculate the
> +	 * stack range manually and call kasan_unpoison_shadow().
> +	 */
> +	movq	%rsp, %rdi
> +	andq	$CURRENT_MASK, %rdi
> +	movq	%rsp, %rsi
> +	xorq	%rdi, %rsi
> +	call	kasan_unpoison_shadow
> +#endif

Well... you may want to add note to kasan_unpoison_shadow()

/*
* This is called by early resume code, with cpu not yer properly
* resumed. In particular, %gs may not be set up, and thus current
* is not available.
*/

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhBbwcACgkQMOfwapXb+vLtbwCgkEw5k++uTWiy33jwf1bzxpED
n4EAnRobrdw/rZAeLR1I/LRLVmYTThV+
=Qtnr
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
