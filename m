From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Thu, 13 Aug 2015 17:46:02 -0700
Message-ID: <20150814004602.GV26614@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
 <20150811224902.GO2839@codeaurora.org>
 <20150812201855.GF13472@usrtlx11787.corpusers.net>
 <55CBC14B.8000509@codeaurora.org>
 <20150813041402.GI13472@usrtlx11787.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150813041402.GI13472@usrtlx11787.corpusers.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "nrajan@codeaurora.org" <nrajan@codeaurora.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 08/12, Bjorn Andersson wrote:
> On Wed 12 Aug 14:57 PDT 2015, Stephen Boyd wrote:
> 
> > Here's the patch I'm suggesting. The device name is probably wrong, but 
> > you get the idea.
> 
> Looks very much like my take on it as well, I do however have concerns
> that suddenly the node called "clock-controller" will have to come with
> tsens related properties.
> 
> Are all the tsens-in-gcc blocks the same?

Yes they're all the same, except some of them have more sensors
than others. It depends on what SoC the hardware is instantiated
in. They also messed up the software interface and had to add
discontinuous registers for the sensors because it was never
designed to have more than 4 sensors or something like that. But
even that sort of change can be handled by figuring out the
format of the sensor data in the qfprom.

> Or do you intend to of_match
> on the gcc compatible in the tsens driver?
> 

I hope we don't have to of_match in the tsens driver on gcc
compatible strings.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
