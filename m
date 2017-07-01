From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ondemand + p-state useful ?
Date: Sat, 1 Jul 2017 18:20:26 +0200
Message-ID: <CAJZ5v0hRORQ02kH6iOriCDJO++u+bZ1jHjDo-Dr_0R8K0q1KbA@mail.gmail.com>
References: <77b02581-5620-a773-ba13-8eec217497a3@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36596 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdGAQU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jul 2017 12:20:28 -0400
Received: by mail-io0-f182.google.com with SMTP id z62so37587846ioi.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Jul 2017 09:20:27 -0700 (PDT)
In-Reply-To: <77b02581-5620-a773-ba13-8eec217497a3@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Sat, Jul 1, 2017 at 11:59 AM, Toralf F=C3=B6rster <toralf.foerster@gmx.d=
e> wrote:
> I had few discussion with guys whether at an i5 (desktop) or an i7 (serve=
r) respectively it makes sense to have these defines
>
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_X86_INTEL_PSTATE=3Dy
>
> I was told that ondemand doesn't rules and performance is used, if pstate=
 is choosen.
>
> But OTOH I see differences  when I run powertop or similar tools.
> Especially the i5 has often a much lower frequency (800 MHz versus 1800 M=
Hz) when booting a kernel with ondemand+pstate instead of performance+pstat=
e.
>
> May I asked here for an advice ?

First, you can run intel_state with ondemand, but you need to pass
intel_pstate=3Dpassive to the kernel command line for that.

If you don't do that, intel_pstate will use its own internal P-state
selection algorithm, but it is not "performance" by default.

Please see https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_psta=
te.html
for details.

Thanks,
Rafael
