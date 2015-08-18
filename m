From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Tue, 18 Aug 2015 02:30:49 -0700
Message-ID: <20150818093049.GA26346@localhost.localdomain>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <5160300.5D2Dvly8u9@vostro.rjw.lan>
 <20150813081744.GN7557@n2100.arm.linux.org.uk>
 <4248436.YMvuzoKMLH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4248436.YMvuzoKMLH@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi there,

On Mon, Aug 17, 2015 at 6:32 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

<cut>

>
> Well, that's the situation as per MAINTAINERS today.  You seem to be concerned
> that it may not reflect the reality, but in that case I can only recommend
> sending a patch against MAINTAINERS to remove Eduardo from there.
>
>> As I've said, I'm not bothering with this anymore, it's just far too
>> much effort to play these stupid games.
>
> I'm not sure what you mean by "these stupid games" here.
>
>> The deadlock can stay for all I care.
>
> Fair enough.

I applied the patch. And it has generated the conflict in linux-next, as was mentioned in this thread. I already sent the pull request.

Yes, I missed the thread. Apologize for this and for the inconvenience I have caused. The deadlock will be taken care using Russel's patch.

Thanks Viresh for notifying me.


>
> Thanks,
> Rafael
>

BR,

-- 
Eduardo Bezerra Valentin
