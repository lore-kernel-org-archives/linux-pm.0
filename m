From: Fabio Estevam <festevam@gmail.com>
Subject: Converting thermal_hwmon to use hwmon_device_register_with_info()
Date: Wed, 3 Jan 2018 01:17:43 -0200
Message-ID: <CAOMZO5BigLwphqrywLjoDUycUsfhHEBjJCUXaf8TjfHzBYV2hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:44878 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeACDRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 22:17:44 -0500
Received: by mail-ot0-f172.google.com with SMTP id g59so308033otg.11
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 19:17:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>
Cc: "rui.zhang" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Arthur Borsboom <arthurborsboom@gmail.com>

Hi Guenter and Pavel,

Commit 7611fb68062f ("thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()"). caused issues on N900 as reported
by Pavel and we had to revert it in commit 3feb479cea37.

If I understand correctly, Guenter's commit 74d3b6419772 ("hwmon:
Relax name attribute validation for new APIs") would prevent the error
that Pavel reported.

Is this correct?

Pavel, does N900 operate correctly with 3feb479cea37 reverted?

If this no longer causes issues, I would like to send a patch doing
the conversion to  hwmon_device_register_with_info() to avoid the
warning.

Thanks,

Fabio Estevam
