From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry macro for iteration
Date: Tue, 22 Apr 2014 12:18:51 +0200
Message-ID: <6612075.PRZcWcuj98@vostro.rjw.lan>
References: <534DB213.7080802@semaphore.gr> <5355A349.50908@semaphore.gr> <20140422071541.GA17657@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140422071541.GA17657@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 22, 2014 08:15:41 AM Lee Jones wrote:
> > The cpufreq core now supports the cpufreq_for_each_entry macro helper
> > for iteration over the cpufreq_frequency_table, so use it.
> > 
> > It should have no functional changes.
> 
> > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > ---
> 
> It would be good to have a changelog which describes the differences
> between the versions, so we can keep track.
> 
> >  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> So it looks like I already applied v2 of this patch to my tree. What
> changed in v3 and v4? Should I remove that patch from MFD and apply
> this one instead?

The reason why v4 was sent is because I asked for it.

And if you applied [5/8] without [1/8], it won't work, because the macro is
introduced by that patch.

If that's the case, please drop [5/8] and let me handle the entire series.

Kind regards,
Rafael
