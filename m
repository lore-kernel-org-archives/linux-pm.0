From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Mon, 25 Jun 2018 15:14:11 +0530
Message-ID: <20180625094411.ubklcaxvd7hvuind@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25-06-18, 10:23, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> > +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
> > +                                unsigned int *run_duration_ms,
> > +                                unsigned int *idle_duration_ms)
> > +{
> > +       *run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> > +       *idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
> 
> Should you check the arguments against NULL before attempting to
> dereference them?  If not, then why not?

I would vote with a NO. This is a mandatory parameter and not filling it in with
a valid pointer is a BUG really. I don't see a reason why we should prevent the
kernel from crashing if such a mistake happens :)

-- 
viresh
