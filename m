From: Michael Tatarinov <kukabu@gmail.com>
Subject: Re: [PATCH v2] of: thermal: Introduce "linux,hwmon" optional property
Date: Fri, 6 Oct 2017 06:44:25 +0400
Message-ID: <CABrG=Zyu9AN8D4uz=xLiarxL_2cvh6m7xUyeY6P+7gjYQDZr6Q@mail.gmail.com>
References: <20171005084206.2914-1-kukabu@gmail.com> <510ceb7b-7e01-2054-008f-e018079f891f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37114 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdJFCo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 22:44:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id k66so5951013wmd.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2017 19:44:27 -0700 (PDT)
In-Reply-To: <510ceb7b-7e01-2054-008f-e018079f891f@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hello

2017-10-05 18:57 GMT+04:00, Sudeep Holla <sudeep.holla@arm.com>:
> Please add devicetree bindings mailing list when you are add such
> generic and linux specific bindings. For now, I disagree on the approach
> unless you convince that's the only way on devicetree list and get
> ACK from DT binding maintainers.

OK, I will do it after deciding your next issue

> On 05/10/17 09:42, Michael Tatarinov wrote:
>> Introduce an optional property called "linux,hwmon", which enable
>> registration in hwmon subsystems.
>>
>
> Both the commit and the property binding seem to conflict with the
> comment in Documentation/thermal/sysfs-api.txt
>
> It states "when no_hwmon == false, a hwmon sysfs interface will be
> created" while you seem to indicate that this is required to register
> to hwmon subsystems.
>
> If it's just to enable this sysfs access, then binding seems a bit of
> misuse.

You're right but if the property is "linux,no_hwmon" we've enabled
this for all drivers by default.
I do not want to change the default behavior.

>
> --
> Regards,
> Sudeep
>
