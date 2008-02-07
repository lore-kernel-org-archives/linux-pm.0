From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 07 Feb 2008 14:45:35 -0800
Message-ID: <47AB8A0F.9@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz> <200802072340.06138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762391AbYBGWqY@vger.kernel.org>
In-Reply-To: <200802072340.06138.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:

>  ENTRY(wakeup_long64)
>  wakeup_long64:
> -	movq    saved_magic, %rax
> -	movq    $0x123456789abcdef0, %rdx
> -	cmpq    %rdx, %rax
> -	jne     bogus_64_magic
> +	movq	saved_magic, %rax
> +	movq	$0x123456789abcdef0, %rdx
> +	cmpq	%rdx, %rax
> +	jne	bogus_64_magic

A random magic is probably more likely to be unique than something like 
that.

	-hpa
