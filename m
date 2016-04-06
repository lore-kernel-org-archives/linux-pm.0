From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Indicate when a device has been unregistered
Date: Wed, 6 Apr 2016 12:00:48 -0700
Message-ID: <20160406190047.GA32535@linaro.org>
References: <1459883138-21136-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33781 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbcDFTAx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 15:00:53 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so38541589pac.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 12:00:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459883138-21136-1-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On Tue, Apr 05, 2016 at 02:05:38PM -0500, Dave Gerlach wrote:
> Currently the 'registered' member of the cpuidle_device struct is set
> to 1 during cpuidle_register_device. In this same function there are
> checks to see if the device is already registered to prevent duplicate
> calls to register the device, but this value is never set to 0 even on
> unregister of the device. Because of this, any attempt to call
> cpuidle_register_device after a call to cpuidle_unregister_device will
> fail which shouldn't be the case.
> 
> To prevent this, set registered to 0 when the device is unregistered.
> 
> Fixes: c878a52d3c7c ("cpuidle: Check if device is already registered")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
