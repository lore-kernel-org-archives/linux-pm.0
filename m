From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Mon, 5 Jun 2017 22:58:37 +0200
Message-ID: <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
References: <20170605193157.59875-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37289 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 16:58:39 -0400
In-Reply-To: <20170605193157.59875-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>

On Mon, Jun 5, 2017 at 9:31 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> Permits power state and battery life diagnosis.

Which is possible even without this patch and we have tools for that
(analyze_suspend.py, anyone?).

Honestly, I don't see why this change is necessary or even useful.

Thanks,
Rafael
