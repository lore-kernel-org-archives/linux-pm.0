From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Sat, 13 Jan 2018 12:04:00 -0200
Message-ID: <CAOMZO5DsWTebOLzWodV8fpNiFCDLbY=gdP_qZVnd-7032o1E8Q@mail.gmail.com>
References: <1514976294-31880-1-git-send-email-festevam@gmail.com> <1515851277.4764.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33894 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754987AbeAMOEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jan 2018 09:04:02 -0500
Received: by mail-oi0-f42.google.com with SMTP id a70so5710163oib.1
        for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2018 06:04:02 -0800 (PST)
In-Reply-To: <1515851277.4764.2.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Arthur Borsboom <arthurborsboom@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Pavel Machek <pavel@ucw.cz>, Guenter Roeck <linux@roeck-us.net>

Hi Rui,

On Sat, Jan 13, 2018 at 11:47 AM, Zhang Rui <rui.zhang@intel.com> wrote:

> the commit id is 7611fb68062f.

Thanks, will fix it in v2.

> don't know why but checkpatch.pl always complains
>
> ERROR: Please use git commit description style 'commit <12+ chars of
> sha1> ("<title line>")' - ie: 'commit 3feb479cea37 ("Revert "thermal:
> thermal_hwmon: Convert to hwmon_device_register_with_info()"")'
> #37:
> , leading to a revert in commit 3feb479cea37 ("Revert "thermal:
>
> total: 1 errors, 0 warnings, 49 lines checked

Yes, not sure why checkpatch complains on this one too.

I am not able to see anything wrong with the commit description.

Thanks
