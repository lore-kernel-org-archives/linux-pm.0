From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Mon, 20 Oct 2014 16:18:10 +0200
Message-ID: <544519A2.8010604@gmail.com>
References: <1413805281-6269-1-git-send-email-thomas.ab@samsung.com>	<5444F38A.1000101@gmail.com>
 <CAJuA9ajv_e0FriiPL0aHWLv7+AoZAF2E+G-0r6UGC6RzxM_wmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJuA9ajv_e0FriiPL0aHWLv7+AoZAF2E+G-0r6UGC6RzxM_wmA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org



On 20.10.2014 13:48, Thomas Abraham wrote:
> Hi Tomasz,
> 
> On Mon, Oct 20, 2014 at 5:05 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> On 20.10.2014 13:41, Thomas Abraham wrote:
>>> Changes since v10:
>>> - Rebased on top of v3.18-rc1
>>>
>>> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
>>> drivers and enables the use of cpufreq-dt driver for these platforms. This
>>> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
>>> driver.
>>>
>>> This patch series is based and tested on v3.18-rc1 and depends on the patch
>>> - "clk: exynos4: remove duplicate div_core2 divider clock instantiation"
>>>   (http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html)
>>>   This patch has been merged in "arm-soc/samsung/dt3" branch of arm-soc tree.
>>>
>>
>> That patch actually went through clock tree, but it doesn't matter,
>> because AFAIK all the dependencies for this series are already in
>> 3.18-rc1. I'll try to apply it in next days
> 
> Thanks. The patch "clk: exynos4: remove duplicate div_core2 divider
> clock instantiation" is not available in 3.18-rc1. So for testing, I
> picked this patch from samsung/dt3 branch from arm-soc tree.

Hmm? I can see it there:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/clk/samsung?id=v3.18-rc1

Best regards,
Tomasz
