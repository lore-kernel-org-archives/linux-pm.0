From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] cpuidle patches for merge
Date: Thu, 24 Mar 2016 13:55:06 +0100
Message-ID: <CAJZ5v0i1RaE8zUORDHUGV_+r2E7-kMBUQvvZ-858pw_dko0WDQ@mail.gmail.com>
References: <CAJvTdKkCFLxRhSgyZRriq=kP8enWnXS7FH6HORw-cc5tK_yJqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36089 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422AbcCXMzS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 08:55:18 -0400
Received: by mail-lf0-f68.google.com with SMTP id r8so3539459lfe.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 05:55:12 -0700 (PDT)
In-Reply-To: <CAJvTdKkCFLxRhSgyZRriq=kP8enWnXS7FH6HORw-cc5tK_yJqw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Rafael Wysocki <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Mar 24, 2016 at 6:23 AM, Len Brown <lenb@kernel.org> wrote:
> Hi Rafael,
>
> Please pull these two cpuidle patches

Pulled, thanks!


> The following changes since commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc:
>
>   Linux 4.4 (2016-01-10 15:01:32 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git cpuidle
>
> for you to fetch changes up to 281baf7a702693deaa45c98ef0c5161006b48257:
>
>   intel_idle: Support for Intel Xeon Phi Processor x200 Product Family
> (2016-03-23 16:19:38 -0400)
>
> ----------------------------------------------------------------
> Dasaratharaman Chandramouli (1):
>       intel_idle: Support for Intel Xeon Phi Processor x200 Product Family
>
> Len Brown (1):
>       intel_idle: prevent SKL-H boot failure when C8+C9+C10 enabled
>
>  drivers/idle/intel_idle.c | 133 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 111 insertions(+), 22 deletions(-)
