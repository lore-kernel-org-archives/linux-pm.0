From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Tue, 9 May 2017 10:59:21 +0530
Message-ID: <20170509052921.GA15657@vireshk-i7>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
 <20170428204803.plu467okibtxga4d@rob-hp-laptop>
 <a307c76d-72c3-eb84-e7d4-d5e47e2af727@arm.com>
 <20170508071350.GH17010@vireshk-i7>
 <c2651a3c-befd-9288-37ce-2c60afb7a0e2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c2651a3c-befd-9288-37ce-2c60afb7a0e2-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 08-05-17, 14:57, Sudeep Holla wrote:
> Yes, I followed the thread and figured that out. But Rajendra also
> raised "What if the microcontroller firmware maps the performance-index
> to voltage but expects linux to scale the frequency? There is no way to
> specify a performance-index *and* a frequency for a OPP now I guess? So
> this needs to be addressd now IIUC.

No, he misunderstood it. He was saying that the domain needs a performance-index
and the device needs freq-scaling, how do we do that? He thought that there will
be just one OPP table for the device here, but we will actually have two and
that would work.

> So as Kevin pointed out, we need to experiment and look at all
> possibilities before finalizing the bindings. Better to have examples
> for all these and describe how bindings are be used including how to
> distinguish between these use-case from the bindings if it's not implicit.

Yeah, I have some doubts on how we are going to implement that and looking for
more input from him.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
