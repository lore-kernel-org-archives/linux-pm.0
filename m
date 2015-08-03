From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 0/8] ARM64: juno: add SCPI mailbox protocol, clock
 and CPUFreq support
Date: Mon, 03 Aug 2015 11:48:37 +0100
Message-ID: <55BF4705.9030300@arm.com>
References: <1438364591-1144-1-git-send-email-sudeep.holla@arm.com> <20150803101845.GU20890@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52875 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773AbbHCKsm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 06:48:42 -0400
In-Reply-To: <20150803101845.GU20890@e106497-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 03/08/15 11:18, Liviu Dudau wrote:
> On Fri, Jul 31, 2015 at 06:43:03PM +0100, Sudeep Holla wrote:
>> Hi ARM-SoC guys,
>>
>> It has been on the list for a while and have got all the necessary ACKs.
>> Can you please pull this series for v4.3 ?
>>
>> Regards,
>> Sudeep
>>
>> This patch series adds support for:
>>    1. SCPI(System Control and Power Interface) mailbox protocol driver.
>>       It uses ARM MHU mailbox controller driver on Juno but can work with
>>       any mailbox controllers using standard mailbox APIs
>>    2. Add support for clocks provided by SCP firmware through the SCPI
>>       interface
>>    3. Using the existing arm_big_little cpufreq driver and the newly
>>       added SCPI clock driver, it also adds support for CPU DVFS on
>>       ARM64 JUNO development platforms.
>
> Hi Sudeep,
>
> Is there a branch where I can pull this series from?
>

Yes, you can pull from
git://linux-arm.org/linux-skn.git juno_dvfs

Regards,
Sudeep
