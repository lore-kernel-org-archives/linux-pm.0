From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Fri, 28 Apr 2017 16:42:36 +0530
Message-ID: <20170428111236.GG21517@vireshk-i7>
References: <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
 <9019aebe-95ba-b1b8-65a9-5be927934218@codeaurora.org>
 <20170428050029.GD21517@vireshk-i7>
 <b3f5b62c-9423-98e4-d366-78186ab02fb9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b3f5b62c-9423-98e4-d366-78186ab02fb9-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 28-04-17, 10:44, Sudeep Holla wrote:
> Just thinking out loud, I can see platforms with have OPPs can move to
> this binding in future eliminating the need to specify the clock and
> regulators explicitly. So, I am not saying I against this idea, but I
> see it might complicate the above case in terms of the precedence that
> we consider in DT from backward compatibility.
> 
> E.g. if you now use this for just regulators, then I assume you continue
> to use clocks. However, that makes it difficult for platforms
> implementing *real* OPPs to reuse this binding as they may expect to
> skip clock altogether.
> 
> Also we may need OPPs(both volt/freq), voltage only and clock only
> bindings though all 3 are driven by the firmware and all are at abstract
> levels. I am trying to broaden the scope now without having to churn
> this binding again in near future.
> 
> So I don't totally agree that voltage regulators much have *real*
> voltages and not abstract scale. Yes the correct bindings might have
> such restrictions but can't we extend it ?
> 
> Anyways these are just my opinion.

Everyone's opinion has equal merit here :)

I believe that some of your hesitation came from the point that I have
made opp-hz optional. That isn't the case anymore with V6.

Can we please take the discussion to that thread now and see if you
can find similar problems there as well.

Thanks a lot.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
