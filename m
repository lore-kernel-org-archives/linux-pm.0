From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH 5/6] clk: tegra: Add soctherm and tsensor clocks to
 Tegra124 init table
Date: Fri, 27 Jun 2014 15:18:33 +0300
Message-ID: <20140627121833.GQ3679@tbergstrom-lnx.Nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-6-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403856699-2140-6-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 27, 2014 at 10:11:38AM +0200, Mikko Perttunen wrote:
> This adds the two clocks, soctherm and tsensor, to the T124 initialization table.
> They are required for soctherm-based thermal sensing.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> Peter, one more zero for TSENSOR, please :)

Ah :) I will take this into clk-tegra-3.17

Cheers,

Peter.
