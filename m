From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: report driver's successful {un}registration
Date: Thu, 10 Jul 2014 17:38:23 +0530
Message-ID: <CAKohpok0M1_khYB=AobfAuPM9Tf8wi63K5o6NCQ+sC=STP5HMw@mail.gmail.com>
References: <9e68cba2bf41923630ea93de7c3d17637f175895.1403772686.git.viresh.kumar@linaro.org>
	<20140710114828.GA3254@pd.tnic>
	<CAKohpom0Qwbj5Ma_zCE5juk=1JjbBDLZJcBXZMgnkDVPiTvRCA@mail.gmail.com>
	<20140710115934.GF2970@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140710115934.GF2970@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>
List-Id: linux-pm@vger.kernel.org

On 10 July 2014 17:29, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Jul 10, 2014 at 05:21:43PM +0530, Viresh Kumar wrote:
>> So that it appears in boot logs and we know cpufreq registered properly.
>
> So flip that logic: Don't say anything in the success case and issue an
> error only when it failed. Like the rest of the code does it.

The problem with that is: CPUFreq may not be compiled in at all and
we wouldn't know the difference between success and absence.

And so tried to add a print, like any other driver would do.
