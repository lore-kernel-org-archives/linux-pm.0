From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Mon, 8 Oct 2018 12:38:56 +0200
Message-ID: <20181008103856.GA10890@centauri.lan>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181008084012.GA23693@centauri.lan>
 <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008095952.gl7di2tnuv3jwew6@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 08, 2018 at 03:29:52PM +0530, Viresh Kumar wrote:
> On 08-10-18, 10:40, Niklas Cassel wrote:
> > > +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> > > +				"#freq-domain-cells", 0, &args);
> > 
> > Hello Taniya,
> > 
> > in your DT binding, you use
> > 
> > #freq-domains-cells = <1>
> > 
> > Yet here you parse for "#freq-domain-cells".
> 
> And what is the problem with that ? Or are you suggesting her to call
> of_parse_phandle_with_fixed_args() ?

Hello Viresh,

#freq-domain-cells != #freq-domains-cells

The code should parse for the exact same property name as stated in the
DT binding.

Kind regards,
Niklas
