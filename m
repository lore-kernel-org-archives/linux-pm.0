From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/3] Introduce of_match_machine() helper
Date: Mon, 25 Aug 2014 11:45:38 -0600
Message-ID: <53FB7642.1000808@wwwdotorg.org>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:38447 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034AbaHYRpN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Aug 2014 13:45:13 -0400
In-Reply-To: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 08/07/2014 05:01 PM, Tuomas Tynkkynen wrote:
> Some mach-specific drivers that don't require their own node in the device tree
> (for example drivers/soc/*, cpufreq, cpuidle etc.) want to match on the device
> tree root compatible property instead. Instead of open-coding (and forgetting
> to call of_node_put on the root node) everywhere, add a helper to the OF core.

Tuomas, I assume there will be a new version of this series to address 
the review comments? For now, I'm not intending on applying this.
