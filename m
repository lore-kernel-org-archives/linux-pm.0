From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP, clock and
 regulator supply properties
Date: Wed, 3 Feb 2016 09:46:25 +0800
Message-ID: <CALx668UB+o_RYUWSR86nUL7YpiK9fWPzZeOSaOmYTGtdnRKx=Q@mail.gmail.com>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
 <20151228031340.GD3598@ubuntu> <3310024.mO5K6yH9vU@wuerfel>
 <20160105102455.GA30120@ubuntu> <56B08DA4.8070207@gmail.com>
 <56B0B894.9040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <56B0B894.9040706-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 2, 2016 at 10:09 PM, Matthias Brugger
<matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>
> On 02/02/16 12:06, Matthias Brugger wrote:
>>
>>
>>
>> On 05/01/16 11:24, Viresh Kumar wrote:
>>>
>>> On 05-01-16, 11:21, Arnd Bergmann wrote:
>>>>
>>>> On Monday 28 December 2015 08:43:40 Viresh Kumar wrote:
>>>>>
>>>>> On 27-12-15, 14:21, Pi-Cheng Chen wrote:
>>>>>>
>>>>>> Add operating-points-v2, clock, and regulator supply properties
>>>>>> required by mt8173-cpufreq driver to enable it.
>>>>>>
>>>>>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>> ---
>>>>>> This patch is based on the patch[1] that adds underlying clock MUX for
>>>>>> MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
>>>>>>
>>>>>> [1] http://article.gmane.org/gmane.linux.kernel.clk/325
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
>>>>>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90
>>>>>> +++++++++++++++++++++++++++++
>>>>>>   2 files changed, 108 insertions(+)
>>>>>
>>>>>
>>>>> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>
>>>>
>>>> This patch is now in linux-next through Rafael's pm tree, and it
>>>> breaks the
>>>> arm64 build:
>>>>
>>>>          arm64-defconfig
>>>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax
>>>> error
>>>>
>>>>
>>>> Please revert.
>>>>
>>>> In the future, please send all dts changes through the proper maintainer
>>>> channels (-> Mattias -> arm-soc), and make sure they actually build.
>>>
>>>
>>> Rafael has already reverted that, AFAIK, after Mark Brown reported the
>>> build issue.
>>>
>>
>> Applied to v4.5-next/dts
>>
>
> I oversaw that this needs a clock patch, which is not yet mainlined.
> I deleted this patch from my tree.

I should mention that explicitly.
Sorry for the inconvenience.

Pi-Cheng
