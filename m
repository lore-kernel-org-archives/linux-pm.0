From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 09/14] Documentation: DT: bindings: Update NVIDIA PMC
 for Tegra
Date: Fri, 29 Jan 2016 10:08:14 -0600
Message-ID: <20160129160814.GA29403@rob-hp-laptop>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-10-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44003 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbcA2QIX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Jan 2016 11:08:23 -0500
Content-Disposition: inline
In-Reply-To: <1453998832-27383-10-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 28, 2016 at 04:33:47PM +0000, Jon Hunter wrote:
> Add the PMC driver compatible strings for Tegra132 and Tegra210.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt     | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

