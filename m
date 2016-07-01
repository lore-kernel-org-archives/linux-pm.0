From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
Date: Fri, 1 Jul 2016 09:02:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1607010901140.12094@knanqh.ubzr>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
 <577624A3.2000406@linaro.org> <1467376873.12509.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2140905334-1467378140=:12094"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1467376873.12509.1.camel@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: arnd@arndb.de, linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

--8323328-2140905334-1467378140=:12094
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Jul 2016, Balbir Singh wrote:

> On Fri, 2016-07-01 at 10:06 +0200, Daniel Lezcano wrote:
> > On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
> > >=C2=A0
> > > On Thu, 30 Jun 2016, Daniel Lezcano wrote:
> > [ ... ]
> >=C2=A0
> > >=C2=A0
> > > >=C2=A0
> > > > >=C2=A0
> > > > > +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
> > > > > +		u32 usec =3D nsec;
> > > > > +
> > > > > +		usec +=3D usec >> 5;
> > > > > +		usec =3D usec >> 10;
> > > > > +
> > > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > > +		return usec;
> > > > > +	} else {
> > > > > +		u64 usec =3D div_u64(nsec, 1000);
> > > > > +
> > > > > +		if (usec > INT_MAX)
> > > > > +			usec =3D INT_MAX;
> > > > > +
> > > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > > +		return usec;
> > > > > +	}
> > > > > +}
> > > >=C2=A0
> > > > What bothers me with this division is the benefit of adding an ex=
tra ultra
> > > > optimized division by 1000 in cpuidle.h while we have already kti=
me_divns
> > > > which is optimized in ktime.h.
> > > It is "optimized" but still much heavier than what is presented abo=
ve as
> > > it provides maximum precision.
> > >=C2=A0
> > > It all depends on how important the performance gain from the origi=
nal
> > > shift by 10 was in the first place.
> > Actually the original shift was there because it was convenient as a=C2=
=A0
> > simple ~div1000 operation. But against all odds, the approximation=C2=
=A0
> > introduced a regression on a very specific use case on PowerPC.
> >=C2=A0
> > We are not in the hot path and I think we can live with a ktime_divns=
=C2=A0
> > without problem. That would simplify the fix I believe.
> >=C2=A0
>=20
> I would tend to agree with this and there are better ways to do
> multiplicative inverses if we care

ktime_divns already does it automatically when applicable.


Nicolas
--8323328-2140905334-1467378140=:12094
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--8323328-2140905334-1467378140=:12094--
