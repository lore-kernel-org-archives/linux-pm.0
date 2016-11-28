From: Andreas Ziegler <andreas.ziegler@fau.de>
Subject: Re: [PATCH v3] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Mon, 28 Nov 2016 10:33:28 +0100
Message-ID: <19fea35d-98de-2367-96c8-101d34aa93d8@fau.de>
References: <5995ce7b-6a00-8944-a8b9-b256abf4d92e@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5995ce7b-6a00-8944-a8b9-b256abf4d92e@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Forgot to CC linux-kernel and linux-pm in my first message.

On 11/28/2016 10:28, Andreas Ziegler wrote:
> Hi Markus,
> 
> your patch "cpufreq: brcmstb-cpufreq: CPUfreq driver for older Broadcom STB
> SoCs" showed up in linux-next today, and I noticed a small error in it.
> 
> In drivers/cpufreq/brcmstb-cpufreq.c, line 214 there is an IS_ENABLED()
> statement with CONFIG_ARM_BRCM_AVS_CPUFREQ. This symbol, however, does not exist
> - making the if condition always evaluate to false. Did you mean to use
> CONFIG_ARM_BRCMSTB_AVS_CPUFREQ (note the STB after BRCM)?
> 
> I noticed this mistake by running 'scripts/checkkconfigsymbols -f --force -f
> next-20161124..next-20161128', which essentialy diffs the last two
> linux-next releases and looks for undefined/unknown Kconfig symbols.
> You can also run the script on single commits with -c to test them.
> 
> Best regards,
> 
> Andreas
> 
