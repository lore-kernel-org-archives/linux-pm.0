From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/11] pwm: tegra-dfll: Add driver for Tegra DFLL PWM
 controller
Date: Fri, 6 May 2016 16:15:32 -0700
Message-ID: <20160506231532.GK3492@codeaurora.org>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-6-git-send-email-pchiu@nvidia.com>
 <20160422125513.GJ9047@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422125513.GJ9047@ulmo.ba.sec>
Sender: linux-clk-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Penny Chiu <pchiu@nvidia.com>, swarren@wwwdotorg.org, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/22, Thierry Reding wrote:
> On Fri, Apr 22, 2016 at 06:31:05PM +0800, Penny Chiu wrote:
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
> > new file mode 100644
> > index 0000000..bd0d247
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
> > @@ -0,0 +1,48 @@
> > +Tegra SoC DFLL PWM controller
> 
> Stephen, we have in the past used tegra124 in names, even if the IP was
> already included in tegra114, but we never supported it on Tegra114 and
> hence couldn't even verify that the binding was valid. Any preference as
> to the name in this particular case?

You meant Stephen Warren right? I don't care either way.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
