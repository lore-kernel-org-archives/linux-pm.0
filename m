From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: linux-next: Tree for Apr 9 [cpufreq: NULL pointer deref]
Date: Fri, 12 Apr 2013 13:53:36 +0530
Message-ID: <CAKohpom7Mn8aQZTUx-_fQF+9KWste0uYsZcaQ5rcM6ab45-0+g@mail.gmail.com>
References: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com>
	<31778276.CDMUtaAAnc@vostro.rjw.lan>
	<CA+icZUXXHb9vmcNuFmYha34SV7xch2S8OcgZ+cLVVnNebs5pNQ@mail.gmail.com>
	<CAKohpok+9dRaENjBfnN9gZF3zvFU9v19xV_eFfcM3Pj6Cv=S2w@mail.gmail.com>
	<CA+icZUWH5Ni9koj4V8Ws8jJ7smwmU7JuUWBFh=aiCqkrCpqB5A@mail.gmail.com>
	<CAKohponzmLzPN8ua3p4TCt2waZCQCd+4Znh+tSQ4MBjcy+Ss6A@mail.gmail.com>
	<CA+icZUW12caZHDfgCV6E-1T4ExBPmu5bBNSqCzDwjUeidfRUPA@mail.gmail.com>
	<CA+icZUUEExm5Mktxoj6=UdzBe5HUzskktKWdHNOKaFXVHaySBg@mail.gmail.com>
	<CA+icZUW2LQmWMdaVjf5oE8y3zCq8Y2829WM9dwDKxA42N5tVDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CA+icZUW2LQmWMdaVjf5oE8y3zCq8Y2829WM9dwDKxA42N5tVDQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10 April 2013 11:44, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> I found this "[RFC PATCH] kbuild: Build linux-tools package with 'make
> deb-pkg'" from February 2012.
> Can't say what happened to it...

Sedat,

Sorry for being late. I am down with Fever and throat infection since few days.
Still struggling with it..

There are few things i tried. Firstly the tag: next-20130326 is bad as there are
some bad commits in cpufreq core in it.

I then tried latest linux-next/master on my Thinkpad (model name	: Intel(R)
Core(TM) i7-2640M CPU @ 2.80GHz) and couldn't boot it up. My ubuntu
just hanged.

Then i tried Rafael's linux-next branch

079576f Merge branch 'pm-cpufreq-next' into linux-next

And couldn't find any issues with it. I am easily able to remove/add cpus at
runtime..

Can you give this branch a try?

--
viresh
