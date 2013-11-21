From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Remove unwanted EXPORT_SYMBOL
Date: Thu, 21 Nov 2013 01:55:23 +0100
Message-ID: <3083067.JbpkBuq0C6@vostro.rjw.lan>
References: <1384775486-31660-1-git-send-email-sachin.kamat@linaro.org> <CAKohpomKmJyJ_=Rd=7EMbQJixzumdTkOtK50xxFVZiyv5fLjmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomKmJyJ_=Rd=7EMbQJixzumdTkOtK50xxFVZiyv5fLjmw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 18, 2013 08:14:57 PM Viresh Kumar wrote:
> On 18 November 2013 17:21, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> > The init functions are linked statically (no support for
> > dynamic loading) and have no other users. Hence remove
> > EXPORT_SYMBOL for these functions.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/cpufreq/exynos4210-cpufreq.c |    1 -
> >  drivers/cpufreq/exynos4x12-cpufreq.c |    1 -
> >  drivers/cpufreq/exynos5250-cpufreq.c |    1 -
> >  3 files changed, 3 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for the next PM pull request.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
