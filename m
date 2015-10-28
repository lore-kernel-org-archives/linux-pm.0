From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL] cpuidle for 4.4
Date: Wed, 28 Oct 2015 04:05:41 +0100
Message-ID: <8456769.2RKeY76Px5@vostro.rjw.lan>
References: <562A1FE0.1060302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44089 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751402AbbJ1Cgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 22:36:44 -0400
In-Reply-To: <562A1FE0.1060302@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, October 23, 2015 01:54:08 PM Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> this pull request contains a couple of changes from Russel King.
> 
>   - Disable bind/unbind attribute and use builtin_platform_driver for 
> mvebu (Russell King)
> 
>   - Clean up the code by removing the multiple platform drivers and use 
> the platform ID instead (Russell King)
> 
> Thanks !
> 
>    -- Daniel
> 
> The following changes since commit 7379047d5585187d1288486d4627873170d0005a:
> 
>    Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)
> 
> are available in the git repository at:
> 
>    http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.4
> 
> for you to fetch changes up to ab319939a58678c19a68ff10c8a08cef462a3ba6:
> 
>    cpuidle: mvebu: disable the bind/unbind attributes and use 
> builtin_platform_driver (2015-10-23 12:40:48 +0200)
> 
> ----------------------------------------------------------------
> Russell King (2):
>        cpuidle: mvebu: clean up multiple platform drivers
>        cpuidle: mvebu: disable the bind/unbind attributes and use 
> builtin_platform_driver
> 
>   drivers/cpuidle/cpuidle-mvebu-v7.c | 46 
> +++++++++++++++++++++-------------------------
>   1 file changed, 21 insertions(+), 25 deletions(-)

Pulled, thanks!

Rafael

