From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 03/11] PM / Domains: Document flags for genpd
Date: Thu, 4 Oct 2018 06:48:39 -0700
Message-ID: <20181004134839.GZ5662@atomide.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003143824.13059-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

* Ulf Hansson <ulf.hansson@linaro.org> [181003 14:43]:
> + * GENPD_FLAG_IRQ_SAFE:		This informs genpd that its backend callbacks,
> + *				->power_on|off(), doesn't sleep. Hence, these
> + *				can be invoked from within atomic context, which
> + *				enables genpd to power on/off the PM domain,
> + *				even when pm_runtime_is_irq_safe() returns true,
> + *				for any of its attached devices. Note that, a
> + *				genpd having this flag set, requires its
> + *				masterdomains to also have it set.
> + *

Let's try to avoid adding more irq_safe stuff because of having that
propagate to the masterdomains..

I think you can just flag the power_on/off in genpd, then have cpu_pm
callbacks do it.

Regards,

Tony
