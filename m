From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data protection
Date: Fri, 5 Feb 2016 04:33:05 +0100
Message-ID: <CAJZ5v0g7ydctPe52=GPKCt1C9R2+Ao+T0-XA42xW1Wxv++X6gg@mail.gmail.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
	<1529283.0IedZktI9q@vostro.rjw.lan>
	<20160204050954.GU3469@vireshk>
	<CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
	<20160205025948.GE3068@vireshk>
	<CAJZ5v0iyJSuWkqrL8VuSbX8G5s2X+fYngQqi+eVrfVMkLrkmeA@mail.gmail.com>
	<CAJZ5v0iHX0OO+dJRJvT=8Q7YixCK1bySCfUmYJrLJGfA-6XFdQ@mail.gmail.com>
	<CAJZ5v0j2-AMCjCisbGu1paJC4-3fjNp1tFND4KyNbBsQU079VQ@mail.gmail.com>
	<20160205032444.GC21792@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160205032444.GC21792@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 5, 2016 at 4:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 05-02-16, 04:17, Rafael J. Wysocki wrote:
>> And don't we switch governors under policy->rwsem anyway?
>
> So ? That is blocking only a single policy only, but with the new
> change, we will block all policies from doing that concurrently.

No, it won't.  Again: one lock instead of two.  How much of a
difference this makes performance-wise?

And the price is the stupid dance we need to do to even get to those
locks!  Come on.

Thanks,
Rafael
