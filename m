From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
Date: Tue, 28 Jul 2015 09:55:25 +0100
Message-ID: <20150728085525.GQ14943@x1>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <20150728083513.GA26276@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150728083513.GA26276@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rob.herring@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com, sre@kernel.org, dbaryshkov@gmail.com
List-Id: linux-pm@vger.kernel.org

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
>=20
> For both patches:
>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

W00t!  I'll start fixing up the driver.

> But I would like Rob to have a look as well :)

No problem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
