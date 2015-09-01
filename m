From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 05/13] power: bq24257: Add SW-based approach for Power
 Good determination
Date: Tue, 1 Sep 2015 15:01:55 -0500
Message-ID: <55E60433.7080800@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-6-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44547 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbIAUCZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Sep 2015 16:02:25 -0400
In-Reply-To: <1441073435-12349-6-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 08/31/2015 09:10 PM, Andreas Dannenberg wrote:
> A new device property called "ti,pg-gpio-disable" is introduced to
> allow disabling the GPIO-based Power Good implementation, and
> replacing it with a SW-only alternative. This is helpful for devices
> which don't have a dedicated PG pin such as bq25250.
>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>

Acked-by: Andrew F. Davis <afd@ti.com>

-- 
Andrew F. Davis
