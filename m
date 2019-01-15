From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 09/10] cpufreq: scmi: Use auto-registration of thermal
 cooling device
Date: Tue, 15 Jan 2019 10:37:38 +0000
Message-ID: <20190115103738.GA18365@e107155-lin>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <b39e20c223b108acbc144672c0d95a56e0587661.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b39e20c223b108acbc144672c0d95a56e0587661.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 14, 2019 at 10:05:01PM +0530, Amit Kucheria wrote:
> Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
>
> This allows removal of boiler plate code from the driver.
>

For this and the next patch(scpi),

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
