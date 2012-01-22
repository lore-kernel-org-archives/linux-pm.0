From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Sun, 22 Jan 2012 18:48:36 +0100
Message-ID: <4F1C4BF4.5040409@gmail.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>	<4F1C082D.2080005@gmail.com>	<20120122152234.GA2915@opensource.wolfsonmicro.com>	<4F1C45C6.1040003@gmail.com> <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 01/22/2012 06:27 PM, Bill Gatliff wrote:
> On Sun, Jan 22, 2012 at 6:22 PM, Sylwester Nawrocki
> <sylvester.nawrocki@gmail.com>  wrote:
>> The best solution would be to force platform to enable PM_RUNTIME if 
>> they want to use a driver which does runtime PM. But this has to wait, 
>> yet, probably infinitely.. :)
> 
> Probably easier to motivate platforms to enable PM_RUNTIME if there
> are drivers that require it.  :)
>
> I for one would rather see in-kernel drivers that require it, and then

In fact we have to deal with the opposite now, as some existing drivers
have been used for multiple generations of SoC, where almost unchanged
device IPs are deployed. Those drivers were originally written for the
simplest SoCs.

> patches in mailing lists that show how to un-require it.  Make it more
> painful to avoid PM_RUNTIME, and less painful to use it.

Yeah, makes a lot of sense. With new code there is no issue, only the code
with long history is sort of troublesome.

-- 
Regards,
Sylwester
