From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 04/11] ARM: STi: STiH407: Provide generic (safe) DVFS
 configuration
Date: Tue, 8 Dec 2015 15:37:09 +0000
Message-ID: <20151208153709.GA14604@x1>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-5-git-send-email-lee.jones@linaro.org>
 <20151208150340.GI3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151208150340.GI3692@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On Tue, 08 Dec 2015, Viresh Kumar wrote:

> On 08-12-15, 14:31, Lee Jones wrote:
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/=
dts/stih407-family.dtsi
> > index 81f8121..9fa1e58 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -22,15 +22,29 @@
> >  			device_type =3D "cpu";
> >  			compatible =3D "arm,cortex-a9";
> >  			reg =3D <0>;
> > +
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr =3D <0x94100A4>;
> > +
> > +					 /* kHz     uV   */
> > +			operating-points =3D <1500000 0
> > +					    1200000 0
> > +					    800000  0
> > +					    500000  0>;
> >  		};
> >  		cpu@1 {
> >  			device_type =3D "cpu";
> >  			compatible =3D "arm,cortex-a9";
> >  			reg =3D <1>;
> > +
> >  			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> >  			cpu-release-addr =3D <0x94100A4>;
> > +
> > +					 /* kHz     uV   */
> > +			operating-points =3D <1500000 0
> > +					    1200000 0
> > +					    800000  0
> > +					    500000  0>;
>=20
> Why didn't you move to opp-v2 ?
=20
Because we can't guarantee that the system was booted with a
bootloader which supports opp-v2.  This is the fall-back
configuration.  Please continue through the set.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
