From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Tue, 13 Sep 2016 09:04:58 +0800
Message-ID: <57D750BA.6010305@linaro.org>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org>
 <57C7A597.4050001@linaro.org>
 <CAPDyKFra5YRUPB7a2th6K1hnK=PUz9k27d6DNNoVaJ76QSWe3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35452 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbcIMBFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 21:05:07 -0400
Received: by mail-pf0-f177.google.com with SMTP id z123so3639120pfz.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2016 18:05:06 -0700 (PDT)
In-Reply-To: <CAPDyKFra5YRUPB7a2th6K1hnK=PUz9k27d6DNNoVaJ76QSWe3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Cc Rafael.

On 09/01/2016 05:26 PM, Ulf Hansson wrote:
> In general I think the change makes sense, although it's this last
> piece here that I wonder about.
> 
> Is it okay that we expose sysfs attributes to userspace that don't
> have any effect if they change the values? Perhaps it should be the
> responsibility of the menu governor somehow to expose the sysfs nodes
> instead? Unless there are some difficulties that prevents us from that
> of course.
> 

Hi Ulf,

Sorry for response so late. The pm QoS designed to expose this interface
in userspace. Root user can change this value and made effect on device
sleeping status. That's required.

Since this is per device interface, set it on menu governor isn't so good.

Regards
Alex
