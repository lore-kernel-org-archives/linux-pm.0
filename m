From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 7/8] power: bq27xxx_battery: Define access methods to
 write chip registers
Date: Sat, 4 Feb 2017 01:35:22 -0800
Message-ID: <CAKvHMgQ2mDq+pM5S_eY_vAOb4v-TwK=m=PKS6ZxJNUj_3wzxzQ@mail.gmail.com>
References: <20170204091603.32242-1-liam@networkimprov.net> <20170204091603.32242-8-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36239 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdBDJfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:35:23 -0500
Received: by mail-it0-f66.google.com with SMTP id f200so3782967itf.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Feb 2017 01:35:23 -0800 (PST)
In-Reply-To: <20170204091603.32242-8-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org

On Sat, Feb 4, 2017 at 1:16 AM, Liam Breck <liam@networkimprov.net> wrote:
> From: Liam <github@networkimprov.net>
>
> From: Matt Ranostay <matt@ranostay.consulting>
>
> write(), read_bulk(), write_bulk() support setting chip registers,
> e.g. with data obtained from power_supply_battery_info.
>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Pls drop the first From line; Matt's is the correct one.
git-send-email doesn't check for an extant From line :-/
