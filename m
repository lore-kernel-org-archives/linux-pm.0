From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 3/3] thermal: max77620: Add thermal driver for reporting
 junction temp
Date: Fri, 4 Mar 2016 19:34:13 +0530
Message-ID: <56D995DD.1050703@nvidia.com>
References: <1457098810-11964-1-git-send-email-ldewangan@nvidia.com> <1457098810-11964-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16688 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcCDOQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 09:16:57 -0500
In-Reply-To: <1457098810-11964-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, corbet@lwn.net
Cc: rklein@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


On Friday 04 March 2016 07:10 PM, Laxman Dewangan wrote:
> >
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +
> +#define MAX77620_NORMAL_OPERATING_TEMP	100000
> +#define MAX77620_TJALARM1_TEMP		120000
> +#define MAX77620_TJALARM1_TEMP		140000
>
Oops, Second one is MAX77620_TJALARM2_TEMP.
Will send other version once I will have some more feedback.

