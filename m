From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: Interconnect device-tree bindings
 draft
Date: Thu, 29 Jun 2017 16:32:47 -0500
Message-ID: <20170629213247.qk54ocaomcz42gn7@rob-hp-laptop>
References: <20170627174903.27978-1-georgi.djakov@linaro.org>
 <20170627174903.27978-4-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170627174903.27978-4-georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, skannan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, seansw-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org, davidai-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 27, 2017 at 08:49:03PM +0300, Georgi Djakov wrote:
> The interconnect API is not yet using DT bindings for expressing
> the relations between the API consumers and providers. This is
> posted a separate patch as it needs further discussions on how
> to represent this with DT.

I would recommend continuing to sort out how this works within the 
kernel before fixing things in DT. Something like this needs to be a 
core binding in the DT spec.

Also, you should CC some ARM, Ltd. folks like Mark R and Lorenzo. 
There's been some discussion in the past how to describe the DMA master 
side of the bus topology.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
