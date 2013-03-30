From: "devendra.aaru" <devendra.aaru@gmail.com>
Subject: potential NULL dereference at get_target_state in drivers/thermal/fair_share.c
Date: Sat, 30 Mar 2013 15:35:37 +0530
Message-ID: <CAHdPZaOiONMyRdMsYVEQYeMjNsMQb3LG8zfKC0GYJNRtfAVPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:53937 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab3C3KFi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Mar 2013 06:05:38 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so1003951wgg.4
        for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2013 03:05:37 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

Hello Zhang, Durgadoss,

I have found a code that does this cdev->ops->get_max_state

static long get_target_state(struct thermal_zone_device *tz,
                struct thermal_cooling_device *cdev, int weight, int level)
{
        unsigned long max_state;

        cdev->ops->get_max_state(cdev, &max_state);

        return (long)(weight * level * max_state) / (100 * tz->trips);
}

as the ops can be NULL the panic can occur. if not i have to check for
a valid get_max_state pointer. so if the ops->get_max_state is NULL
what should i suppose to be returning here?

thanks a lot,
