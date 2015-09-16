From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 16 Sep 2015 07:52:46 +0100
Message-ID: <20150916065246.GA3218@x1>
References: <20150909075930.GB3260@x1>
 <20150909083031.GB5266@linux>
 <20150909133930.GE3260@x1>
 <20150909160212.GJ5266@linux>
 <20150909163620.GF3260@x1>
 <55F0C5AB.5060609@kernel.org>
 <20150910005722.GA15099@codeaurora.org>
 <20150910010426.GM5266@linux>
 <20150910083146.GG3260@x1>
 <20150916043328.GA29943@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150916043328.GA29943@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Sep 2015, Viresh Kumar wrote:

> On 10-09-15, 09:31, Lee Jones wrote:
> > I think you answered your own question.
> >=20
> > No users =3D=3D !ABI =3D=3D Strip it out.
>=20
> Okay, as I have delayed things enough for you, didn't wanted to do
> that anymore. And so worked on it despite very tight schedule :)
>=20
> Below is the refreshed binding changes (I have split that into 3
> patches, but kept the diff here for simplicity).
>=20
> Other than that, all code changes you need to test your driver are
> pushed here:
>=20
> https://git.linaro.org/people/viresh.kumar/linux.git opp/supported-hw=
-prop-name-v1
>=20
> I am not gonna post the patches to the lists, until the time existing
> patches get reviewed.

Thanks dude.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
