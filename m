From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 04/13] power: bq24257: Allow manual setting of input
 current limit
Date: Tue, 1 Sep 2015 14:59:32 -0500
Message-ID: <55E603A4.8020601@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-5-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42402 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbIAT77 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 15:59:59 -0400
In-Reply-To: <1441073435-12349-5-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 08/31/2015 09:10 PM, Andreas Dannenberg wrote:
> A new device property called "ti,in-ilimit-autoset-disable" is
> introduced to allow disabling the D+/D- based auto-detection algorithm
> used to determine the input current limit. This feature is also
> explicitly disabled on bq25250 devices which don't support D+/D-
> charger type detection.
>
> If "ti,in-ilimit-autoset-disable" is set the actual input current limit
> can be configured through the "ti,in-limit-current" property.
>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>

Acked-by: Andrew F. Davis <afd@ti.com>

-- 
Andrew F. Davis
