From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: Re: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank cpufreq
Date: Wed, 28 Nov 2012 07:16:12 -0600
Message-ID: <50B60E9C.9000405@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com> <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com> <20121128023240.GA28170@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121128023240.GA28170@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On 11/27/2012 08:32 PM, Shawn Guo wrote:
> On Tue, Nov 27, 2012 at 02:04:32PM -0600, Mark Langsdorf wrote:
>> Highbank processors depend on the external ECME to perform voltage
>> management based on a requested frequency. Communication between the
>> A9 cores and the ECME happens over the pl320 IPC channel.
> 
> ...
> 
>> +static int hb_voltage_change(unsigned int freq)
>> +{
>> +	int i;
>> +	u32 msg[7];
>> +
>> +	msg[0] = HB_CPUFREQ_CHANGE_NOTE;
>> +	msg[1] = freq / 1000;
>> +	for (i = 2; i < 7; i++)
>> +		msg[i] = 0;
>> +
>> +	return pl320_ipc_transmit(msg);
> 
> Is it possible to have this handled inside clk_set_rate() call of cpu
> clock?

Standard practice is to have cpufreq_set_target() handle voltage
transitions and leave clk_set_rate() handle the frequency changes. I'd
have to move most of the logic of hb_set_target() into
clk_highbank.c:clk_pll_set_rate() and then add extra logic for when
cpufreq is not enabled/loaded. I don't think the clk maintainers would
take that patch, either.

So no.

--Mark Langsdorf
Calxeda, Inc.
