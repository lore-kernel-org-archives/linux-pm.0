From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 8/9] Thermal: Add ABI Documentation for sysfs interfaces
Date: Tue, 19 Feb 2013 10:10:05 +0100
Message-ID: <20130219091005.GA17219@xo-6d-61-c0.localdomain>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <1357542806-20449-9-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56505 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757774Ab3BSJKM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 04:10:12 -0500
Content-Disposition: inline
In-Reply-To: <1357542806-20449-9-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com, hongbo.zhang@linaro.org, wni@nvidia.com

On Mon 2013-01-07 12:43:25, Durgadoss R wrote:
> This patch adds Documentation for ABI's introduced
> for thermal subsystem (under /sys/class/thermal/).

So... we have deciCelsius and deciKelvin in ACPI (IIRC) and miliCelsius here.

Perhaps using deciCelsius to be consistent with ACPI would be nice?

What do lm_sensors use?
									Pavel
> index 0000000..d1a450e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-thermal
> @@ -0,0 +1,93 @@
> +What:		/sys/class/thermal/sensorX/temp
> +Date:		January 2013
> +KernelVersion:	3.8
> +Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
> +Description:
> +		Exposes 'temperature' of a thermal sensor in mC
> +Users:		Kernel/User space thermal governors
> +

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
