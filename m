From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] cpu: expose pm_qos_resume_latency for each cpu
Date: Tue, 13 Sep 2016 09:17:17 +0200
Message-ID: <CAPDyKFovPNBv+Fx5SgzrD6Fn+1qOfXnS=Fm0cHB=0CWKMUHrSg@mail.gmail.com>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-2-git-send-email-alex.shi@linaro.org> <57C7A597.4050001@linaro.org>
 <CAPDyKFra5YRUPB7a2th6K1hnK=PUz9k27d6DNNoVaJ76QSWe3w@mail.gmail.com> <57D750BA.6010305@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37522 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbcIMHRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 03:17:20 -0400
Received: by mail-wm0-f52.google.com with SMTP id c131so95837034wmh.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2016 00:17:19 -0700 (PDT)
In-Reply-To: <57D750BA.6010305@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 13 September 2016 at 03:04, Alex Shi <alex.shi@linaro.org> wrote:
> Cc Rafael.
>
> On 09/01/2016 05:26 PM, Ulf Hansson wrote:
>> In general I think the change makes sense, although it's this last
>> piece here that I wonder about.
>>
>> Is it okay that we expose sysfs attributes to userspace that don't
>> have any effect if they change the values? Perhaps it should be the
>> responsibility of the menu governor somehow to expose the sysfs nodes
>> instead? Unless there are some difficulties that prevents us from that
>> of course.
>>
>
> Hi Ulf,
>
> Sorry for response so late. The pm QoS designed to expose this interface
> in userspace. Root user can change this value and made effect on device
> sleeping status. That's required.

Sure, I understand that. Although, my point is that it's only when the
menu governor is enabled, that it would make sense for userspace to
modify the PM QoS values for the cpu device.

>
> Since this is per device interface, set it on menu governor isn't so good.

You may be right, and it's not a big deal for me! It was just an idea.

Kind regards
Uffe
