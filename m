From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Fri, 29 Dec 2017 10:28:54 +0530
Message-ID: <20171229045854.GE8652@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171229003253.GD7997@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-12-17, 16:32, Stephen Boyd wrote:
> On 12/28, Viresh Kumar wrote:

> > So what we need now is:
> > 
> > - Stephen to start responding and clarify all the doubts he had as being silent
> >   isn't helping.
> 
> What can I reply to specifically?

I explained in detail how this stuff is going to get used last time you replied.
Did you get a chance to look at that ? What am I supposed to do when you don't
reply back to the clarifications I provide ?

https://marc.info/?l=linux-kernel&m=151202516128980&w=2

> From what I can tell, the
> patches have changed to this 'opp-required' thing in the past
> week and the position of 'generic OPP layer interprets magic
> values' doesn't look to have changed. Is that the summary? I can
> look deeply at the patches tomorrow.

Kind of yeah, because you didn't reply to my explanation on how the magic values
are going to get used and so they never changed. Again, I don't have problems
adding new property for performance-state thing or leave it for the platform,
but I was sticking around the magic values because Kevin was strongly in favor
of that earlier.

> > - Or Rajendra to post patches which can prove that this is usable. The last time
> >   I had a chat with him, he confirmed that he will post patches after 4.15-rc1
> >   and he should have posted them by now, but he didn't :(
> > 
> 
> I'd prefer either that, or some tree here that we can look at.

I am quite sure Rajendra can help here, he had been testing this stuff on *real*
hardware for ages now with me. This is what he shared with me earlier, based on
what we have merged in the kernel today..

https://github.com/rrnayak/linux/commits/genpd-performance-state

> I said this last time, I'm having a really hard time seeing how
> everything is going to work. The little drip of code, then DT
> binding, then maybe a small change in dts files, then maybe some
> code that uses the new APIs, etc. is pretty annoying. From my
> perspective you've chopped the problem up into pieces that don't
> stand on their own and then started sending patches for some
> parts without showing the overall result. It's like we're being
> taken on a ride in your development workflow, and we don't get to
> see what's coming around the corner, and the only assumption I
> can make is that you don't know either.
> 
> I'm actually confused how any of the code is even tested or used.
> It looks like things are getting merged without any users, for
> what exactly I'm not sure. Please, please, get an end-to-end
> solution going and actually use the code from day one on a real
> device that can use it.

There is just too much code, specially Qcom specific, and I can't fit all that
in a single series really. Its going to be more annoying for people to see that.
I used to keep some Qcom test code in the earlier series which got merged and
was told by Rajendra that the Qcom stuff will get posted after 4.15-rc1, but
that didn't happen. I can't post final code for that as it touches lots of
things and its Qcom who needs to upstream it. Now how much test code can I keep
supplying every time ?

I have already posted the code that will use these bindings few days back:

https://lkml.kernel.org/r/cover.1513926033.git.viresh.kumar@linaro.org

The only missing part left now (after bindings and above series) is, again,
platform specific Qcom code to use it. Below is some dummy code to complete the
story for you:

DT changes that shows two devices, mmc and dsp, using the performances states of
domain:

		foo: foo-power-domain@09000000 {
			compatible = "foo,genpd";
			#power-domain-cells = <0>;
			operating-points-v2 = <&domain_opp_table>;
		};

	        domain_opp_table: domain_opp_table {
	        	compatible = "operating-points-v2";

	        	domain_opp_1: opp00 {
	        		opp-hz = /bits/ 64 <1>; //This is performances state
	        	};
	        	domain_opp_2: opp01 {
	        		opp-hz = /bits/ 64 <2>;
	        	};
	        	domain_opp_3: opp02 {
	        		opp-hz = /bits/ 64 <3>;
	        	};
	        };

		mmc@f7112000 {
			compatible = "***";

                        ***


                        power-domains = <&foo>;
			operating-points-v2 = <&mmc_opp_table>;
		};


        	mmc_opp_table: mmc-opp-table {
        		compatible = "operating-points-v2";
        		opp-shared;
        
        		opp00 {
        			opp-hz = /bits/ 64 <208000000>;
        			required-opp = <&domain_opp_1>;
        		};
        		opp01 {
        			opp-hz = /bits/ 64 <432000000>;
        			required-opp = <&domain_opp_2>;
        		};
        		opp02 {
        			opp-hz = /bits/ 64 <729000000>;
        			required-opp = <&domain_opp_2>;
        		};
        		opp03 {
        			opp-hz = /bits/ 64 <960000000>;
        			required-opp = <&domain_opp_3>;
        		};
        	};

		dsp@f8152000 {
			compatible = "***";

                        ***


                        power-domains = <&foo>;
                        required-opp = <&domain_opp_2>;
		};




Platform specific power domain driver:

static int foo_set_performance(struct generic_pm_domain *genpd,
                               unsigned int state)
{
        /* Set the state here */

	return 0;
}

static unsigned int foo_get_performance(struct generic_pm_domain *genpd,
			                struct dev_pm_opp *opp)
{
        /*
         * Simply return freq value as we passed the state in opp-hz.
         *
         * If we choose to use platform-specific bindings instead of opp-hz,
         * then only this routine requires to change to read the DT and provide
         * the value from platform specific binding.
         */
	return dev_pm_opp_get_freq(opp);
}

static const struct of_device_id pm_domain_of_match[] __initconst = {
	{
		.compatible = "foo,genpd",
	},
	{ },
};

static int __init genpd_foo_init(void)
{
	struct device_node *np;
	struct generic_pm_domain *pd;

	for_each_matching_node_and_match(np, pm_domain_of_match, NULL) {
		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
		if (!pd)
			return -ENOMEM;

		pd->name = kstrdup_const(np->full_name, GFP_KERNEL);
		if (!pd->name) {
			of_node_put(np);
			return -ENOMEM;
		}

                ...

		pd->set_performance_state = foo_set_performance;
		pd->get_performance_state = foo_get_performance;

		pm_genpd_init(pd, NULL, false);
		of_genpd_add_provider_simple(np, pd);
	}


	return dev_pm_domain_attach(dev, false);
}
device_initcall(genpd_foo_init);


There is nothing left after this from my end for performance-state stuff. That's
all.

I don't mind rant from any of you or others (we are all good friends after all),
but please please provide feedback. Its going to waste more time if you don't
reply :)

Hope you have a very happy new year !!

--
viresh
