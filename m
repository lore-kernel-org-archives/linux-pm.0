From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] turbostat fixes
Date: Tue, 27 Jun 2017 01:45:02 +0200
Message-ID: <CAJZ5v0g41qn+w4fPnkdj-boJo5gJtcQJH6q_GuH_B2UGp32vTA@mail.gmail.com>
References: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34873 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdFZXpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2017 19:45:03 -0400
Received: by mail-it0-f66.google.com with SMTP id v193so717663itc.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2017 16:45:03 -0700 (PDT)
In-Reply-To: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>

On Sun, Jun 25, 2017 at 5:12 AM, Len Brown <lenb@kernel.org> wrote:
> Hi Rafael,

Hi,

> Please pull these turbostat patches.
>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:
>
>   Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>
> for you to fetch changes up to f7d44a8f3fd7f13770470a306a233acbaad5e96d:
>
>   tools/power turbostat: update version number (2017-06-24 20:03:42 -0700)
>
> ----------------------------------------------------------------
> Len Brown (5):
>       tools/power turbostat: hide SKL counters, when not requested
>       tools/power turbostat: if  --debug, print sampling overhead
>       tools/power turbostat: stop migrating, unless '-m'
>       tools/power turbostat: decode MSR_IA32_MISC_ENABLE only on Intel
>       tools/power turbostat: update version number
>
>  tools/power/x86/turbostat/turbostat.c | 94 ++++++++++++++++++++++++++++-------
>  1 file changed, 77 insertions(+), 17 deletions(-)

Pulled, thanks!
