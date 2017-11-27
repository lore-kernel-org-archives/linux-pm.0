From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Something like devm_pm_runtime_enable desirable?
Date: Mon, 27 Nov 2017 02:21:10 +0100
Message-ID: <CAJZ5v0g_vg+ojdZs7fNwyPF3RVOMWW0aHB9jDKTV0nt5ivP7_Q@mail.gmail.com>
References: <66504d0c-1b30-8b36-fd11-bd9abc2eb41a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36832 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdK0BVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Nov 2017 20:21:11 -0500
Received: by mail-oi0-f43.google.com with SMTP id n16so18360655oig.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2017 17:21:10 -0800 (PST)
In-Reply-To: <66504d0c-1b30-8b36-fd11-bd9abc2eb41a@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Mon, Nov 27, 2017 at 12:13 AM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> I have a runtime pm enabled driver which uses device-managed resources
> only and therefore wouldn't need a remove callback. The remove callback
> does pm_runtime_disable only.
> Therefore I'm wondering whether something like devm_pm_runtime_enable
> would be desirable doing the pm_runtime_disable automagically.
>
> I can't really imagine that I'm the first one with this idea so I
> guess there is some reason why it doesn't exist yet ..

You also need to ensure that the device is left in the state in which
your driver will expect it to be in on the next probe in case the
driver module is unloaded and loaded again.  I'm not sure if devm_ can
do that generically enough.

Thanks,
Rafael
