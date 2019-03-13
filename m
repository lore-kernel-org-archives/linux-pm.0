From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 1/2] cpufreq: armada-37xx: fix clock parenting
Date: Wed, 13 Mar 2019 17:39:36 +0100
Message-ID: <87pnquvid3.fsf@FE-laptop>
References: <20190308164710.10597-1-gregory.clement@bootlin.com> <20190308164710.10597-2-gregory.clement@bootlin.com> <20190311053130.qrobxd2wn75nrgbf@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190311053130.qrobxd2wn75nrgbf@vireshk-i7>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Christian Neubert <christian.neubert.86@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,
 
 On lun., mars 11 2019, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 08-03-19, 17:47, Gregory CLEMENT wrote:
[...]

>>  	parent = clk_get_parent(clk);
>> +
>> +	/*
>> +	 * Unset parent clock to force the clock framework setting again
>> +	 * the clock parent
>> +	 */
>> +	clk_set_parent(clk, NULL);
>> +
>> +	/*
>> +	 * For the Armada 37xx CPU clocks, setting the parent will
>> +	 * actually configure the parent when DVFS is enabled. At
>> +	 * hardware level it will be a different register from the one
>> +	 * read when doing clk_get_parent that will be set with
>> +	 * clk_set_parent.
>> +	 */
>>  	clk_set_parent(clk, parent);
>>  }
>
> Maybe this should be done right from the clock driver instead? As cpufreq may or
> maynot be enabled by default (Surely most of the people will always enable it,
> but I am just trying to find the right place for doing this). The way we are
> setting the clock parent isn't that great, and looks a bit hacky just because of
> the way clock framework is. Maybe doing it directly, without getting clock
> framework in between, from the clock driver may look sane ?

I've just sent a patch following your suggestion to the clock mailing
but keeping you in CC too.

Gregory

>
> -- 
> viresh

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
