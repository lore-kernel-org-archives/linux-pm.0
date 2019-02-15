From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
Date: Fri, 15 Feb 2019 07:42:25 -0800
Message-ID: <CAD=FV=XMGzWD=rEPshz_QHkcmqMhu87cn2n0i+ZOzPbgcHccxg@mail.gmail.com>
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
 <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 2:28 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 14 Feb 2019 at 19:13, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As of the patch ("PM / Domains: Mark "name" const in
> > genpd_dev_pm_attach_by_name()") it's clear that the name in
> > dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> > allows drivers to pass in a name that was declared "const" in a
> > driver.
> >
> > Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_name()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Perhaps fold $subject patch into patch1, they seems highly related.
> Anyway, no strong opinion here.

Sure, either way is fine with me so I'll wait until someone tells me
for sure one way or the other.  I'm also happy if they just get
squashed together when applied if that's easier.  I originally kept
them separate since the two APIs were originally added in separate
patches so it seemed consistent to do the bugfixes in separate
patches.  ;-)

-Doug
