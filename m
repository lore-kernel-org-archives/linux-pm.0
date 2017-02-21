From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v2 0/3] devfreq_cooling: let the driver supply the real
 power every time we need it
Date: Tue, 21 Feb 2017 13:35:59 +0000
Message-ID: <20170221133559.GC23954@ct-lt-587>
References: <20170131161147.17002-1-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34947 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbdBUNfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 08:35:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so19712397wmu.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Feb 2017 05:35:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170131161147.17002-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, edubezval@gmail.com, rui.zhang@intel.com, orjan.eide@arm.com, chris.diamand@arm.com

On Tue, Jan 31, 2017 at 04:11:44PM +0000, Lukasz Luba wrote:
> Hi,
> 
> This patchset introduces a new interface for devfreq cooling in thermal
> framework. The previous version of the patch can be seen here [1].
> I have simplified the implementation and introduced resource utilization
> scaling factor.
> 
> The current implementation in the thermal devfreq cooling subsystem uses
> pre-calculated power table for each device to make a decision about allowed
> running state. When the driver registers itself to the thermal devfreq cooling
> subsystem, the framework creates the power table.
> The power table is then used by the thermal subsystem to keep
> the device in the thermal envelope.
> In the previous implementation the pre-calculated device's power
> table was scaled by current 'utilization'
> ('busy_time' and 'total_time' taken from devfreq 'last_status').
> 
> This idea meets the expectations of the devices which know better the actual
> power that they consume (thanks to power counters). When some
> parts/features of the device are not used the power value might be lower,
> while the frequency and utilization are the same.
> 
> The proposed implementation provides possibility to register a driver to
> thermal devfreq cooling subsystem and use the driver's code during the
> calculation of the power in runtime.
> 
> The device driver can still use pre-calculated power table when these new
> functions are not provided (the new extension can co-exist with old
> implementation).
> 
> The first patch contains some refactoring for getting the voltage,
> the second implements the new feature, the third one changes trace function.
> Patchset is based on v4.10-rc5.
> 
> Changes v2: 
> - removed 'flags' and power2state function,
> - split into a few patches,
> - simplified the logic of the new interface,
> - added resource utilization scaling factor,
> 
> Regards,
> Lukasz Luba
> 
> [1] https://marc.info/?l=linux-pm&m=147395070729989&w=2
> 
> 
> Lukasz Luba (3):
>   thermal: devfreq_cooling: refactor code and add get_voltage function
>   thermal: devfreq_cooling: add new interface for direct power read
>   trace: thermal: add another parameter *power to the tracing function
> 

For the series:

Acked-by: Javi Merino <javi.merino@kernel.org>

Thanks!
Javi
