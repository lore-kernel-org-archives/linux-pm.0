From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Mon, 17 Dec 2018 14:45:47 -0600
Message-ID: <20181217204547.GA11590@bogus>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
 <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
 <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154476557998.19322.11977618193120872801@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 09:32:59PM -0800, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-13 20:10:23)
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which are
> > controlled by the hardware engine.
> > 
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> except one question below for Rob.
> 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > new file mode 100644
> > index 0000000..33856947
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -0,0 +1,172 @@
> > +Qualcomm Technologies, Inc. CPUFREQ Bindings
> > +
> > +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> > +SoCs to manage frequency in hardware. It is capable of controlling frequency
> > +for multiple clusters.
> > +
> > +Properties:
> > +- compatible
> > +       Usage:          required
> > +       Value type:     <string>
> > +       Definition:     must be "qcom,cpufreq-hw".
> > +
> > +- clocks
> > +       Usage:          required
> > +       Value type:     <phandle> From common clock binding.
> > +       Definition:     clock handle for XO clock and GPLL0 clock.
> > +
> > +- clock-names
> > +       Usage:          required
> > +       Value type:     <string> From common clock binding.
> > +       Definition:     must be "xo", "alternate".
> > +
> > +- reg
> > +       Usage:          required
> > +       Value type:     <prop-encoded-array>
> > +       Definition:     Addresses and sizes for the memory of the HW bases in
> > +                       each frequency domain.
> > +- reg-names
> > +       Usage:          Optional
> > +       Value type:     <string>
> > +       Definition:     Frequency domain name i.e.
> > +                       "freq-domain0", "freq-domain1".
> > +
> > +- #freq-domain-cells:
> 
> I still wonder if this should be #qcom,freq-domain-cells, but if Rob is
> OK I won't complain.

Probably should be. Though I did give my R-by without.

Rob
