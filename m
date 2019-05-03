From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/3] Make IPA use PM_EM
Date: Fri, 3 May 2019 15:24:22 +0530
Message-ID: <20190503095422.dw5ssdd6bz2wxaqn@vireshk-i7>
References: <20190503094409.3499-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503094409.3499-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 03-05-19, 10:44, Quentin Perret wrote:
> Changes in v3:
> **************
>  - Changed warning message for unordered tables to something more
>    explicit (Viresh)
>  - Changes WARN() into a pr_err() for consistency

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
