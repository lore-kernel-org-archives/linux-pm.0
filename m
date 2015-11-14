From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: turbostat patches for 4.3
Date: Sat, 14 Nov 2015 01:43:29 +0100
Message-ID: <2635043.0vdY80h9bq@vostro.rjw.lan>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64132 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752196AbbKNAOG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 19:14:06 -0500
In-Reply-To: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org

On Thursday, November 12, 2015 02:42:28 AM Len Brown wrote:
> Hello Rafael,

Hi,

> Please pick up this small batch of turbostat patches.
> As usual, they are available on my turbostat branch.
> 
> thanks!
> -Len
> 
> [PATCH 1/4] tools/power turbostat: simplify Bzy_MHz calculation
> [PATCH 2/4] tools/power turbostat: bugfix: print MAX_NON_TURBO_RATIO
> [PATCH 3/4] tools/power turbostat: use new name for MSR_PLATFORM_INFO
> [PATCH 4/4] x86: remove unused definition of MSR_NHM_PLATFORM_INFO

I pulled from your branch on Wednesday and there were only [1-2/4] on it then.
That's what went to Linus on that day.

Today, I've noticed that you rebased the branch and it's generating conflicts
for me when pulled, so instead of pulling from it I've applied [3-4/4] directly
and I'm going to push them to Linus for -rc2.

Thanks,
Rafael

