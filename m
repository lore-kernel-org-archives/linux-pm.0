From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v11 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware
 bindings
Date: Mon, 03 Dec 2018 15:57:53 -0800
Message-ID: <154388147333.88331.17115812518434146640@swboyd.mtv.corp.google.com>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-2-git-send-email-tdas@codeaurora.org>
 <20181203230907.GA17086@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203230907.GA17086@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Quoting Rob Herring (2018-12-03 15:09:07)
> On Sun, Dec 02, 2018 at 09:25:02AM +0530, Taniya Das wrote:
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which=
 are
> > controlled by the hardware engine.
> > =

> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++=
++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-q=
com-hw.txt
> > =

> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.=
txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > new file mode 100644
> > index 0000000..2b82965
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -0,0 +1,172 @@
> > +Qualcomm Technologies, Inc. CPUFREQ Bindings
> > +
> > +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, In=
c. (QTI)
> > +SoCs to manage frequency in hardware. It is capable of controlling fre=
quency
> > +for multiple clusters.
> > +
> > +Properties:
> > +- compatible
> > +     Usage:          required
> > +     Value type:     <string>
> > +     Definition:     must be "qcom,cpufreq-hw".
> > +
> > +- clocks
> > +     Usage:          required
> > +     Value type:     <phandle> From common clock binding.
> > +     Definition:     clock handle for XO clock and GPLL0 clock.
> > +
> > +- clock-names
> > +     Usage:          required
> > +     Value type:     <string> From common clock binding.
> > +     Definition:     must be "xo", "alternate".
> > +
> > +- reg
> > +     Usage:          required
> > +     Value type:     <prop-encoded-array>
> > +     Definition:     Addresses and sizes for the memory of the HW base=
s in
> > +                     each frequency domain.
> > +- reg-names
> > +     Usage:          Optional
> > +     Value type:     <string>
> > +     Definition:     Frequency domain name i.e.
> > +                     "freq-domain0", "freq-domain1".
> > +
> > +- freq-domain-cells:
> =

> #freq-domain-cells
> =

> Otherwise,
> =

> Reviewed-by: Rob Herring <robh@kernel.org>

Or should it be #qcom,freq-domain-cells? That would match the same stem
of the property used in the cpu node.
