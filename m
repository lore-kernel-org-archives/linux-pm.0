From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 8/8] power: bq27xxx_battery: Add BQ27425 chip id
Date: Sat, 4 Feb 2017 01:32:48 -0800
Message-ID: <CAKvHMgSiUgMb=GyvAFrQmSbONA1obYA=aY7GXLmJGvnjTg81pQ@mail.gmail.com>
References: <20170204091603.32242-1-liam@networkimprov.net> <20170204091603.32242-9-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36575 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdBDJct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:32:49 -0500
Received: by mail-io0-f194.google.com with SMTP id q20so4521475ioi.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Feb 2017 01:32:49 -0800 (PST)
In-Reply-To: <20170204091603.32242-9-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org

On Sat, Feb 4, 2017 at 1:16 AM, Liam Breck <liam@networkimprov.net> wrote:
> From: networkimprov <github@networkimprov.net>
>
> From: Matt Ranostay <matt@ranostay.consulting>
>
> This patch does not alter the function of the driver.
> This chip ID is referenced in the devicetree code.
>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Pls drop the first From line; Matt's is the correct one.
git-send-email doesn't check for an extant From line :-/
