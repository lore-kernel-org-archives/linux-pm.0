From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v4 0/5] Let the power allocator thermal governor run on
 any thermal zone
Date: Wed, 2 Sep 2015 16:11:13 +0100
Message-ID: <20150902151113.GD2694@e104805>
References: <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59529 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750743AbbIBPLS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 11:11:18 -0400
Content-Disposition: inline
In-Reply-To: <1440595604-27197-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "cywang@chromium.org" <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>

On Wed, Aug 26, 2015 at 02:26:39PM +0100, Javi Merino wrote:
> Relax the thermal governor requirements of sustainable_power and at
> least two trip points so that it can be bound to any thermal zone.
> Its behavior won't be optimal, it would be the best it can with the
> data provided.
> 
> Changes since v3:
>    - Don't hardcode a value for sustainable power and re-estimate
>      the PID controllers every time if no sustainable power is given
>      as suggested by Eduardo Valentin.
>    - power_actor_get_min_power() moved to a patch of its own.
> 
> Changes since v2:
>   - Typos suggested by Daniel Kurtz
> 
> Changes since v1:
>   - Let the power allocator governor operate if the thermal zone
>     doesn't have tzp as suggested by Chung-yih Wang
> 
> Javi Merino (5):
>   thermal: Add a function to get the minimum power
>   thermal: power_allocator: relax the requirement of a sustainable_power
>     in tzp
>   thermal: power_allocator: relax the requirement of two passive trip   
>      points
>   thermal: power_allocator: don't require tzp to be present for the
>     thermal zone
>   thermal: power_allocator: exit early if there are no cooling devices
> 
>  Documentation/thermal/power_allocator.txt |   2 +-
>  drivers/thermal/power_allocator.c         | 241 ++++++++++++++++++++++--------
>  drivers/thermal/thermal_core.c            |  28 ++++
>  include/linux/thermal.h                   |   6 +
>  4 files changed, 212 insertions(+), 65 deletions(-)

Gentle ping.
