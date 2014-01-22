From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Wed, 22 Jan 2014 18:17:24 +0000
Message-ID: <20140122181724.GR17314@sirena.org.uk>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <CAP245DXdFS5FEkrDvSw07aDDuZDqFPZXF=CoBLPrBB4JuYE8cQ@mail.gmail.com>
 <20140121152358.GD28801@e102568-lin.cambridge.arm.com>
 <20140122115214.GG17314@sirena.org.uk>
 <20140122162313.GE24288@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CWeaa2rMoVPmUX0K"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58226 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbaAVSRf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 13:17:35 -0500
Content-Disposition: inline
In-Reply-To: <20140122162313.GE24288@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Antti Miettinen <ananaza@iki.fi>, Tomasz Figa <t.figa@samsung.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Dave P Martin <Dave.Martin@arm.com>, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Charles


--CWeaa2rMoVPmUX0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2014 at 04:23:14PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 22, 2014 at 11:52:14AM +0000, Mark Brown wrote:

> > Actually looking at the OPP binding I do wonder if it might not be
> > better to have a v2/rich binding for them which is extensible - the fact
> > that it's not possible to add additional information seems like an
> > issue, this can't be the only thing anyone might want to add and lining
> > up multiple tables is never fun.

> On one hand OPP bindings need improvement and that's on the cards. I am not
> really following what you mean by "extensible", I only want to make sure
> that the C-state bindings do not become too complex.

By extensible I guess I mostly mean not just a list of numbers we can't
add additional information to without breaking compatibility.  Having to
look through tables and make sure they all use the same indexes gets
error prone and generally miserable.

> Do you mean extending OPP bindings to add eg C-state information there
> (or whatever piece of information that is OPP dependent) ?
> It seems a bit of a stretch but I can think about that.

> I think that C-state properties are better defined in the C-state bindings
> that was the idea but I am open to suggestions.

I think defining in these bindings makes total sense, it's just
providing an extension to the OPP binding (which is already being looked
at anyway).  The exensibility issue I see is that with the current OPP
binding it's inelegant for another binding to add extra information
about an operating point relevant to that binding.

--CWeaa2rMoVPmUX0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4AsxAAoJELSic+t+oim9KcwQAI+g3qxKQU3FzR0w1Rac0CCq
ldeQd4jwdOP1Vw8HLPQFkXwpNb5XUScREX5h0mRusH3PY/7cWM3CIaOeRvzY0D7O
XXnT5kIq87O2XDIVXMpQiD18GUMADsrT3/y66qZOzNMQ2JyGhRTrX3aTtqK5cw65
O4Er8qUqIkmkPjDm1qzTY4Al5Gtfj6/uTt/eybSf1BAakPwemh5uyemrpjGcoOWV
bU+ErH2KfnWAV1SQ0HEDASaPeq5d331f5kqe1gz4yuAa0QmR6bRpma8YSO3K/7VH
b52ROTwOUT9nonfIuaUw0drnGaKwEEvyXWcQ5PQ5p/XE5qOAIU2RDE4Y9uQndgZs
Y9kmiwOwRKHXSsZuCB4Ld6xqtLFQnQHHmddtK4zZczh6J5lswFEb8m8jsiHnbJCK
YtY9viQajNsML045FZ/bhywIj3LG8Ank/BWtvJmK61d8YNqEcjIr9Cq7KktSbJ2k
zMoOugCYdzJOdbJMRV/PoXLeKuj7wU0devzYJTlPagaoZlb0HGkjnoDxE3OIoRXs
s+ixrV+8nchm4p+SrKnsPd3yigZjm1RqAf9QXY3MUd+HdkoHvZh7gF2AIzDJGHi8
FsoJmviBieyVqY7dx7zG8GRQ1v7eVnXIwRL1ND6RfrQylGsmidQm6AO6FyfyAIU/
Zra8sz61a3PJUW+FbfQI
=DHTC
-----END PGP SIGNATURE-----

--CWeaa2rMoVPmUX0K--
