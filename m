From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Date: Fri, 29 Jun 2018 11:06:29 +0200
Message-ID: <2322281.e0L7xCS2Qb@aspire.rjw.lan>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 29, 2018 8:19:30 AM CEST Viresh Kumar wrote:
> Hi,
> 
> This series improves the OPP core (and a bit of genpd core as well) to
> support multiple phandles in the "required-opps" property, which are
> only used for multiple power-domains per device for now.
> 
> We still don't propagate the changes to master domains for the
> sub-domains, but this patchset is an important stepping stone for that
> to happen.
> 
> Tested on Hikey960 after faking some power domains for CPUs.

I'm assuming that this work will go in via OPP.

Thanks,
Rafael
