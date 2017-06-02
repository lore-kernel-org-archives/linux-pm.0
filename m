From: Tom Lanyon <tom@oneshoeco.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Fri, 2 Jun 2017 11:06:49 +1000
Message-ID: <CA+b4Kqf9YN0x+Sc6Lk28FLD8-iaHnjS74MQV2yMyS599fe5HTw@mail.gmail.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <3454366.uzaJljlWGm@aspire.rjw.lan>
 <1496313803.28981.45.camel@linux.intel.com> <CA+b4KqcxKNaHMTEG3KQOQ98OFmwS+R8PLdfyZB1tastH5m0XVQ@mail.gmail.com>
 <CAJZ5v0j_jA68cai4mV85DV7QTVh77BcrWv7mnotZ6XKtXO57Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37379 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdFBBHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 21:07:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id d127so8755688wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2017 18:07:11 -0700 (PDT)
In-Reply-To: <CAJZ5v0j_jA68cai4mV85DV7QTVh77BcrWv7mnotZ6XKtXO57Wg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>

On 2 June 2017 at 00:59, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Quoting from my cover letter:
>
> "After this series there still is a concern regarding the possible increase of
> power draw that may result from the processing of non-wakeup EC events while
> suspended which is why the change only affects Dell XPS13 9360 and 9365
> for now."
>
> So that is what happens, unfortunately, and we can't do much about it
> at the moment.

OK, but at the moment this is a regression in functionality on those
platforms. Without this patchset, I can successfully s2idle
suspend/resume on an XPS 9365 (albeit with a little bit of awkward
fiddling of the power button to resume). After the patchset, I can't
realistically go into s2idle at all.

> The only way to avoid that would be to reconfigure the EC during
> suspend to stop generating non-wakeup events, but today we have no
> reliable way to do that.

I thought I had read one one of the threads that this was possible in
the same way that it is for Windows on these laptops.  What's missing
to make this possible?

Tom
