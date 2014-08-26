From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Tue, 26 Aug 2014 15:25:48 -0700
Message-ID: <CAGa+x86jU8MR=r_xuaiorbNNyqrezb0b6Ozy-MPg9HvsARESOw@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan>
	<53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
	<CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
	<CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <k.chander@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 26, 2014 at 8:15 AM, Kevin Hilman <khilman@linaro.org> wrote:
> On Mon, Aug 25, 2014 at 10:25 PM, Chander Kashyap <k.chander@samsung.com> wrote:

[...]

>>>
>>> Can you clarify how you're setting the voltages to ensure stability?
>>
>> below is the diff :  wip/exynos/integ
>
> Thanks.
>
> I've applied your patch, and bootup shows vdd_arm and vdd_kfc at
> 1500mV, but still when booting with cpuidle enabled (bL switcher
> disabled), I'm seeing lockups with no kernel output.  With CPUidle
> disabled, things are pretty stable.
>
> What tree are you using to test this out on 5420?  I'm using mainline
> v3.17-rc1 + DT patch for CPUidle and this cpufreq series.  See my
> wip/exynos/integ branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git.

I mis-stated this.  Actually my tree is based on the v3.17-rc1 branch
of the exynos-reference tree[1] + the above mentioned patches for
cpuidle and cpufreq.

Also, I've narrowed down the instability a bit, and it's not related
to CPUidle.  I can now trigger a boot hang even without CPUidle
enabled.  Here's a quick way to cause a boot lockup. With the switcher
disabled, I enable CPUfreq and set the default governor to
performance.  As soon as cpufreq driver loads, it tries to use the top
frequences for both clusters, and it hangs.

Selectively disabling frequencies, I narrowed it down to the 1.3GHz
and 1.2GHz frequencies of the little cluster.  With these commented
out in the DT, it will fully boot with the performance governor
enabled.

So that leads to the question.  Are all of the operating points in
exynos5420.dtsi valid for exynos5800, and have they been validated?

Kevin

[1]https://github.com/exynos-reference/kernel.git
