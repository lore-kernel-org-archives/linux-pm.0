From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ondemand: Change the calculation of target frequency
Date: Mon, 3 Jun 2013 16:54:08 +0530
Message-ID: <CAKohpomLkogSHD+5Wobb34qHPnb7_vWE1Xz4K5MD=Q50kOpfuA@mail.gmail.com>
References: <51A7BFA6.3070800@semaphore.gr>
	<CAKohpokGDFvtaBMKxLTJCkx_WN+HN4eZ7LZ2upBLsXAsmcq7kA@mail.gmail.com>
	<CAKohpo=EyudEW+EX=b7=Wp-7ceqjVksDTwwSJf77_LNFaaNL3w@mail.gmail.com>
	<2413427.Abjbfkms0Z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2413427.Abjbfkms0Z@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 3 June 2013 16:27, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> The question is if we want policy->max to re-scale them effectively (i.e. to
> change weights so that the maximum load maps to the highest frequency available
> at the moment) or if we want policy->max to work as a cap (i.e. to map all
> loads above certain value to the maximum frequency available at the moment, so
> that the criteria for selecting the lower frequencies don't change).  In my
> opinion the second option is better, because it means "OK, we can't use some
> high frequencies, but let's not hurt performance for the loads that wouldn't
> require them anyway".  Otherwise, we'll effectively throttle all loads and
> that not only causes performance to drop, but also causes more energy to be
> used overall.

I wouldn't say that I don't agree with you as I do to some extent.

But the question that comes to my mind now is: Why is policy->max reduced
in the first place? User doesn't have control over which freqs to expose, so
available_frequencies will stay the same. The only thing he is capable
of doing is: reduce policy->max.. Which in a way means that.. "I don't want to
use higher frequencies (power, thermal reasons) and I know performance will
go down with it and I don't care for it now."

And this way I feel policy->max isn't a bad choice either.

BUT as you said: policy->max isn't there to say don't be so aggressive now in
increasing frequencies but just only to say, don't go over this frequency..

So, probably we can use cpuinfo.max_freq :)
