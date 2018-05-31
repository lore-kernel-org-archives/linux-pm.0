From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/9] PM / Domains: Drop genpd as in-param for
 pm_genpd_remove_device()
Date: Thu, 31 May 2018 11:45:28 +0530
Message-ID: <20180531061528.6b7qdfygk5ouyeyh@vireshk-i7>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-4-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529100421.31022-4-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>
List-Id: linux-pm@vger.kernel.org

On 29-05-18, 12:04, Ulf Hansson wrote:
> There is no need to pass a genpd struct to pm_genpd_remove_device(), as we
> already have the information about the PM domain (genpd) through the device
> structure.
> 
> Additionally, we don't allow to remove a PM domain from a device, other
> than the one it may have assigned to it, so really it does not make sense
> to have a separate in-param for it.
> 
> For these reason, drop it and update the current only call to
> pm_genpd_remove_device() from amdgpu_acp.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c             | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
>  include/linux/pm_domain.h               | 5 ++---
>  3 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
