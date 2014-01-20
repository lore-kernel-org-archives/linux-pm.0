From: Matthew Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH v4 0/2] Support to tune governor in run time
Date: Mon, 20 Jan 2014 10:58:01 -0800
Message-ID: <52DD71B9.3080202@nvidia.com>
References: <1390211732-5853-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2307 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaATS6D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 13:58:03 -0500
In-Reply-To: <1390211732-5853-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: durgadoss.r@intel.com, linux-pm@vger.kernel.org

Wei,

On 1/20/2014 1:55 AM, Wei Ni wrote:
> This serie can support to turn governor for thermal zone in
> run time.
> Adds avaiable_policies attribute, so the user can get available
> governor policies and change te governor to a new one.
> Adds thermal_update_governor() function, so the thermal platform
> driver can use it to update governor.


I recommend the name thermal_select_governor rather than 
thermal_update_governor.

The name thermal_update_governor sounds like it should be similar to 
thermal_update_zone. But, the two are very different. One is used for 
switching to a new governor and the other is used to trigger thermal 
response for the existing zone.

-Matt

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
