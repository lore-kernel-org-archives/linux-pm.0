From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 11 Aug 2015 14:27:57 +0100
Message-ID: <20150811132756.GG18282@x1>
References: <20150730084634.GD9319@x1>
 <CAL_JsqKQLQ15qSt95zBZykzzPhcUrtZzhk29a76n+r_3719AiA@mail.gmail.com>
 <20150731163715.GV3159@codeaurora.org>
 <20150803034642.GV899@linux>
 <20150810132247.GH3249@x1>
 <20150811080023.GB5509@linux>
 <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux>
 <20150811115425.GE18282@x1>
 <20150811120124.GH5509@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811120124.GH5509@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robherring2@gmail.com>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 11 Aug 2015, Viresh Kumar wrote:
> On 11-08-15, 12:54, Lee Jones wrote:
> > The framework does not need to parse this information.  It is used
> > solely by the platform driver, whose job it is to decide which OPPs
> > are appropriate for the running platform.
>=20
> The OPP layer needs to parse OPP nodes in DT. But for doing that it
> needs to know which OPPs to pick from the table as, in cases like
> yours or qcom, not all OPPs might be available.
>=20
> One of the ways to do that is:
> - the platform reads its efuses (or whatever) and encodes the
>   information into a string.
> - This string should match with the strings present (somewhere) in th=
e
>   OPP table. That location can be like what I proposed few mails back=
=2E
> - Then the *generic* OPP code can parse only those OPP nodes which
>   match with that string.
>=20
> This way, we can avoid pushing the platform code to parse OPP tables.

Okay, so what you're saying is that you've already made the decision
to create a separate node for every OPP permutation, despite the fact
that I've told you this could lead to more nodes than anyone would
care to successfully write or maintain?

Perhaps an example might help explain the issue.

Using the current driver, we need to place the following in DT and the
driver does the rest:

opp-list {
	opp1 {
		opp-hz =3D <1500000000>;
		st,avs =3D <1200 1200 1200 1200 1170 1140 1100 1070>;
		st,substrate =3D <0xff>;
		st,cuts =3D <0xff>;
	};
	opp0 {
		opp-hz =3D <1200000000>;
		st,avs =3D <1110 1150 1100 1080 1040 1020 980 930>;
		st,substrate =3D <0xff>;
		st,cuts =3D <0x2>;
	};
};

However, what you're suggesting, even for this very simple example
(imagine what this would look like with 5 or more frequencies where
two or more of them were only appropriate to run on particular
variants) requires this to be broken out to:

opp-list {
	pcode0-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1110000>;
		};
	};

	pcode0-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1200000>;
		};
	};

	pcode1-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1150000>;
		};
	};

	pcode1-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1200000>;
		};
	};

	pcode2-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1100000>;
		};
	};

	pcode2-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1200000>;
		};
	};

	pcode3-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1080000>;
		};
	};

	pcode3-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1200000>;
		};
	};

	pcode4-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1040000>;
		};

	pcode4-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1170000>;
		};
	};

	pcode5-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <1020000>;
		};
	};

	pcode5-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1140000>;
		};
	};

	pcode6-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <980000>;
		};
	};

	pcode6-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1100000>;
		};
	};

	pcode7-cut2-allsubstrates {
		opp0 {
			opp-hz =3D <1200000000>;
			opp-microvolt =3D <930000>;
		};
	};

	pcode7-allcuts-allsubstrates {
		opp0 {
			opp-hz =3D <1500000000>;
			opp-microvolt =3D <1070000>;
		};
	};
};


These will soon multiply once you start providing more complex
examples.  And how do you plan on handling this in the framework?  Can
the driver submit more than one variations of the string?  In the
current example the driver would need to submit four strings to
provide all acceptable variations; "pcodeX-cutY-substrateZ",
"pcodeX-allcuts-substrateZ", "pcodeX-cutY-allsubstrates" and
"pcodeX-allcuts-allsubstrates"

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
