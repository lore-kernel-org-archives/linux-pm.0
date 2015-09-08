From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v5 0/5] Let the power allocator thermal governor run on
 any thermal zone
Date: Tue, 8 Sep 2015 09:46:23 +0800
Message-ID: <CAGS+omDj_mtvYc-w1BLSVhXNO-xX3xY_7dHnHUczXMsRAycA=w@mail.gmail.com>
References: <1440595604-27197-1-git-send-email-javi.merino@arm.com> <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35131 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbIHBqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 21:46:43 -0400
Received: by ykdu9 with SMTP id u9so22289474ykd.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 18:46:43 -0700 (PDT)
In-Reply-To: <1441631969-3272-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chung-yih Wang <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Javi,

On Mon, Sep 7, 2015 at 9:19 PM, Javi Merino <javi.merino@arm.com> wrote:
> Relax the thermal governor requirements of sustainable_power and at
> least two trip points so that it can be bound to any thermal zone.
> Its behavior won't be optimal, it would be the best possible with the
> data provided.

I tested this whole series on my MT8173 board with a battery thermal
zone with no trip points, so, for this whole series (not sure if both
are needed, so take your pick):

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>

I am a bit confused by MAINTAINERS for drivers/thermal.
Will these patches be picked up by Eduardo or Zhang?

Thanks!
-Dan

> Changes since v4:
>    - Fix crash when a thermal zone with no trip points has no
>      get_trip_point_temp().  Reported by Daniel Kurtz.
>    - s/estimate_controller_constants()/estimate_pid_constants()/g
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
>  drivers/thermal/power_allocator.c         | 243 ++++++++++++++++++++++--------
>  drivers/thermal/thermal_core.c            |  28 ++++
>  include/linux/thermal.h                   |   6 +
>  4 files changed, 214 insertions(+), 65 deletions(-)
>
> --
> 1.9.1
>
