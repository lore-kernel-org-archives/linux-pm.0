From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Date: Fri, 15 Feb 2019 07:47:06 -0800
Message-ID: <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
References: <20190214181249.2749-1-dianders@chromium.org> <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,
On Thu, Feb 14, 2019 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-02-19, 10:12, Douglas Anderson wrote:
> > The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> > to of_property_match_string() where the argument is "const char *".
> > Adding a const here allows a later patch to add a const to
> > dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> > that was declared "const" in a driver.
> >
> > Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
>
> Not sure if this should be counted as a fix.

I'm OK if the "Fixes" is stripped when applying or if someone tells me
to re-post without the Fixes--just let me know.  In general I do a lot
of cherry-picks from upstream and I appreciate the Fixes tag helping
to link patches together.  In this case if I picked the original patch
I'd definitely want this one too.  Certainly, though, CCing stable
would make no sense in this case.  ;-)

-Doug
