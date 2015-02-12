From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH v7 01/16] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Thu, 12 Feb 2015 15:54:40 +0200
Message-ID: <20150212135440.GG20811@tbergstrom-lnx.Nvidia.com>
References: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19125 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbBLNzH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 08:55:07 -0500
Content-Disposition: inline
In-Reply-To: <1420723339-30735-2-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On Thu, Jan 08, 2015 at 03:22:04PM +0200, Mikko Perttunen wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> 
> The DFLL is the main clocksource for the fast CPU cluster on Tegra124
> and also provides automatic CPU rail voltage scaling as well. The DFLL
> is a separate IP block from the usual Tegra124 clock-and-reset
> controller, so it gets its own node in the device tree.
> 

Please add devicetree@vger.kernel.org to the next CC list.

Peter.
