From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] CPUFreq: Last set of updates for 3.13
Date: Wed, 11 Sep 2013 16:29:23 +0530
Message-ID: <CAKohpomFjmfZ5Ce91o1VOhGT33L+jH-5G0NgAQCTFL6v7kNFdw@mail.gmail.com>
References: <cover.1378893296.git.viresh.kumar@linaro.org>
	<CAP245DXeU39UE5-_G3J=r=arPt-8DieL4uN9SOOvWQf5xS3wAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAP245DXeU39UE5-_G3J=r=arPt-8DieL4uN9SOOvWQf5xS3wAA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Lists LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 11 September 2013 16:23, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> Thanks for the great work cleaning up all the drivers. IIUC, you have
> ~200 patches lined up for the 3.13 merge window.

227 to be precise :)

> That causes some worries.
>
> Can we quickly do the following to get more confidence that there
> won't be wide-spread breakage:
>
> 1. Get all of these into linux-next quickly

Yes, even Myself and Rafael wanted to do that.. And were waiting
for pull request to go for 3.12-rc1..

I am mostly ready with my patches, wouldn't take long time for
me to review those completely before sending them..

> 2. Set up a LAVA[1] job to get linux-next kernels running on boards in our farm
> 3. Run cpufreq functional tests, e.g. PM-QA[2] test suite from Linaro
> with these kernels

That would be nice actually.. Anyway some people would test it on
linux-next, but doing that for few boards by Linaro would be
Awesome..

--
viresh
