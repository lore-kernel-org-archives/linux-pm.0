From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
Date: Wed, 28 Nov 2018 10:11:16 +0100
Message-ID: <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
References: <4064391.AYvOMBeiDo@aspire.rjw.lan> <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 28, 2018 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-11-18, 14:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Important information is missing from user/admin cpuidle documentation
> > available today, so add a new user/admin document for cpuidle containing
> > current and comprehensive information to admin-guide and drop the old
> > .txt documents it is replacing.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/admin-guide/pm/cpuidle.rst       |  603 +++++++++++++++++++++++++
> >  Documentation/admin-guide/pm/working-state.rst |    1
> >  Documentation/cpuidle/core.txt                 |   23
> >  Documentation/cpuidle/sysfs.txt                |   98 ----
> >  4 files changed, 604 insertions(+), 121 deletions(-)
>
> Nice work Rafael. Minor nits below..

Thanks for the typo fixes.  The spellchecker I have here evidently doesn't work.

[cut]

> Maybe I missed, but I couldn't find any text that says what state 0, 1, ... N
> mean.

There is a paragraph on that above.

> Like which is the deepest idle state and which one is the shallowest.

But this part is missing, good catch!

Thanks,
Rafael
