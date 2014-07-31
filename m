From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: tell cooling devices when a trip_point changes
Date: Thu, 31 Jul 2014 08:59:25 +0100
Message-ID: <20140731075924.GA2791@e104805>
References: <53D97B70.1050305@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36171 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbaGaH72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 03:59:28 -0400
In-Reply-To: <53D97B70.1050305@nvidia.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Longnecker <mlongnecker@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 31, 2014 at 12:10:40AM +0100, Matt Longnecker wrote:
> Some hardware can react autonomously at a programmed temperature.
> For example, an SoC might implement a last ditch throttle or a
> hardware thermal shutdown. The driver for such a device can
> register itself as a cooling_device with the thermal framework.
> 
> With this change, the thermal framework notifies such a driver
> when userspace alters the relevant trip temperature so that
> the driver can reprogram its hardware

Why can't you just use the existing cooling device interface?  Cooling
devices can be bound to trip points.  Most thermal governors will
increase cooling for that cooling device when the trip point is hit.
The last ditch throttle or hardware thermal shutdown will then kick
when the cooling state changes to 1.

If the existing governors are too complex for what you want, you can
have a look at the bang bang governor[0] which (I think) is bound to
be merged soon.

[0] http://article.gmane.org/gmane.linux.kernel/1753348

Cheers,
Javi

