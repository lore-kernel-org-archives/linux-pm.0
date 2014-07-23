From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
Date: Wed, 23 Jul 2014 15:51:28 +0200
Message-ID: <20140723135127.GB14263@ulmo.nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
 <20140723065412.GA15759@ulmo.nvidia.com>
 <CAKohponmg24pvnX2Jhfg5LHKKHx3VEm-6a_JXTGhVXY-aj3EOw@mail.gmail.com>
 <20140723072442.GC15759@ulmo.nvidia.com>
 <CAKohponfKzuK+TnQvWcvaT8hRX8XZJWXWGMQw138DCwP=qcx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohponfKzuK+TnQvWcvaT8hRX8XZJWXWGMQw138DCwP=qcx+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2014 at 01:55:57PM +0530, Viresh Kumar wrote:
> On 23 July 2014 12:54, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > ARM_TEGRA_CPUFREQ is still optional, so the select only applies when the
> > Tegra cpufreq driver is enabled. This is mostly just out of convenience,
> > though. The Tegra cpufreq driver uses the generic CPU0 cpufreq driver so
> > a select will automatically pull in the necessary dependency. With a
>=20
> Not necessarily. cpufreq-cpu0 can have few unmet dependency. And so
> there are chances that tegra driver is compiled but cpufreq-cpu0 isn't as
> we didn't mention it as a *hard* dependency.
>=20
> And so at boot, there wouldn't be any cpufreq support even when tegra's
> cpufreq driver is available.
>=20
> Though, menuconfig may give some warnings no such situations.
>=20
> > "depends on" the Tegra cpufreq driver only becomes available after
> > you've selected GENERIC_CPUFREQ_CPU0, which is somewhat unintuitive.
> >
> > To illustrate with an example: as a user, I want to enable CPU frequency
> > scaling on Tegra. So I use menuconfig to navigate to the "CPU Frequency
> > scaling" menu (enable it if not available yet) and look for an entry
> > that says "Tegra". But I can't find it because it's hidden due to the
> > lack of GENERIC_CPUFREQ_CPU0. That the Tegra CPU frequency driver uses a
> > generic driver is an implementation detail that users shouldn't have to
> > be aware of.
>=20
> Don't know, the guy compiling out stuff should be knowledgeable enough to
> have a look why tegra cpufreq entry isn't shown in menu. As, probably the
> above problem I mentioned looks to be of more significance than this one,
> atleast to me :)
>=20
> And, another thing to mention is that CONFIG_TEGRA_CPUFREQ is valid
> for earlier platforms as well and so a select/depends wouldn't be valid f=
or
> earlier platforms. We probably need another Kconfig entry here.

Yes, sounds like a new Kconfig entry for this specific driver would be a
better approach and should remove all the above concerns.

Thierry

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBAgAGBQJTz73eAAoJEN0jrNd/PrOhLJYP+IuuRTEEvQoTQ1Y2AMHVsLTf
tPei0ThoS2Mav5HMWIGOKB8kbmqf0koRR4Z+SHRlwrdyU7VN9aNmDXUY2MCZWs9X
XLmzPaQAFcvciI+8t6GT0uJBBRCzhC06+PQdKeMEaTyqKhsDaC0fmbQQYiaRzMBe
F2YG18PY3jDeEXid+OYIuwOt9bH3EGp1Of+9BbFANmBQyG8Jdt6Un7cAWYJj/dTi
vl4eekndo+Hd0n3QYmW/6Urzb4DEyY+giiZ6d7MLDZs/zx7s+zoCzxgKo4JbMizy
LlhKyE1FHV8gM7uwfVxyM3f1fv0LGmXYpfv8KfU9+XHK0IDQKjpfAZ7A+TA5bZ1+
o3U+0nno7E0TSWIJcjuStUP1M8QVlVum87D01zatkgsn/hm/6XxijH+8Br6k1R3E
cIDQS7+ziEYSpjTrvV4t9pOHmxe1HlhC5yfBs8m1r+gAQBdAKuZeTiDO1DAbf3Ka
ok9QlOCDWSwCAYMdGrv/qyrkA4/U6aqZtb1xvW5uucc081TnN4cQcW/1KcWhinrQ
EBVxGAVEaGZnbhlml8SqqVQEzNFsT+aDzkCQYu8fU7g2xEJedgJNv3TpLqxewYFW
GY2iJcj+QdgqaOoTpWBbGJvNjiqb8iFR0xK+odB/+ops16B19o0rnUffmujdtyJC
TlT/ri2zehYTNtTnkRg=
=zC7T
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
