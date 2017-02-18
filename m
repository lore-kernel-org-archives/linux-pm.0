From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH trivial 4/4] PM / Documentation: Spelling s/wrtie/write/
Date: Sat, 18 Feb 2017 02:19:57 +0100
Message-ID: <2312756.vT8pqHgMWZ@aspire.rjw.lan>
References: <1487345799-1638-1-git-send-email-geert+renesas@glider.be> <1487345799-1638-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44845 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752384AbdBRBY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 20:24:57 -0500
In-Reply-To: <1487345799-1638-4-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Friday, February 17, 2017 04:36:39 PM Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> ---
>  Documentation/power/states.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/states.txt b/Documentation/power/states.txt
> index 008ecb588317bc1d..bc4548245a243134 100644
> --- a/Documentation/power/states.txt
> +++ b/Documentation/power/states.txt
> @@ -25,7 +25,7 @@ to be used subsequently to change to the one represented by that string.
>  Consequently, there are two ways to cause the system to go into the
>  Suspend-To-Idle sleep state.  The first one is to write "freeze" directly to
>  /sys/power/state.  The second one is to write "s2idle" to /sys/power/mem_sleep
> -and then to wrtie "mem" to /sys/power/state.  Similarly, there are two ways
> +and then to write "mem" to /sys/power/state.  Similarly, there are two ways
>  to cause the system to go into the Power-On Suspend sleep state (the strings to
>  write to the control files in that case are "standby" or "shallow" and "mem",
>  respectively) if that state is supported by the platform.  In turn, there is
> 

Applied.

Thanks,
Rafael
