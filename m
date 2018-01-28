From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND][PATCH] tools/power: Don't make man pages executable
Date: Sun, 28 Jan 2018 12:50:52 -0500
Message-ID: <CAJvTdKmyZGE-uq9poCgmobdGwgqP-US1tBKk204wjU++g5Ayhg@mail.gmail.com>
References: <20171220040231.5592-1-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34708 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeA1Rux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jan 2018 12:50:53 -0500
In-Reply-To: <20171220040231.5592-1-labbott@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

Applied.

thanks!
-Len


On Tue, Dec 19, 2017 at 11:02 PM, Laura Abbott <labbott@redhat.com> wrote:
> rpm-lint flagged these as being executable:
>
> kernel-tools.x86_64: W: spurious-executable-perm /usr/share/man/man8/turbostat.8.gz
> kernel-tools.x86_64: W: spurious-executable-perm /usr/share/man/man8/x86_energy_perf_policy.8.gz
>
> Fix this
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Resent for linux-pm cc
> ---
>  tools/power/x86/turbostat/Makefile              | 2 +-
>  tools/power/x86/x86_energy_perf_policy/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
> index a9bc914a8fe8..2ab25aa38263 100644
> --- a/tools/power/x86/turbostat/Makefile
> +++ b/tools/power/x86/turbostat/Makefile
> @@ -25,4 +25,4 @@ install : turbostat
>         install -d  $(DESTDIR)$(PREFIX)/bin
>         install $(BUILD_OUTPUT)/turbostat $(DESTDIR)$(PREFIX)/bin/turbostat
>         install -d  $(DESTDIR)$(PREFIX)/share/man/man8
> -       install turbostat.8 $(DESTDIR)$(PREFIX)/share/man/man8
> +       install -m 644 turbostat.8 $(DESTDIR)$(PREFIX)/share/man/man8
> diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
> index 2447b1bbaacf..f4534fb8b951 100644
> --- a/tools/power/x86/x86_energy_perf_policy/Makefile
> +++ b/tools/power/x86/x86_energy_perf_policy/Makefile
> @@ -24,5 +24,5 @@ install : x86_energy_perf_policy
>         install -d  $(DESTDIR)$(PREFIX)/bin
>         install $(BUILD_OUTPUT)/x86_energy_perf_policy $(DESTDIR)$(PREFIX)/bin/x86_energy_perf_policy
>         install -d  $(DESTDIR)$(PREFIX)/share/man/man8
> -       install x86_energy_perf_policy.8 $(DESTDIR)$(PREFIX)/share/man/man8
> +       install -m 644 x86_energy_perf_policy.8 $(DESTDIR)$(PREFIX)/share/man/man8
>
> --
> 2.14.3
>



-- 
Len Brown, Intel Open Source Technology Center
