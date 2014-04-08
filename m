From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Disable on multiplatform build
Date: Tue, 08 Apr 2014 14:13:57 +0200
Message-ID: <2111902.UpDYE9Wpx2@vostro.rjw.lan>
References: <1396436627-22744-1-git-send-email-sachin.kamat@linaro.org> <CAKohpo=wVHubLTyR1oX_HPLrGvrg+YsqO0kbPSKYB9wEyhXb2w@mail.gmail.com> <CAK9yfHxq7P1ngF9c-3P=HefoLrn3oZ9UngRc9DT_6g-xC0OtQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAK9yfHxq7P1ngF9c-3P=HefoLrn3oZ9UngRc9DT_6g-xC0OtQg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 03, 2014 05:13:58 PM Sachin Kamat wrote:
> On 2 April 2014 16:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 2 April 2014 16:33, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >> The current exynos cpufreq drivers are not multiplatform compliant
> >> and give build errors as they refer to header files from machine
> >> directory. Work to migrate them to generic cpufreq framework is under
> >> progress. Till such time disable the build on multiplatform so that
> >> other multiplatform ready features get tested.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Rafael,
> Please queue this patch for your upcoming pull request to Linus.

I will, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
