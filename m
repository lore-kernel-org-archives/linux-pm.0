From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/5] scripts: AnalyzeSuspend v4.2
Date: Thu, 14 Jul 2016 23:22:42 +0200
Message-ID: <CAJZ5v0gSrwcBC-A-g6Pf_eMJ904zZdRkB591w844bwU6pL8qEQ@mail.gmail.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35436 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbcGNVWo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 17:22:44 -0400
Received: by mail-wm0-f43.google.com with SMTP id f65so4107758wmi.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2016 14:22:43 -0700 (PDT)
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, todd.e.brandt@intel.com

On Thu, Jul 14, 2016 at 11:09 PM, Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
> AnalyzeSuspend v4.2
>
>   kprobe support for function tracing
>   config file support in lieu of command line options
>   advanced callgraph support for function debug
>   dev mode for monitoring common sources of delay, e.g. msleep, udelay
>   many bug fixes and formatting upgrades
>
> Todd Brandt (5):
>   AnalyzeSuspend v4.2 part1
>   AnalyzeSuspend v4.2 part2
>   AnalyzeSuspend v4.2 part3
>   AnalyzeSuspend v4.2 part4
>   AnalyzeSuspend v4.2 part5
>
>  scripts/analyze_suspend.py | 3641 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 2474 insertions(+), 1167 deletions(-)
>
> --

Can you please tell me what specifically goes into each of the patches?

Thanks,
Rafael
