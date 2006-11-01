From: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Tue, 31 Oct 2006 22:15:43 -0500
Message-ID: <200610312215.44454.len.brown@intel.com>
References: <20061029231358.GI27968@stusta.de>
	<20061030135625.GB1601@mellanox.co.il>
	<20061101030126.GE27968@stusta.de>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061101030126.GE27968@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>, Martin Lorenz <martin@lorenz.eu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The BIOS disables the LAPIC for a reason.
A couple of years ago Linux made the mistake of enabling the LAPIC
that the BIOS disabled, and all hell broke loose.
We fixed that bug about a year ago, but left "lapic"
to force it on for those where forcing it to be enabled actually
works (eg. some folks want the NMI profiling on their IOAPIC-less  laptop)

But if you force the lapic to be enabled, you are running the system
in a mode not supported by the manufacturer and you are on your own.

I don't see an indication that this is a bug.
If it used to work and it is important to you,
 then run the old software where it used to work --
because chances are good that it worked by accident.

-Len

On Tuesday 31 October 2006 22:01, Adrian Bunk wrote:
> FYI:
> =

> Subject    : Thinkpad R50p: boot fail with (lapic && on_battery)
> References : http://lkml.org/lkml/2006/10/31/333
> Submitter  : Ernst Herzberg <earny@net4u.de>
> Status     : submitter was asked to bisect
> =

> It seems to be completely unrelated (except that it's also a ThinkPad), =

> but it might be worth a try whether a (non-SMP) kernel without APIC =

> support fixes the issues after resume.
> =

> Hugh, your laptop seems to be a non-SMP laptop.
> Do you have APIC enabled, and if yes does disabling help?
> =

> cu
> Adrian
> =

> =

> VERSION =3D 2
> PATCHLEVEL =3D 6
> SUBLEVEL =3D 19
> EXTRAVERSION =3D -rc4
> NAME=3DThinkPad Killer
> =

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> =
