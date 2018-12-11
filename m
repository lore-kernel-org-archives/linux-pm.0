From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Date: Tue, 11 Dec 2018 16:57:22 +0530
Message-ID: <20181211112722.vu2zrpcdw3ez3kag@vireshk-i7>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
 <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
 <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-12-18, 09:49, Quentin Perret wrote:
> So, on Juno we do get voltage numbers from firmware, and those get
> registered properly in PM_OPP, exactly like for Hikey960. So it's
> probably the same problem in both cases.
> 
> FWIW, this is what I get on juno with my 'fix' applied:
> 
>   $ cat /sys/kernel/debug/opp/cpu0/*/supply-0/u_volt_target
>   820000
>   850000
>   900000
>   950000
>   1000000
> 
> > Anyway, this should still be fixed irrespective of the "cpu-supply" property.
> > The other fix you mentioned about setting opp_table->regulator_count to 1 is
> > actually the right thing to do but the fix may require changes at multiple
> > places. I can help writing a patch for that if you want, else I am open to you
> > giving it a shot :)
> 
> You'll definitely know the code better than me so if you have a patch in
> mind, please don't hesitate. I'll be happy to test it on my two boards
> here :-)

Sent some patches, please give them a try.

-- 
viresh
