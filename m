From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP, clock and
 regulator supply properties
Date: Tue, 2 Feb 2016 12:06:12 +0100
Message-ID: <56B08DA4.8070207@gmail.com>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
 <20151228031340.GD3598@ubuntu> <3310024.mO5K6yH9vU@wuerfel>
 <20160105102455.GA30120@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37561 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbcBBLGQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 06:06:16 -0500
In-Reply-To: <20160105102455.GA30120@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>



On 05/01/16 11:24, Viresh Kumar wrote:
> On 05-01-16, 11:21, Arnd Bergmann wrote:
>> On Monday 28 December 2015 08:43:40 Viresh Kumar wrote:
>>> On 27-12-15, 14:21, Pi-Cheng Chen wrote:
>>>> Add operating-points-v2, clock, and regulator supply properties
>>>> required by mt8173-cpufreq driver to enable it.
>>>>
>>>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>>>> ---
>>>> This patch is based on the patch[1] that adds underlying clock MUX for
>>>> MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
>>>>
>>>> [1] http://article.gmane.org/gmane.linux.kernel.clk/325
>>>> ---
>>>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
>>>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
>>>>   2 files changed, 108 insertions(+)
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>
>> This patch is now in linux-next through Rafael's pm tree, and it breaks the
>> arm64 build:
>>
>>          arm64-defconfig
>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error
>>
>>
>> Please revert.
>>
>> In the future, please send all dts changes through the proper maintainer
>> channels (-> Mattias -> arm-soc), and make sure they actually build.
>
> Rafael has already reverted that, AFAIK, after Mark Brown reported the
> build issue.
>

Applied to v4.5-next/dts

Thanks.
