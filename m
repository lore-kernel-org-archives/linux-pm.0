From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Question about suspending a system
Date: Mon, 15 Oct 2007 18:03:59 +0200
Message-ID: <1192464239.3349.57.camel@johannes.berg>
References: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6723380023669410391=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <38b2ab8a0710150543k6d35ae12h6dceef96acb00a71@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============6723380023669410391==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ae+5VNJNktZ5a5pOvuRj"


--=-ae+5VNJNktZ5a5pOvuRj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-10-15 at 14:43 +0200, Francis Moreau wrote:

> So my question is that when we suspend the system, it seems that all
> IRQs are masked and I'm a bit suprise since the event that should wake
> up the system is an interrupt. This mask is done by
> arch_suspend_disable_irqs() and none of the arch is overriding this
> stub. If I'm right, how the system should be waked up ?

No, well, in most cases the CPU is actually turned off by some other
chip (like the PMU on powermac systems) and turned on again by it when
the system should wake up.

> Anther point is that the device that consumes a lot on the system is
> the hard drive. I can decrease its power consumption by stopping its
> motor by using "hdparm" but it still consumes too much. So for now I'm
> thinking of stopping to power it up completely. But I don't know it's
> going to be easy to resume the hard drive. Does anybody have another
> idea or have already experience such trick ?

If you search the linuxppc-dev list somebody implemented suspend to ram
(or rather he called it standby) for linkstation powerpc systems. That
might be interesting for you because the CPU is actually not powered off
in that implementatino.

johannes

--=-ae+5VNJNktZ5a5pOvuRj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxOPbqVg1VMiehFYAQIjDA/8Clm5vQpFnSekVXxtvYwOuANxc83bqlQg
rIgDu08Qa+A0Hre5n1MUo8CDaqCOSxT4YWIa9czTPNK0y5qqUFlApYwwTCsf7kPr
2ypNo/cN0cb5heoaXtuhUUQXorwg7XHiRyJq+MttxA8S573vst+fhoSJvdrAL4VN
PtvUD4mP7hNOOS+WwOfMDEfzB/jT1FwoR4d7lzO32yHzBJ9xhlJyh4lEbV12yhUh
e9t5sbIgCF4gTW4TfV216cSyL/XPLWsIEyh2L3K8DkWDUJUkrhj+0ZIv81bmgiNr
E7Dogyfta9HAIV8r0SUFx6MtQWBRablDhzIYKKO77BHAM7Ij24SQpEeLS51/ozo7
GuBtpR/A9Ng0J+AmGP1/SGl3j5tFIba2V9pVuh72h2aanqFuVkHtgB+G6hQ7yhyD
moKSHcQVWXvB3U7W1Fo7zHVYIYN8PripJg+Sc3oDC7fzgKOMR0R7eipQjMDtUoEY
bXi4jTgtAyj+PLCZ1Pbpuc+pOXBOdmgpfuxePfPgBefpUIV+3nlvI5GGkgNHUK0y
h+el3o+7BFte49dc7S1NT1sZ9aUmePwv1izjeTaUCr5ELhNz6ljCjAyYmyv0jIpn
/mOysXnPY1+XL8pGha7lrFpT+a6xt90wS0Vo1kpT3/3WLOH1dMrjEu37a8s/eAPO
4KJxTPws6k8=
=a7t/
-----END PGP SIGNATURE-----

--=-ae+5VNJNktZ5a5pOvuRj--


--===============6723380023669410391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6723380023669410391==--
