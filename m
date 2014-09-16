From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH RESEND] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 16 Sep 2014 10:53:30 +0300
Message-ID: <1410854010.30351.17.camel@iivanov-dev>
References: <1410793383-30097-1-git-send-email-iivanov@mm-sol.com>
	 <54170DA6.6050001@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <54170DA6.6050001@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Georgi Djakov <gdjakov@mm-sol.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-09-15 at 19:02 +0300, Georgi Djakov wrote:

<snip>

> > +Example:
> > +
> > +	thermal-alarm@2400 {
> > +		compatible = "qcom,qpnp-temp-alarm";
> > +		reg = <0x2400>;
> > +		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> > +		label = "pm8941_tz";
> > +		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
> > +		io-channel-names = "thermal";
> > +	};
> 
> Maybe describe the trip points in the DT?

I am not sure. Trip points are not arbitrary selectable. Hardware
have 4 predefined operating modes, if I could say.

0 = {105 C, 125 C, 145 C}
1 = {110 C, 130 C, 150 C}
2 = {115 C, 135 C, 155 C}
3 = {120 C, 140 C, 160 C}

Everything which driver could select is one of 0...3.

Rest of the comments will be fixed in next version.

Thanks,
Ivan
