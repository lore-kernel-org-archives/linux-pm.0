From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V9 RESEND 14/14] arm: tegra: set critical trips for
 Tegra124
Date: Tue, 29 Mar 2016 08:17:05 -0700
Message-ID: <20160329151705.GC1855@localhost.localdomain>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com>
 <1459247364-1139-15-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32821 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbcC2PRJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 11:17:09 -0400
Content-Disposition: inline
In-Reply-To: <1459247364-1139-15-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 29, 2016 at 06:29:24PM +0800, Wei Ni wrote:
> Set general "critical" trip temperatures for cpu, gpu, mem and pllx
> thermal zones for all Tegra124 platform, these trips can trigger
> shut down or reset.
> Tegra124 Jetson TK1 was already set "critical" trips before, so it
> can overwrite the general values.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

