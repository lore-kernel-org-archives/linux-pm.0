From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2] (gpio-fan): Add thermal control hooks
Date: Thu, 08 Jan 2015 20:48:40 -0800
Message-ID: <54AF5DA8.6080408@roeck-us.net>
References: <1420740303-12529-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44329 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbAIEsm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 23:48:42 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y9RV4-002Mj4-N4
	for linux-pm@vger.kernel.org; Fri, 09 Jan 2015 04:48:43 +0000
In-Reply-To: <1420740303-12529-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 01/08/2015 10:05 AM, Nishanth Menon wrote:
> Allow gpio-fan to be used as thermal cooling device for platforms that
> use GPIO maps to control fans.
>
> As part of this change, we make the shutdown and remove logic the same
> as well.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Applied to -next.

Thanks,
Guenter

