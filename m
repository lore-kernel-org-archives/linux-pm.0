From: Dave Airlie <airlied@gmail.com>
Subject: Re: Resume problem with radeon+KMS (2.6.34-rc2 and
	before)
Date: Mon, 22 Mar 2010 08:36:20 +1000
Message-ID: <21d7e9971003211536p78792320rf93f9ba5db6c54ff__39260.7703026899$1269211059$gmane$org@mail.gmail.com>
References: <201003212228.13923.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003212228.13923.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-1?Q?J=E9r=F4me_Glisse?= <glisse@freedesktop.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2010/3/22 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> Some time ago I reported a problem with resuming from suspend to RAM on
> HP nx6325 with radeon+KMS.

Can you post the X.org log file? if you are really using 6.12.4 and
not a backport
then the userspace driver has no KMS support and it is trashing the system.

Dave.

>
> The problem was that the first resume always failed if the suspend was st=
arted
> from under X. =A0Moreover, the resume went correctly until the last switc=
h from
> the framebuffer console (which was now controlled by the radeon driver as
> well) to X that made the box hang hard.
>
> However, if the first resume was started from the (radeon-controlled)
> framebuffer console, the subsequent resume succeeded and all of the next
> attempts to suspend/resume succeeded, _regardless_ of the way the suspend=
 was
> started.
>
> At that time Dave thought it might be a problem with the nx6325's graphics
> adapter that apparently was a crappy one, but today I found that _exactly=
_ the
> same behavior was observable on Acer Ferrari One, which was quite differe=
nt,
> hardware-wise, from the old HP box. =A0For this reason I think the proble=
m is
> related to the driver itself rather than to the hardware or firmware.
>
> The problem is reproducible on both machines with the latest git kernel
> and the user space radeon_drv.so from openSUSE 11.2 (it says
> module version =3D 6.12.4 in the X log). =A0The kernel and user space are=
 64-bit
> on both machines. =A0[For completness, the Acer box suspends and resumes
> correctly with radeon.modeset=3D0 and "s2ram -f -p -m".]
>
> Should I try a newer user space X driver? =A0Or may the problem be relate=
d to
> the 64-bitness somehow?
>
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
