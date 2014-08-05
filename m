From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v2 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Tue, 5 Aug 2014 15:24:02 +0300
Message-ID: <53E0CCE2.4050008@nvidia.com>
References: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com> <1407241137-32232-5-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14538 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbaHEMYJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Aug 2014 08:24:09 -0400
In-Reply-To: <1407241137-32232-5-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/08/14 15:18, Mikko Perttunen wrote:
> This adds support for the Tegra SOCTHERM thermal sensing and management
> system found in the Tegra124 system-on-chip. This initial driver supports
> the four thermal zones with hardware-tracked trip points.

.. does NOT support hardware-tracked trip points. I guess you always 
have to have at least one little mistake there.

Mikko

>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> ...
