From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Mon, 24 Sep 2018 16:45:58 +0200
Message-ID: <87lg7reyxl.fsf@bootlin.com>
References: <20180921154326.10776-1-gregory.clement@bootlin.com>
 <20180921154326.10776-2-gregory.clement@bootlin.com>
 <20180922142838.6bde6b9c@windsurf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180922142838.6bde6b9c@windsurf> (Thomas Petazzoni's message of
 "Sat, 22 Sep 2018 14:28:38 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Viresh Kumar <viresh.kumar@linaro.org>, Hanna Hawa <hannah@marvell.com>, Omri Itach <omrii@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Thomas,
 
 On sam., sept. 22 2018, Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

[...]
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct device *cpu_dev = get_cpu_device(cpu);
>> +		struct clk *clk = clk_get(cpu_dev, 0);
>> +
>> +		if (IS_ERR(clk))
>> +			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
>> +
>> +		if (clk_is_match(clk, cur_clk))
>
> Is it OK to call clk_is_match() is clk being an error ?
>

yes the function check the validity of the pointers.

[...]

> Once again, this is not a full review, I haven't reviewed the logic of
> the driver itself, just a few obvious things I noticed.

Thanks for this first level review, I took into account all your remarks.

Gregory


>
> Best regards,
>
> Thomas Petazzoni
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
