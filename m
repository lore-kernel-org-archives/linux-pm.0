From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
Date: Wed, 28 Nov 2018 15:01:37 +0530
Message-ID: <20181128093137.a5d4kwgfdthlsolw@vireshk-i7>
References: <4064391.AYvOMBeiDo@aspire.rjw.lan>
 <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
 <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 28-11-18, 10:11, Rafael J. Wysocki wrote:
> On Wed, Nov 28, 2018 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 26-11-18, 14:11, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Important information is missing from user/admin cpuidle documentation
> > > available today, so add a new user/admin document for cpuidle containing
> > > current and comprehensive information to admin-guide and drop the old
> > > .txt documents it is replacing.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  Documentation/admin-guide/pm/cpuidle.rst       |  603 +++++++++++++++++++++++++
> > >  Documentation/admin-guide/pm/working-state.rst |    1
> > >  Documentation/cpuidle/core.txt                 |   23
> > >  Documentation/cpuidle/sysfs.txt                |   98 ----
> > >  4 files changed, 604 insertions(+), 121 deletions(-)
> >
> > Nice work Rafael. Minor nits below..
> 
> Thanks for the typo fixes.  The spellchecker I have here evidently doesn't work.

I have this in my .vimrc and I am shown these spelling mistakes somewhat
forcefully :)

set spell spelllang=en_us

-- 
viresh
