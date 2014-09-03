From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
Date: Wed, 03 Sep 2014 16:15:21 -0700
Message-ID: <7hsik847p2.fsf@paris.lan>
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
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuA9ag2pybyLDUyW43wMQu4PA1cB4V9c1bc7WB3xjqzhqNGTw@mail.gmail.com>
	(Thomas Abraham's message of "Wed, 3 Sep 2014 18:48:35 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Chander Kashyap <k.chander@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

Thomas Abraham <ta.omasab@gmail.com> writes:

[...]

> A new branch [1] has been created using commits from exynos5-v3.17-rc1
> branch + cpufreq + regulator + temp fixes. I have tested this branch
> on Exynos5800 Chromebook2 and cpufreq works fine with both ondemand
> and performance governors. Please let me know if there are any issues
> with this new branch. It is based on v3.17-rc3.

Excellent!  Thank you.

The only thing missing now is the CPUidle support for 5800, and all
that's needed for that is the compatible string patch[1] which Daniel
has queued up.

With that patch, display + CPUidle + CPUfreq are working pretty well on
my exynos5800/chromebook2 with the big.LITTLE switcher disabled.  If I
turn on the switcher, it boots OK, but as soon as I try to run powertop
(upstream v2.6.1) it gets stuck.  Have you tried this branch with the
switcher enabled?

Thanks again for your work on this, we're getting close!  

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279028.html
