From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 7/7] ARM: ZTE: Use - instead of @ for DT OPP entries
Date: Wed, 3 May 2017 21:42:54 +0800
Message-ID: <20170503134252.GA24745@dragon>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <5534c08d8b452c8ce623d3e465603d94afd82ed4.1492685450.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5534c08d8b452c8ce623d3e465603d94afd82ed4.1492685450.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 04:25:11PM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Reported-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> Suggested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Changed the subject prefix to 'arm64: dts: zte: ', and applied the
patch.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
