From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Mon, 25 Jun 2018 15:15:39 +0530
Message-ID: <20180625094539.7urkjlwddkcz64ve@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25-06-18, 10:41, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> > +               if (per_cpu(idle_injection_device, cpu)) {
> > +                       pr_err("cpu%d is already registered\n", cpu);
> 
> If you print something like this, it should be clear what it is about
> and what piece of code it comes from as there will be no context
> around it it the log.

It should be good as we have this at the top.

#define pr_fmt(fmt) "ii_dev: " fmt


-- 
viresh
