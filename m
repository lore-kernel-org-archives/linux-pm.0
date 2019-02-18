From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in
 genpd_dev_pm_attach_by_name()
Date: Mon, 18 Feb 2019 09:41:48 +0100
Message-ID: <20190218084148.GD24924@kroah.com>
References: <20190214181249.2749-1-dianders@chromium.org>
 <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
 <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
 <20190218041514.yn76qm65k77etedr@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218041514.yn76qm65k77etedr@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 18, 2019 at 09:45:14AM +0530, Viresh Kumar wrote:
> On 15-02-19, 07:47, Doug Anderson wrote:
> > Hi,
> > On Thu, Feb 14, 2019 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 14-02-19, 10:12, Douglas Anderson wrote:
> > > > The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> > > > to of_property_match_string() where the argument is "const char *".
> > > > Adding a const here allows a later patch to add a const to
> > > > dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> > > > that was declared "const" in a driver.
> > > >
> > > > Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
> > >
> > > Not sure if this should be counted as a fix.
> > 
> > I'm OK if the "Fixes" is stripped when applying or if someone tells me
> > to re-post without the Fixes--just let me know.  In general I do a lot
> > of cherry-picks from upstream and I appreciate the Fixes tag helping
> > to link patches together.  In this case if I picked the original patch
> > I'd definitely want this one too.  Certainly, though, CCing stable
> > would make no sense in this case.  ;-)
> 
> I am not sure if this is being done right now or not, but I read/heard
> somewhere that stable has started picking "Fixes" patches directly as
> well even if they aren't cc'd to stable.

It's random, not always happening, and nothing you can rely on.

If you know this is a patch for older kernels, then always add the cc:
stable line, as the documentation says you have to do!

thanks,

greg k-h
