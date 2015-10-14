From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] thermal: power_allocator: Use temperature reading from
 tz
Date: Wed, 14 Oct 2015 05:28:49 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402865B959@shsmsx102.ccr.corp.intel.com>
References: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48228 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbbJNF2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 01:28:53 -0400
In-Reply-To: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Javi Merino <javi.merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Andrea Arcangeli <aarcange@redhat.com>

Hi,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Kapileshwar Singh
> Sent: Tuesday, October 13, 2015 7:30 PM
> To: linux-pm@vger.kernel.org
> Cc: Kapileshwar Singh; Javi Merino; Eduardo Valentin; Daniel Kurtz; Zhang, Rui;
> Dmitry Torokhov; Sascha Hauer; Andrea Arcangeli
> Subject: [PATCH] thermal: power_allocator: Use temperature reading from
> tz
> 
> All thermal governors use the temperature value stored in struct
> thermal_zone_device.
> 
>    thermal_zone_device->temperature
> 
> power_allocator governor should not deviate from this and use the same.
> 
Just my 2 cents:
I wonder if tz->temperature would vary during power_allocator_throttle? 
because we don't have tz->lock to protect here.

Best Regards,
Yu
