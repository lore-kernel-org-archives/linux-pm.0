From: Wei Ni <wni@nvidia.com>
Subject: Re: [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
Date: Tue, 19 Feb 2013 17:48:06 +0800
Message-ID: <51234A56.4020006@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-3-git-send-email-wni@nvidia.com> <1B93E76B0D8B0E4E8BDD54060BBDE81975FB926ACC@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:8446 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab3BSJsZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 04:48:25 -0500
In-Reply-To: <1B93E76B0D8B0E4E8BDD54060BBDE81975FB926ACC@HQMAIL03.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew Longnecker <MLongnecker@nvidia.com>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/19/2013 06:29 AM, Matthew Longnecker wrote:
> Wei,
> 
> This set of patches seems to include 3 logical subsets
> 1) lm90 changes
> 2) dt support in drivers/thermal
> 3) tegra30 support in drivers/thermal
> 
> Would it make sense to split this into 3 separate sets of changes?

Ok, I will do it in my next version.

> 
> -Matt Longnecker
> 
> nvpublic
> 

