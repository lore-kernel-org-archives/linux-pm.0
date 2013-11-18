From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCHv5 06/20] hwmon: lm75: expose to thermal fw via DT nodes
Date: Mon, 18 Nov 2013 08:25:32 -0800
Message-ID: <20131118162532.GB15610@roeck-us.net>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com>
 <1384285582-16933-7-git-send-email-eduardo.valentin@ti.com>
 <20131115084354.656452b9@endymion.delvare>
 <528A23DD.2070406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62660 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab3KRQZf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 11:25:35 -0500
Content-Disposition: inline
In-Reply-To: <528A23DD.2070406@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Jean Delvare <khali@linux-fr.org>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Nov 18, 2013 at 10:27:41AM -0400, Eduardo Valentin wrote:
> On 15-11-2013 03:43, Jean Delvare wrote:
> > Hi Eduardo,
> > 
> 
> Hello Jean!
> 
> > Sorry for joining the discussion a little late, I could never find the
> > time to look into this patch series so far.
> 
> Well, better late than never, that's what it is said, isn't it? :-)
> Thanks for arranging the time to look at these patches.
> 
> The patch series have been looked and contributed by several people and
> a couple o maintainers now. Starts to be way better than the original
> RFC. The core idea still holds though.
> 
> > 
> > On Tue, 12 Nov 2013 15:46:08 -0400, Eduardo Valentin wrote:
> >> This patch adds to lm75 temperature sensor the possibility
> >> to expose itself as thermal zone device, registered on the
> >> thermal framework.
> >>
> >> The thermal zone is built only if a device tree node
> >> describing a thermal zone for this sensor is present
> >> inside the lm75 DT node. Otherwise, the driver behavior
> >> will be the same.
> >>
> >> Cc: Jean Delvare <khali@linux-fr.org>
> >> Cc: lm-sensors@lm-sensors.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> On HWMON side, I got Guenter's solid contributions, as you can see.
> 
Not an argument. I am not perfect, and Jean has a number of valid points.

Guenter
