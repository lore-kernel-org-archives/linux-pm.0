From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/4] PM: Print wall time at suspend & hibernate entry
 and exit
Date: Wed, 19 Jul 2017 22:40:40 +0200
Message-ID: <CAJZ5v0iVwUy5fdvYu=6HEwLPpw7g6owbFuwNpUJcb_iJ3LCFMA@mail.gmail.com>
References: <20170719194600.29210-1-salyzyn@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34069 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbdGSUkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 16:40:41 -0400
In-Reply-To: <20170719194600.29210-1-salyzyn@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Salyzyn <salyzyn@android.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-rtc@vger.kernel.org

On Wed, Jul 19, 2017 at 9:45 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> Permits power state and battery life diagnosis.
>
> Since one is not guaranteed to have a persistent hardware clock to
> report Suspended for in milliseconds, we report at a higher level
> at just the entry and exit points for suspend and hibernate.
>
> Feature activated by CONFIG_RTC_SHOW_TIME_*
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>
> v2:
> - merge suspend and hibernate into a single patch

So now I guess you realize that this conflicts with
https://patchwork.kernel.org/patch/9850217/ and it actually would make
sense for it to go on top of that?

Thanks,
Rafael
