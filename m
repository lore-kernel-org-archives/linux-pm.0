From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Tue, 2 Jan 2018 12:03:27 +0530
Message-ID: <20180102063327.GB15166@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <3721988e-fa13-c5dc-9ee6-490ed9b4b767@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3721988e-fa13-c5dc-9ee6-490ed9b4b767-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02-01-18, 11:35, Rajendra Nayak wrote:
> I would want to reiterate what I have been saying for a while, that for these patches
> to be usable on any qualcomm platform completely we need support to associate
> multiple power-domains to a single device which is missing today.

Sure, but I had the understanding based on our last communication that
you are going to go with partial support for now and multiple domain
thing will be done later on.

> What I have been testing with these patches is to move a single user (MMC, which BTW does not
> have to put requests on multiple powerdomains) to use this solution on a db820c (msm8996) device.

Right.

> Getting this merged now can open up issues for other devices (which can't move to this solution)
> since MMC alone would put requests to pull a *common* rail up/down while others can't.

Even on that I thought that you will artificially vote for a high
requirement for those devices from some platform code initially, and
remove that code once all the device drivers (you need) are updated to
post their own requirements.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
