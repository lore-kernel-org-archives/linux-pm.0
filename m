From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 4/4] power: ds2760_battery: add device tree glue
Date: Thu, 28 Jun 2018 14:39:00 +0200
Message-ID: <cceb2363-9976-3f62-24f3-03022b0cdec5@zonque.org>
References: <20180628075540.1757-1-daniel@zonque.org>
 <20180628075540.1757-5-daniel@zonque.org>
 <20180628115246.6qqa3nwxwx2qpls6@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628115246.6qqa3nwxwx2qpls6@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Thursday, June 28, 2018 01:52 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 09:55:40AM +0200, Daniel Mack wrote:
>> The w1 slave device used by this driver now has a of_node in case it
>> was matched against a devicetree sub-node of the bus master. This can
>> now be passed down to the power supply core which will parse more
>> properties from the node, such as 'power-supplies'.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
> 
> Thanks for the patch series. Having proper DT support is a nice
> addition. But instead of extending the platform device hack, please
> merge the w1 driver into ds2760_battery.c as it happened to the
> bq27000 driver already. The intermediate platform device is completly
> useless and only makes things more complicated.
> 
> Basically move all code from w1_ds2760.c into ds2760_battery.c,
> drop some EXPORT_SYMBOL and make functions static instead. Then
> move content from probe/remove function into add_slave/remove_slave
> callbacks and drop all platform device things.

Okay, yes, that makes sense. I never understood why there are multiple 
drivers for this.


Thanks,
Daniel
