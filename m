From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: power_allocator: Use temperature reading from tz
Date: Thu, 15 Oct 2015 11:47:03 +0100
Message-ID: <20151015104702.GA13109@e104805>
References: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34859 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbJOKrG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 06:47:06 -0400
Content-Disposition: inline
In-Reply-To: <1444735801-18267-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kapileshwar Singh <kapileshwar.singh@arm.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Oct 13, 2015 at 12:30:01PM +0100, Kapileshwar Singh wrote:
> All thermal governors use the temperature value stored in
> struct thermal_zone_device.
> 
>    thermal_zone_device->temperature
> 
> power_allocator governor should not deviate from this and use
> the same.
> 
> Cc: Javi Merino <javi.merino@arm.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Reported-by: Sugumar Natarajan <sugumar.natarajan@arm.com>
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>

Acked-by: Javi Merino <javi.merino@arm.com>
