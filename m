From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Thu, 28 Dec 2017 16:32:53 -0800
Message-ID: <20171229003253.GD7997@codeaurora.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171228043725.GB8652@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12/28, Viresh Kumar wrote:
> On 27-12-17, 15:54, Rob Herring wrote:
> > 
> > I don't really know. I don't really care either. I'll probably go
> > along with what everyone agrees to, but the only one I see any
> > agreement from is Ulf. Also, it is pretty vague as to what platforms
> > will use this. You claimed you can support QCom scenarios, but there's
> > really no evidence that that is true.
> 
> Well, I sent out the code few days back based on these bindings and everyone can
> see how these bindings will get used now.
> 
> > What I don't want to see is this
> > merged and then we need something more yet again in a few months for
> > another platform.
> 
> Sure, I get your concerns.
> 
> So what we need now is:
> 
> - Stephen to start responding and clarify all the doubts he had as being silent
>   isn't helping.

What can I reply to specifically? From what I can tell, the
patches have changed to this 'opp-required' thing in the past
week and the position of 'generic OPP layer interprets magic
values' doesn't look to have changed. Is that the summary? I can
look deeply at the patches tomorrow.

> 
> - Or Rajendra to post patches which can prove that this is usable. The last time
>   I had a chat with him, he confirmed that he will post patches after 4.15-rc1
>   and he should have posted them by now, but he didn't :(
> 

I'd prefer either that, or some tree here that we can look at. I
said this last time, I'm having a really hard time seeing how
everything is going to work. The little drip of code, then DT
binding, then maybe a small change in dts files, then maybe some
code that uses the new APIs, etc. is pretty annoying. From my
perspective you've chopped the problem up into pieces that don't
stand on their own and then started sending patches for some
parts without showing the overall result. It's like we're being
taken on a ride in your development workflow, and we don't get to
see what's coming around the corner, and the only assumption I
can make is that you don't know either.

I'm actually confused how any of the code is even tested or used.
It looks like things are getting merged without any users, for
what exactly I'm not sure. Please, please, get an end-to-end
solution going and actually use the code from day one on a real
device that can use it.

Sorry for the rant, but my inbox keeps filling with patches for
this series and I have no idea what's going on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
