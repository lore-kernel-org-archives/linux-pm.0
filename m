From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 09:30:41 +0100
Message-ID: <20150728083041.GL14943@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux>
 <20150728073439.GK21114@x1>
 <20150728074709.GA13710@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728074709.GA13710@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rob.herring@linaro.org, nm@ti.com, arnd.bergmann@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Jul 2015, Viresh Kumar wrote:

> On 28-07-15, 08:34, Lee Jones wrote:
> > I disagree.  For one, only 'opp-hz' is defined in ./opp.tx.  Second=
ly
>=20
> There are other properties in op.txt like turbo, opp-suspend, latency=
,
> etc.. which can be useful for your platform to. Its not used for now
> is a different thing.
>=20
> > it would be annoying to have to have to keep jumping between docume=
nts
> > to obtain the whole picture.  Finally, generic bindings are repeate=
d
> > in platform/device specific documentation all the time.  Grep for
> > 'clocks' or 'regulator-* or 'interrupts' or 'reg' or 'clock-frequen=
cy'
>=20
> Yeah, I agree. I am not against that. What I meant to say was that it=
s
> an extension to opp-v2. So whatever is present in opp-v2 can be used
> by ST's driver, without mentioning that here as well.
>=20
> > (which IMHO I think you should have used instead of 'opp-hz', but
> > that's by the by), or any number of other generic properties.
>=20
> Hmm, probably yes. See I don't know everything :)
>=20
> > > @Rob/Stephen: Please respond before it is late :)
> >=20
> > No one knows this stuff better than you.  If you can't think of an
> > already existing binding that could suit to portray our 'cuts' and
> > 'substrate' information (with a similar way to support our "all cut=
s"
> > and "all substrates" options, then there probably isn't one. ;)
>=20
> Oh, I wasn't saying that there is an existing binding for supporting
> your case. But if we want to move the cuts property to the generic
> bindings so that others can use it. :)

Okay, so what are we waiting for before you'd be prepared to Ack the
binding?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
