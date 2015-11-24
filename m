From: Bai Ping <b51503@freescale.com>
Subject: Re: [PATCH] cpufreq: imx: Add cpufreq driver for imx7D/Solo SOC
Date: Tue, 24 Nov 2015 15:35:22 +0800
Message-ID: <5654133A.6010506@freescale.com>
References: <1448287669-3600-1-git-send-email-b51503@freescale.com>
 <1448271626.3689.7.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bn0104.outbound.protection.outlook.com ([157.56.110.104]:22164
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751470AbbKXHum (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 24 Nov 2015 02:50:42 -0500
In-Reply-To: <1448271626.3689.7.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 2015/11/23 17:40, Lucas Stach wrote:
> Am Montag, den 23.11.2015, 22:07 +0800 schrieb Bai Ping:
>> The i.MX7Dual/Solo is a new series of the i.MX SOC family.
>> The existing cpufreq driver for 'i.MX6' or 'cpufreq-dt' can
>> NOT match the requirement of this new SOC. This patch adds the
>> cpufreq driver for i.MX7Dual/Solo.
>>
> So, what are those requirements, which could not be matched with
> cpufreq-dt? We should really try to not add another cpufreq driver.
the requirement is the PLL1 used to source the CPU core clock can NOT 
change frequency on the fly,
during the PLL1 frequency change, not clock output from this PLL1 in a 
short time. this will lead to glitch
to the core clock. so before we change the PLL1's frequency, we must 
switch the CPU core clock to another
clock source,  after the PLL1 frequency has been changed, we switch back 
core clock to PLL1.
> I don't see anything special in here. A single regulator and some clocks
> needing to be controlled in the right way. That's already handled for
> i.MX5 with cpufreq-dt. Please look up how it is done there and try to do
> it the same way for MX7, or provide substantial information why it
> couldn't be done.
I have checked the i.MX5 cpufreq, As on i.MX5, no need to take care of 
the PLL's frequency change flow,
so the cpufreq-dt is the best one to support cpufreq. But on i.MX7, the 
PLL design is not the same as on i.MX5,
additional steps needed in CPU frequency changing flow. the issue that 
can NOT be tackled by cpufreq-dt is
additional step used by PLL frequency change.

BR Jacky Bai
>
> Regards,
> Lucas

