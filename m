From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 08/10] PM / OPP: Allow platform specific custom
 set_opp() callbacks
Date: Thu, 1 Dec 2016 05:57:59 +0530
Message-ID: <20161201002759.GP3288@vireshk-i7>
References: <cover.1480481312.git.viresh.kumar@linaro.org>
 <152e4a2c876449f3e47c206f5120cafdfd48b976.1480481312.git.viresh.kumar@linaro.org>
 <20161130220419.GL6095@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161130220419.GL6095-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, d-gerlach-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 30-11-16, 14:04, Stephen Boyd wrote:
> On 11/30, Viresh Kumar wrote:
> > The generic set_opp() handler isn't sufficient for platforms with
> > complex DVFS.  For example, some TI platforms have multiple regulators
> > for a CPU device. The order in which various supplies need to be
> > programmed is only known to the platform code and its best to leave it
> > to it.
> > 
> > This patch implements APIs to register platform specific set_opp()
> > callback.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Tested-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> > 
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Thanks.

> So this one has the same set/put problem the other APIs has?

Yes.

> Presumably we're going to need to fix and change the API that is
> introduced here. Wouldn't it be better to do that first though?

Returning opp_table is one of the solutions and I am not sure if it is
the best one. I am working on the cleanup series and will modify all
the routine the same way very soon.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
