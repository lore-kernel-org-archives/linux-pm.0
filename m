From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V2 1/8] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Mon, 24 Oct 2016 15:48:52 -0700
Message-ID: <20161024224852.GQ26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <891ef8705e13dff331a3135647f4c18f88402a12.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <891ef8705e13dff331a3135647f4c18f88402a12.1476952750.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 10/20, Viresh Kumar wrote:
> On certain platforms (like TI), DVFS for a single device (CPU) requires
> configuring multiple power supplies.
> 
> The OPP bindings already contains binding and example to explain this
> case, but it isn't sufficient. For example, there is no way for the code
> parsing these bindings to know which voltage values belong to which
> power supply. Also its not possible to know the order in which the
> supplies need to be configured while switching OPPs.
> 
> This patch tries to clarify on those details and does some minor changes
> as well.
> 
> Note that the bindings do not specify the order in which the regulators
> need to be programmed and the order in which the entries are added for
> the supplies.
> 
> The user of the bindings (like the kernel) shall know these details
> already and the DT is responsible to supply only the readings for the
> regulators.
> 
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---

Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
