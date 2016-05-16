From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/11] of: Add bindings of hw throttle for Tegra
 soctherm
Date: Mon, 16 May 2016 10:01:26 -0500
Message-ID: <20160516150126.GA4530@rob-hp-laptop>
References: <1462962026-19653-1-git-send-email-wni@nvidia.com>
 <1462962026-19653-2-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462962026-19653-2-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: edubezval@gmail.com, thierry.reding@gmail.com, rui.zhang@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 11, 2016 at 06:20:16PM +0800, Wei Ni wrote:
> Add HW throttle configuration sub-node for soctherm, which
> is used to describe the throttle event, and worked as a
> cooling device. The "hot" type trip in thermal zone can
> be bound to this cooling device, and trigger the throttle
> function.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++++++++++++++++++++-
>  1 file changed, 119 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
