From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
Date: Wed, 15 Jun 2016 01:26:23 +0200
Message-ID: <7230305.BYjCFel4WC@vostro.rjw.lan>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55699 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751332AbcFNXWP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2016 19:22:15 -0400
In-Reply-To: <1464870032-12289-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Pavel Machek <pavel@ucw.cz>

On Thursday, June 02, 2016 01:20:32 PM James Morse wrote:
> Kasan causes the compiler to instrument C code and is used at runtime to
> detect accesses to memory that has been freed, or not yet allocated.
> 
> The code in snapshot.c saves and restores memory when hibernating. This will
> access whole pages in the slab cache that have both free and allocated
> areas, resulting in a large number of false positives from Kasan.
> 
> Disable instrumentation of this file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> ---
> With this, I can hibernate/resume a kernel built with kasan on arm64.
> 
>  kernel/power/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index cb880a14cc39..eb4f717705ba 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -1,6 +1,8 @@
>  
>  ccflags-$(CONFIG_PM_DEBUG)	:= -DDEBUG
>  
> +KASAN_SANITIZE_snapshot.o	:= n
> +
>  obj-y				+= qos.o
>  obj-$(CONFIG_PM)		+= main.o
>  obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
> 

Applied, thanks!

Does the arch code need to be annotated in a similar way too?

