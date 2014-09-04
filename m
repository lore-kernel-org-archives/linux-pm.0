From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
Date: Thu, 04 Sep 2014 06:30:13 -0700
Message-ID: <7hfvg74ioq.fsf@paris.lan>
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
	<7hmwah6cop.fsf@paris.lan>
	<CAJuA9ahe=9gdTaGcRb69syvRfwkkGMgDiiNfOMA9TBo42cWVZw@mail.gmail.com>
	<CAJuA9ag2pybyLDUyW43wMQu4PA1cB4V9c1bc7WB3xjqzhqNGTw@mail.gmail.com>
	<7hsik847p2.fsf@paris.lan>
	<CAJuA9aiXwgxrS_AYw5tt5GryhrtoOpK2RhhLcjxShNqswiCmqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9aiXwgxrS_AYw5tt5GryhrtoOpK2RhhLcjxShNqswiCmqA@mail.gmail.com>
	(Thomas Abraham's message of "Thu, 4 Sep 2014 15:52:38 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Chander Kashyap <k.chander@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Thomas Abraham <ta.omasab@gmail.com> writes:

> On Thu, Sep 4, 2014 at 4:45 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Hi Thomas,
>>
>> Thomas Abraham <ta.omasab@gmail.com> writes:
>>
>> [...]
>>
>>> A new branch [1] has been created using commits from exynos5-v3.17-rc1
>>> branch + cpufreq + regulator + temp fixes. I have tested this branch
>>> on Exynos5800 Chromebook2 and cpufreq works fine with both ondemand
>>> and performance governors. Please let me know if there are any issues
>>> with this new branch. It is based on v3.17-rc3.
>>
>> Excellent!  Thank you.
>>
>> The only thing missing now is the CPUidle support for 5800, and all
>> that's needed for that is the compatible string patch[1] which Daniel
>> has queued up.
>>
>> With that patch, display + CPUidle + CPUfreq are working pretty well on
>> my exynos5800/chromebook2 with the big.LITTLE switcher disabled.  If I
>> turn on the switcher, it boots OK, but as soon as I try to run powertop
>> (upstream v2.6.1) it gets stuck.  Have you tried this branch with the
>> switcher enabled?
>
> Yes, I have tested switcher + cpufreq + cpuidle with this branch and
> there are no issues found. I haven't tested with powertop yet. I will
> try and do that and let you know the result.
>
> You mentioned that when you run powertop, it gets stuck. When that
> happens, is there any log on the console or does system just turn
> unresponsive?

The console is not responsive, but kernel seems busy because I see
periodic timeout messages from the samsung clock driver.

Note that I see these messages when things are functioning normally
also.

Kevin


[1]
[  337.832031] wait_until_divider_stable: timeout in divider stablization
[  337.847024] wait_until_divider_stable: timeout in divider stablization
[  337.862024] wait_until_divider_stable: timeout in divider stablization
[  337.957028] wait_until_divider_stable: timeout in divider stablization
[  337.972024] wait_until_divider_stable: timeout in divider stablization
[  337.987024] wait_until_divider_stable: timeout in divider stablization
[  340.082029] wait_until_divider_stable: timeout in divider stablization
[  340.097024] wait_until_divider_stable: timeout in divider stablization
[  340.112024] wait_until_divider_stable: timeout in divider stablization
[  346.242030] wait_until_divider_stable: timeout in divider stablization
[  346.257024] wait_until_divider_stable: timeout in divider stablization
[  346.272024] wait_until_divider_stable: timeout in divider stablization
[  348.322029] wait_until_divider_stable: timeout in divider stablization
[  348.337025] wait_until_divider_stable: timeout in divider stablization
[  348.352024] wait_until_divider_stable: timeout in divider stablization
