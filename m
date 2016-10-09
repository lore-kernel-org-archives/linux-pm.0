From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Sat, 8 Oct 2016 20:29:17 -0500
Message-ID: <20161009012917.GS18158@rob-hp-laptop>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
 <ea6ba87d6514dcec7bee222b401ab904a78e67e6.1475581665.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ea6ba87d6514dcec7bee222b401ab904a78e67e6.1475581665.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 04, 2016 at 05:26:43PM +0530, Viresh Kumar wrote:
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
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
