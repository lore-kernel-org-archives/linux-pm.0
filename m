From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Tue, 28 Jul 2015 08:41:04 +0100
Message-ID: <20150728074104.GL21114@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <20150728022308.GA1229@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35839 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbG1HlJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:41:09 -0400
Received: by wibxm9 with SMTP id xm9so144097960wib.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:41:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150728022308.GA1229@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com

On Tue, 28 Jul 2015, Viresh Kumar wrote:

> On 27-07-15, 16:20, Lee Jones wrote:
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >=20
> > Changelog:
> >  - Using OPP-v2
> >  - Moved (and linked) a bunch of documentation to ../power/
> >=20
> >  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++=
++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufr=
eq-st.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.t=
xt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > new file mode 100644
> > index 0000000..79add9d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > @@ -0,0 +1,40 @@
> > +Binding for ST's CPUFreq driver
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Frequency Scaling only
> > +----------------------
> > +
> > +Located in CPU's node:
> > +
> > +- operating-points		: [See: ../power/opp.txt]
> > +
> > +Example [safe]
> > +--------------
> > +
> > +cpus {
> > +	cpu@0 {
> > +				 /* kHz     uV   */
> > +		operating-points =3D <1500000 0
> > +				    1200000 0
> > +				    800000  0
> > +				    500000  0>;
> > +	};
> > +};
> > +
> > +Dynamic Voltage and Frequency Scaling (DVFS)
> > +--------------------------------------------
> > +
> > +Located in CPU's node:
> > +
> > +- operating-points-v2-sti	: [See ../power/opp-st.txt]
> > +
> > +Example [unsafe]
> > +----------------
> > +
> > +cpus {
> > +	cpu@0 {
> > +		operating-points-v2	=3D <[OPP list phandle]>;
> > +	};
> > +};
> > +
> > +For an example of an OPP list, see ../power/opp-st.txt.
>=20
> I don't think you need this file/patch at all.. It is almost blank an=
d
> doesn't define a binding. And so there is no need to specify this at
> all. Just an OPP binding file is enough.

I have two issues with that.  Firstly, although the driver uses the
OPP API (it also uses the Regulator and Clock API too), it is
fundamentally a CPUFreq driver, so I think it should have a CPUFreq
DT entry.  Secondly, if someone doesn't know the history of the
ST CPUFreq set, they will look here for an accompanying document.  I
personally wouldn't think to look in power/*opp* for a CPUFreq
binding.

Perhaps, as all of the CPUFreq drivers use the OPP API, everything
should be moved to drivers/base/power or drivers/power?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
