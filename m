From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Mon, 23 Jan 2012 21:19:31 +0100
Message-ID: <4F1DC0D3.4070408@gmail.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4F1C082D.2080005@gmail.com> <20120122152234.GA2915@opensource.wolfsonmicro.com> <4F1C45C6.1040003@gmail.com> <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com> <4F1C4BF4.5040409@gmail.com> <20120122213952.GA29022@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120122213952.GA29022@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 01/22/2012 10:39 PM, Mark Brown wrote:
> On Sun, Jan 22, 2012 at 06:48:36PM +0100, Sylwester Nawrocki wrote:
>> On 01/22/2012 06:27 PM, Bill Gatliff wrote:
> 
>>> I for one would rather see in-kernel drivers that require it, and then
> 
>> In fact we have to deal with the opposite now, as some existing drivers
>> have been used for multiple generations of SoC, where almost unchanged
>> device IPs are deployed. Those drivers were originally written for the
>> simplest SoCs.
> 
> TBH I think most of the devices for which people are running these days
> will be able to get some win from the system wide stuff - the WFI modes
> aren't exactly the latest thing in hardware terms, it's just been a long
> road to getting them supported.  Infrastructure like Mark's PM QoS work
> and Raphael's PM domains work has really helped a lot here.

Indeed, now that I checked some earliest SoC TRMs even the simplest systems
have some sort of intermediate Idle states.

>>> patches in mailing lists that show how to un-require it.  Make it more
>>> painful to avoid PM_RUNTIME, and less painful to use it.
> 
>> Yeah, makes a lot of sense. With new code there is no issue, only the code
>> with long history is sort of troublesome.
> 
> It's mostly a transition management issue I think.  When I repost I'll
> add an additional patch on top which moves the clock gating into the
> runtime PM callbacks, that way the decision on that doesn't block the
> system wide work.

Sounds like a great resolution to the problem, thanks for considering it.
And sorry for disturbing. Let's see what's Kukjin's opinion on that.
