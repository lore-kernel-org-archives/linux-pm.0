From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 02/47] memory: emif: Use API function to determine
 poweroff capability
Date: Wed, 22 Oct 2014 15:18:49 -0700
Message-ID: <20141022221849.GA15671@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-3-git-send-email-linux@roeck-us.net>
 <5447FBF4.8020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44218 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbaJVWSx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Oct 2014 18:18:53 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xh4F3-004FNO-Dk
	for linux-pm@vger.kernel.org; Wed, 22 Oct 2014 22:18:53 +0000
Content-Disposition: inline
In-Reply-To: <5447FBF4.8020702@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>

On Wed, Oct 22, 2014 at 11:48:20AM -0700, Santosh Shilimkar wrote:
> 
> 
> On 10/20/2014 09:12 PM, Guenter Roeck wrote:
> >Use have_kernel_power_off() to determine if the kernel is able
> >to power off the system.
> >
> >Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >---
> >v2:
> >- poweroff -> power_off
> >
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
Thanks!

Guenter
