From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/3] PM / OPP: Add "opp-supported-hw" binding
Date: Wed, 4 Nov 2015 14:10:06 -0800
Message-ID: <20151104221006.GT19782@codeaurora.org>
References: <cover.1446167359.git.viresh.kumar@linaro.org>
 <2d52388bd7d3cc546ac3ab5afeb47bfcb3012213.1446167359.git.viresh.kumar@linaro.org>
 <20151030214907.GJ19782@codeaurora.org>
 <20151031021612.GU3716@ubuntu>
 <20151102192144.GQ19782@codeaurora.org>
 <20151103021254.GM3639@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151103021254.GM3639@ubuntu>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/03, Viresh Kumar wrote:
> On 02-11-15, 11:21, Stephen Boyd wrote:
> > Ah I see that after looking at the previous thread. Perhaps we
> > can add such information into the documentation so that people
> > aren't misled into thinking they're limited to 32 bits?
> 
> What about these changes:

Yep looks good. Assuming this is squashed into the original:

Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

One typo below.

> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 96892057586a..b6ca2239838b 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -123,11 +123,15 @@ properties.
>  - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
>    the table should have this.
>  
> -- opp-supported-hw: User defined array containing a hierarchy of hardware
> -  version numbers, supported by the OPP. For example: a platform with hierarchy
> -  of three levels of versions (A, B and C), this field should be like <X Y Z>,
> -  where X corresponds to Version hierarchy A, Y corresponds to version hierarchy
> -  B and Z corresponds to version hierarchy C.
> +- opp-supported-hw: This enables us to select only a subset of OPPs from the
> +  larger OPP table, based on what version of the hardware we are running on. We
> +  still can't have multiple nodes with the same opp-hz value in OPP table.
> +
> +  Its an user defined array containing a hierarchy of hardware version numbers,

s/Its/It's/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
