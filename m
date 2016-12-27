From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Tue, 27 Dec 2016 14:04:50 -0200
Message-ID: <CAOMZO5DA6aaMt=YEAKcormYUcmN0uuRBHqi=yFB78-peyRohHg@mail.gmail.com>
References: <1482843640-25255-1-git-send-email-festevam@gmail.com> <a48feeaa-c2b4-c8b1-bb18-915bf84e64de@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34424 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbcL0QEw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 11:04:52 -0500
Received: by mail-oi0-f66.google.com with SMTP id 3so19640578oih.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 08:04:52 -0800 (PST)
In-Reply-To: <a48feeaa-c2b4-c8b1-bb18-915bf84e64de@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>

On Tue, Dec 27, 2016 at 1:24 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Interesting way of defeating the purpose ;-).

Yes, that's why I marked it as RFC. Thanks for your feedback.


> Any interest in at least trying (NULL, hwmon->type, hwmon, NULL, NULL) ?

Yes, it works.

> This should result in the core taking care of creating the 'name'
> attribute, so it should be possible to drop the code doing that from
> the thermal driver.

Correct. I had to remove the device_create_file() call from the
thermal driver so that it can successfully probe.

Will resend it soon, thanks!
