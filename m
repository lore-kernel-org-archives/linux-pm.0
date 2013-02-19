From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8
 and temp11
Date: Tue, 19 Feb 2013 16:02:47 -0700
Message-ID: <51240497.8010909@wwwdotorg.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-5-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40090 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933179Ab3BSXCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 18:02:50 -0500
In-Reply-To: <1361187031-3679-5-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org, devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Using macros for the indexes and nrs of temp8 and temp11.
> This make the code much clearer.

Sorry to nit-pick, but those aren't macros, but rather they're enums.

The patch looks good though.
