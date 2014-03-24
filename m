From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC v3 0/5] cpufreq:LAB: Support for LAB governor.
Date: Mon, 24 Mar 2014 14:18:10 +0530
Message-ID: <CAKohpok1zBsX7n70r=geCOaP-9ONx2QdaUMK6cJeqhFrO1PkUg@mail.gmail.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
	<1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2014 15:57, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Despite this patch set is working and applicable on top of 3.14-rc5,
> please regard it solely as a pure RFC.

Okay, I am trying to do a review here and because you have mentioned
how different it is from the earlier versions, I am trying with a fresh mind.
i.e. with zero memories of earlier discussions :)

LAB was: Legacy Application Boost ??

Probably mention that in your new threads as well, so that new readers
know the details. Also, like other governors, just name it "boost" governor.

> This patch provides support for LAB governor build on top of ondemand.
> Previous version of LAB can be found here:
> http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
>
> LAB short reminder:
>
> LAB uses information about how many cores are in "idle" state (the core
> idleness is represented as the value between 0 and 100) and the overall
> load of the system (from 0 to 100) to decide about frequency to be set.
> It is extremely useful with SoCs like Exynos4412, which can set only one
> frequency for all cores.

Probably a description of how exactly these two values come into play
would have been more interesting here for all. Always think of new followers
of your patchset and so add all interesting things about it when you resend
it.

If I remember well the logic was more or less like this:
- More idle cores means run few running cores at high frequency
- Less idle cores means don't run them at very high frequencies

Right?

What about making it as simple as:
- changing the ondemand governor only instead of adding a new governor
- Keeping the bahavior as is for all platforms not publishing boost frequencies
- If more cores are idle, enable switching to boost frequencies and take them
into consideration all the time.
- If less cores are idle, disable boost frequencies..

Lets discuss this first and then I will get into the very details of your
implementation.
