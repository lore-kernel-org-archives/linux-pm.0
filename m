From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Date: Thu, 3 Jan 2019 10:41:27 +0000
Message-ID: <20190103104127.GB23511@e107155-lin>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
 <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nm@ti.com, sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Douglas Raillard <Douglas.Raillard@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 03, 2019 at 04:08:29PM +0530, Viresh Kumar wrote:
> On 03-01-19, 10:33, Sudeep Holla wrote:
> > As you already state the checks are unnecessary, if we drop them we don't need
> > to add any firmware specific callbacks. I am thinking if it makes sense to
> > add a generic helper function to remove the OPPs from a device. If we have
> > that any driver needing that can use it. The main reason I think helper is
> > useful is that we need exactly same fix for SCMI driver too.
> >
> > Thoughts ?
>
> Okay, will do that and fix both the drivers as well.
>

Thanks, happy to test here.

--
Regards,
Sudeep
