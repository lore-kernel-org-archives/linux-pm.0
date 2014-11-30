From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Sun, 30 Nov 2014 12:04:46 -0800
Message-ID: <547B785E.6020404@oracle.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>	<CAKohpomBijLiBgV31ZhZDTctsTLccBZ+93r+esG-WRZAS4sqww@mail.gmail.com>	<54760107.3010205@oracle.com> <CAKohpokLeX+NoD9KX1MWWjyZtu6otw_oryt1f4gwLz7TffcExQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32083 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaK3UFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Nov 2014 15:05:21 -0500
In-Reply-To: <CAKohpokLeX+NoD9KX1MWWjyZtu6otw_oryt1f4gwLz7TffcExQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, Thomas Abraham <ta.omasab@gmail.com>



On 11/26/14 9:14 PM, Viresh Kumar wrote:
> On 26 November 2014 at 22:04, santosh shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> Its really not 'dvfs-method' but really the actual driver which you
>> want to probe. Also we should just have one global way to parse
>> DT vs non-DT cpufreq drivers. In other words, instead of matching
>> multiple driver strings for different drivers, we should come up with
>> slightly generic binding. Probably 'cpufreq-dt' for all DT based probed
>> CPUFREQ drivers.
>>
>> What you say ?
>
> I got a bit confused. :(
>
> The whole purpose of this binding is to select which cpufreq driver to
> choose from the available ones.
>
> Are you saying that we should have only one cpufreq driver that works
> with DT ? I don't think that would be the right decision, but we should
> try to reuse cpufreq-dt wherever possible.
>
I didn't mean one CPUFreq driver which works with DT.

> Or are you saying that some common code should parse this DT information?
Yes.

> This is what I said in the patch, we can write another file which will
> just create
> a platform_device for us, depending on the string that came in.
>
Sounds good.

Regards,
Santosh

