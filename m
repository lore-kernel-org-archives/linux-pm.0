From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 5/7] thermal: add trace events to the power allocator
 governor
Date: Thu, 26 Feb 2015 15:46:34 -0400
Message-ID: <20150226194633.GC4941@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-6-git-send-email-javi.merino@arm.com>
 <20150226143845.67e00224@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150226143845.67e00224@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Javi Merino <javi.merino@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 02:38:45PM -0500, Steven Rostedt wrote:
> On Thu, 26 Feb 2015 19:00:31 +0000
> Javi Merino <javi.merino@arm.com> wrote:
>=20
> > Add trace events for the power allocator governor and the power actor
> > interface of the cpu cooling device.
>=20
> For the tracing parts...
>=20
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks Steve.

I am planing to apply this series to my thermal soc tree. Do you have
any concerns if I send this patch, which touches the tracing files, via
my tree?

BR,


Eduardo Valentin

>=20
> -- Steve
>=20
> >=20
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU73gRAAoJEMLUO4d9pOJW84AH/jjOF5RbuWpv4yI5PFhaF9gC
4/ZFPdjFB+daUnVoDbZO4py892QN9qR6znGvEzEiLHdbhvuG1Kp1e2MrMyAqSgj1
sWdeXMgR16mtQBeibDTworQZ4iCN7hTzMq3p+N3nWMSq0uCPctO/OlldoG0Y+86f
Fm48EohaSfMWTppKzV1h0JfksyfRMUpFDo2Apa0aTdvLhXWEpNoqP+qv7KBg5DFy
6vw+l3iQBuDyl1un2SKAipLH+MMpy62xXrjkjSQAGm50kO0qaQePQJShLaevuAtu
3NZ77O5Vqmg0O5X3UgJ6gQdzuXrKNSl5coFAq/YtEiaFiCPngJ0WXpaC/4LvxSs=
=Jgpg
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
