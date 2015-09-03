From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/9] clk: qcom: gcc-msm8960: add child devices support.
Date: Thu, 3 Sep 2015 10:27:43 -0700
Message-ID: <20150903172743.GE15099@codeaurora.org>
References: <1436348838-22671-1-git-send-email-rnayak@codeaurora.org>
 <1436348838-22671-6-git-send-email-rnayak@codeaurora.org>
 <20150811224902.GO2839@codeaurora.org>
 <55CB0B26.2020105@linaro.org>
 <55CC1CFE.7000005@codeaurora.org>
 <20150814004206.GU26614@codeaurora.org>
 <55CD5BD2.3070907@codeaurora.org>
 <55E660F6.3020007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E660F6.3020007@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, lina.iyer@linaro.org, nrajan@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/02, Rajendra Nayak wrote:
> Stephen,
> 
> >>>>>Also, I don't like having a subnode in DT. Why can't we use the
> >>>>>same node as the GCC node and create a virtual child device here
> >>>>>for tsens? We can assign the same of_node that this platform
> >>>>>device has so that DT keeps working correctly.
> >>>
> >>>So the current driver looks up data based on compatible strings.
> >>
> >>The tsens device is always the same piece of hardware. The only
> >
> >Well, not always. The one in 8960 does need additional initializations,
> >requires you to save/restore context as it can be powered off
> >not being in an always powered on domain etc.
> >
> >>thing that's changing is the qfprom data and the number of
> >>sensors. So we should be looking at the qfprom compatible string
> >
> >How? Tsens uses nvmem framework apis to read the qfprom atleast
> >in this series.
> >
> >>to figure out how to interpret the qfprom data which would
> >>include the number of sensors and how the data is encoded.
> >>
> >>>So you suggesting to create a virtual child device for gcc and
> >>>associate the gcc DT node to it? (And have the tsens compatible
> >>>mentioned as part of the gcc DT node?)
> >>
> >>No. The driver should work just fine without having to
> >>interrogate the device's compatible string. If we still need the
> >>compatible check for some reason, then we can always match based
> >>on qcom,gcc-msm8960, qcom,gcc-apq8064, etc. But I don't see why
> >
> >Thats not quite possible I guess. 2 drivers (gcc and tsens) matching
> >the same compatibles? Will it not just depend on which ends up being
> >the first match?
> 
> Any thoughts on how to move forward with this?
> 
> I tried what you were suggesting, and here's what I had to do to get
> things working
> 
> * Created a gcc node in DT with gcc and tsens compatibles, with gcc and
> tsens properties

This is not what I had in mind. This is what's should be in DT

 clock-controller@f000 {
 	compatible = "qcom,gcc-msm8916";
	reg = <0xf000 ...>;
	....
 };

> * gcc driver probes the device/node first given gcc is registered with
> a core_initcall()
> * creates a virtual child device attaching the same of_node (having
> both gcc and tsens compatibles)
> * gcc ends up probing the virtual device/node _again_ (due to the gcc
> compatible match), fails
> * At a later point, tsens driver gets registered (using module_initcall)
> ends up probing the virtual child node and succeeds

Yeah this might happen though because we've assigned the of_node
pointer to the tsens device before we register it on the platform
bus. The other way to pass that data down from gcc to tsens would
be to not have an of_node assigned to the tsens device, and check
for that case in the tsens driver. If there isn't an of_node,
then we look at the parent device's of_node to figure out which
gcc it is (if this even matters) and parse DT properties.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
