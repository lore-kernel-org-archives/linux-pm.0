From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP, clock and
 regulator supply properties
Date: Tue, 2 Feb 2016 15:09:24 +0100
Message-ID: <56B0B894.9040706@gmail.com>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
 <20151228031340.GD3598@ubuntu> <3310024.mO5K6yH9vU@wuerfel>
 <20160105102455.GA30120@ubuntu> <56B08DA4.8070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56B08DA4.8070207@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 02/02/16 12:06, Matthias Brugger wrote:
>
>
> On 05/01/16 11:24, Viresh Kumar wrote:
>> On 05-01-16, 11:21, Arnd Bergmann wrote:
>>> On Monday 28 December 2015 08:43:40 Viresh Kumar wrote:
>>>> On 27-12-15, 14:21, Pi-Cheng Chen wrote:
>>>>> Add operating-points-v2, clock, and regulator supply properties
>>>>> required by mt8173-cpufreq driver to enable it.
>>>>>
>>>>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>>>>> ---
>>>>> This patch is based on the patch[1] that adds underlying clock MUX for
>>>>> MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
>>>>>
>>>>> [1] http://article.gmane.org/gmane.linux.kernel.clk/325
>>>>> ---
>>>>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
>>>>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90
>>>>> +++++++++++++++++++++++++++++
>>>>>   2 files changed, 108 insertions(+)
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>
>>>
>>> This patch is now in linux-next through Rafael's pm tree, and it
>>> breaks the
>>> arm64 build:
>>>
>>>          arm64-defconfig
>>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax
>>> error
>>>
>>>
>>> Please revert.
>>>
>>> In the future, please send all dts changes through the proper maintainer
>>> channels (-> Mattias -> arm-soc), and make sure they actually build.
>>
>> Rafael has already reverted that, AFAIK, after Mark Brown reported the
>> build issue.
>>
>
> Applied to v4.5-next/dts
>

I oversaw that this needs a clock patch, which is not yet mainlined.
I deleted this patch from my tree.
