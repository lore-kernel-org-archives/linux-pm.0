From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
Date: Tue, 02 Sep 2014 12:32:22 -0700
Message-ID: <7hmwah6cop.fsf@paris.lan>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan> <53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
	<CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
	<CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
	<CAGa+x86jU8MR=r_xuaiorbNNyqrezb0b6Ozy-MPg9HvsARESOw@mail.gmail.com>
	<CAJuA9ajtsrY7zSDMs=c6BZ0AqERoBgvq++dTF4Dn673zGMfcgQ@mail.gmail.com>
	<CAMAWPa-8h5PNhgT+ApBhA8p=i+4oFOnYnQsQ4mK1JKwwAhpvpQ@mail.gmail.com>
	<CAJuA9ah5M_pXRMXPB6o7JLhgVUHM7kYo9HOV6Yxv4Z=hKMdG=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48496 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbaIBTcZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 15:32:25 -0400
In-Reply-To: <CAJuA9ah5M_pXRMXPB6o7JLhgVUHM7kYo9HOV6Yxv4Z=hKMdG=w@mail.gmail.com>
	(Thomas Abraham's message of "Mon, 1 Sep 2014 14:17:20 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Chander Kashyap <k.chander@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>

HI Thomas,

Thomas Abraham <ta.omasab@gmail.com> writes:

> On Fri, Aug 29, 2014 at 8:33 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> Hi Thomas,
>>
>> On Fri, Aug 29, 2014 at 5:52 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
>>> Hi Kevin,
>>>
>>> On Wed, Aug 27, 2014 at 3:55 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>>> On Tue, Aug 26, 2014 at 8:15 AM, Kevin Hilman <khilman@linaro.org> wrote:
>>>>> On Mon, Aug 25, 2014 at 10:25 PM, Chander Kashyap <k.chander@samsung.com> wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>
>>>>>>> Can you clarify how you're setting the voltages to ensure stability?
>>>>>>
>>>>>> below is the diff :  wip/exynos/integ
>>>>>
>>>>> Thanks.
>>>>>
>>>>> I've applied your patch, and bootup shows vdd_arm and vdd_kfc at
>>>>> 1500mV, but still when booting with cpuidle enabled (bL switcher
>>>>> disabled), I'm seeing lockups with no kernel output.  With CPUidle
>>>>> disabled, things are pretty stable.
>>>>>
>>>>> What tree are you using to test this out on 5420?  I'm using mainline
>>>>> v3.17-rc1 + DT patch for CPUidle and this cpufreq series.  See my
>>>>> wip/exynos/integ branch at
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git.
>>>>
>>>> I mis-stated this.  Actually my tree is based on the v3.17-rc1 branch
>>>> of the exynos-reference tree[1] + the above mentioned patches for
>>>> cpuidle and cpufreq.
>>>>
>>>> Also, I've narrowed down the instability a bit, and it's not related
>>>> to CPUidle.  I can now trigger a boot hang even without CPUidle
>>>> enabled.  Here's a quick way to cause a boot lockup. With the switcher
>>>> disabled, I enable CPUfreq and set the default governor to
>>>> performance.  As soon as cpufreq driver loads, it tries to use the top
>>>> frequences for both clusters, and it hangs.
>>>>
>>>> Selectively disabling frequencies, I narrowed it down to the 1.3GHz
>>>> and 1.2GHz frequencies of the little cluster.  With these commented
>>>> out in the DT, it will fully boot with the performance governor
>>>> enabled.
>>>>
>>>> So that leads to the question.  Are all of the operating points in
>>>> exynos5420.dtsi valid for exynos5800, and have they been validated?
>>>
>>> I tried to recreate the boot lockup issue using the same steps you
>>> listed above for the Exynos5800 peach-pi platform (Chromebook2), but I
>>> do not see any issues. I can see both clusters with max clock speed
>>> after boot (1.8GHz and 1.3GHz).
>>>
>>> I am using v3.17-rc2 + CPUFreq Patches + max77802 regulator support
>>> patches for Chromebook2 + temp hack to set A15 voltage to 1.35V and A7
>>> voltage to 1.3V.
>>
>> Can you share your branch and temp hack(s) as well as your defconfig?
>>
>> I'm using the v3.17-rc1 branch from the exynos tree (which includes
>> the max77802 series) but also has a bunch of other stuff which may be
>> causing the issue.
>>
>> It would be good if I can reproduce your exact tree/branch and see if
>> I still have the same problem.
>
> The branch with the patches that have been used to test cpufreq on
> Exynos5800 is available at
>
> https://github.com/exynos-reference/kernel/tree/exynos5-v3.17-rc3-temp-cpufreq
>
> Please let me know if this works or if there are any issues.

Yes, your branch works fine, but it's because of the last (unposted)
patch on your branch[1]: 
ARM: dts: remove all supplies sourced from tps65090 PMIC

That patch had not been posted, so I hadn't seen it before, but based on
the changelog, it's pretty clear you had the same problems that I had
without it, so I'm not sure why it wasn't mentioned earlier in this
thread.

I also noticed that the "force vdd_arm and vdd_kfc to max voltage" patch
is not actually using the max voltage, which appears to be 1.5V from the
DT, but actually using 1.35 V, however the changelog has no explanation
for this.

One other thing, your temp-cpufreq branch has conflicts with max77802
stuff in the v3.17-rc1 branch of the exynos-reference tree (which I'm
using for CPUidle dependencies, on the PMU series IIRC.)

Are there any plans to update the main referece branch and include
cpufreq?

Kevin

[1] https://github.com/exynos-reference/kernel/commit/f08be7e4296a3452ee5d1aae31e3de5bbff2cf1a
