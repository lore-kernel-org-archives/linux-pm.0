From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Mon, 15 Jan 2018 16:09:26 -0200
Message-ID: <CAOMZO5ABFzGTBrsO-QEM+fAjbeaOgP2hUQ5ErYiaQTF6Yg0YmA@mail.gmail.com>
References: <1514976294-31880-1-git-send-email-festevam@gmail.com>
 <1515851277.4764.2.camel@intel.com> <ba61b31f-74c0-7213-7d6c-7f4c80ee07e0@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:46395 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbeAOSJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 13:09:27 -0500
Received: by mail-oi0-f52.google.com with SMTP id d124so8840577oib.13
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2018 10:09:27 -0800 (PST)
In-Reply-To: <ba61b31f-74c0-7213-7d6c-7f4c80ee07e0@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Arthur Borsboom <arthurborsboom@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Pavel Machek <pavel@ucw.cz>

On Sat, Jan 13, 2018 at 7:17 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> I bet it gets confused by the quotes.

In this particular case I think we should ignore checkpatch reported error.

Thanks
