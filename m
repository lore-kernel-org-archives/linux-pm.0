From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Date: Mon, 14 May 2018 11:18:12 +0200
Message-ID: <1c485c97-f667-7cbd-a6a0-bc74d8aa0918@pengutronix.de>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
 <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
 <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/14/2018 11:10 AM, Anson Huang wrote:
>> -----Original Message-----
>> From: Bastian Stender [mailto:bst@pengutronix.de]
>> Sent: Monday, May 14, 2018 4:37 PM
>> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
>> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> rjw@rjwysocki.net; viresh.kumar@linaro.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Cc: devicetree@vger.kernel.org; linux-pm@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
>>
>> Hi,
>>
>> On 05/14/2018 10:09 AM, Anson Huang wrote:
>>> This patch removes cpufreq cooling registration in thermal .probe
>>> function, cpufreq cooling should be done in cpufreq driver when it is
>>> ready.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>
>> It seems you are trying to achieve something similar to a patch I sent a couple
>> of month ago. Unfortunately I did not have the time to rework it yet:
>>
>>
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
>> work.kernel.org%2Fpatch%2F10059085%2F&data=02%7C01%7Canson.huang
>> %40nxp.com%7C179da3635cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6f
>> a92cd99c5c301635%7C0%7C0%7C636618838508978629&sdata=BcQ9tc%2BE
>> CZ%2Fk4AsZFxshgmvSsPg7eRN0ASzP8LO8yBI%3D&reserved=0
>>
>> Some of the comments might apply here too.
> 
> Ah, I did NOT notice this thread, so how to proceed, will you 
> continue to finish your patch? If yes, then you can just ignore/skip
> my patch, thanks.
Yes, I will revisit the patch in a couple of weeks. It would be nice to
get your feedback then.

Regards,
Bastian	

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
