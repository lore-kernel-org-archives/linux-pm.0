From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / suspend: Add suspend_target_state()
Date: Mon, 17 Jul 2017 23:03:09 +0200
Message-ID: <CAJZ5v0gJQHUMEXTbvb0q6rmW-1xuRWAwGMmo_CCE8mYj-xf5QA@mail.gmail.com>
References: <20170716023610.4658-1-f.fainelli@gmail.com> <20170717200628.7018-1-f.fainelli@gmail.com>
 <20170717201631.GA13024@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38064 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdGQVDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 17:03:10 -0400
In-Reply-To: <20170717201631.GA13024@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 17, 2017 at 10:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Have the core suspend/resume framework store the system-wide suspend
>> state (suspend_state_t) we are about to enter, and expose it to drivers
>> via suspend_target_state() in order to retrieve that. The state is
>> assigned in suspend_devices_and_enter().
>
> Do we really want to have variable + inline functions that just read
> that variable?

Florian, Pavel is right, you can simply export the variable.

Anything accessing it should go under CONFIG_PM_SLEEP anyway.

Thanks,
Rafael
