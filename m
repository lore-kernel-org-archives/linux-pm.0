From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Date: Thu, 3 Jan 2019 16:08:29 +0530
Message-ID: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190103103318.GA23511@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nm@ti.com, sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Douglas Raillard <Douglas.Raillard@arm.com>
List-Id: linux-pm@vger.kernel.org

On 03-01-19, 10:33, Sudeep Holla wrote:
> As you already state the checks are unnecessary, if we drop them we don't need
> to add any firmware specific callbacks. I am thinking if it makes sense to
> add a generic helper function to remove the OPPs from a device. If we have
> that any driver needing that can use it. The main reason I think helper is
> useful is that we need exactly same fix for SCMI driver too.
> 
> Thoughts ?

Okay, will do that and fix both the drivers as well.

-- 
viresh
