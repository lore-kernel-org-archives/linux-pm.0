From: Dmitry Torokhov <dtor@google.com>
Subject: Re: Understanding pm_wakeup_event() call in acpi/button.c in acpi_lid_notify_state
Date: Thu, 15 Feb 2018 10:52:09 -0800
Message-ID: <CAE_wzQ9+oqKS8FSc=BP5fFezmF2pKabTrP75--NdQn=NFqXRvQ@mail.gmail.com>
References: <CAOGSYL0Oo-OLFZk9FxK1q92h3saMYnq+BOhR5DqyLmHahhS7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36846 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162019AbeBOSwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Feb 2018 13:52:12 -0500
Received: by mail-wr0-f177.google.com with SMTP id u15so694791wrg.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2018 10:52:11 -0800 (PST)
In-Reply-To: <CAOGSYL0Oo-OLFZk9FxK1q92h3saMYnq+BOhR5DqyLmHahhS7NQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ravi Chandra Sadineni <ravisadineni@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Rajat Jain <rajatja@google.com>

Hi Ravi,

On Thu, Feb 15, 2018 at 10:42 AM, Ravi Chandra Sadineni
<ravisadineni@google.com> wrote:
>
> Hi,
>
> we have a user space daemon that identifies wakeup source based on the
> device wakeup counts. We are facing issues with the ACPI buttons
> driver(acpi/buttons.c) as the wakeup_count increments immaterial of
> the wake source, if the lid is open.  The reason seems to be
> pm_wakeup_event() call in  acpi_lid_notify_state if the lid state is
> open.
>
>     if (state)
>            acpi_pm_wakeup_event(&device->dev);
>
>
>
> What is the reason for calling pm_wakeup_event() in
> acpi_lid_notify_state() which is in turn called  every time the lid is
> open on resume ? Can this be removed ?

I think you really want to signal the wakeup event on transitions to
open, can you try

if (state && do_update)
         acpi_pm_wakeup_event(&device->dev);

Thanks,
Dmitry
