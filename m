From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/10] OPP: Support multiple power-domains per device
Date: Mon, 16 Jul 2018 10:02:03 +0530
Message-ID: <20180716043203.gyedmithp4xa7p3u@vireshk-i7>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-06-18, 11:49, Viresh Kumar wrote:
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

Ulf, can you please help review this stuff ? 

-- 
viresh
