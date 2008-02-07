From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 07 Feb 2008 14:44:27 -0800
Message-ID: <47AB89CB.7010908@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz> <200802072340.06138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934691AbYBGWp2@vger.kernel.org>
In-Reply-To: <200802072340.06138.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> -	rep; stosl
> +	rep
> +	stosl

Yuck!

Please don't perpetuate the braindamage that this is two instructions. 
It's one instruction with a modifier; the fact that gas wants a 
separator is broken enough as it is.

	-hpa
