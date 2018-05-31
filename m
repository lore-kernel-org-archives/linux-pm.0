From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 5/9] PM / Domains: dt: Allow power-domain property to
 be a list of specifiers
Date: Thu, 31 May 2018 11:48:21 +0530
Message-ID: <20180531061821.wcasbwr3s7lphr4a@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-6-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> To be able to describe topologies where devices are partitioned across
> multiple power domains, let's extend the power-domain property to allow
> being a list of PM domain specifiers.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Suggested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
