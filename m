From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 08 Feb 2008 13:18:16 -0800
Message-ID: <47ACC718.5060508@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <47AB975C.1010902@zytor.com> <20080208070419.GA4544@ucw.cz> <200802081723.16354.rjw@sisk.pl> <20080208210004.GA12923@elf.ucw.cz> <47ACC381.9070601@zytor.com> <20080208210905.GB12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755414AbYBHVSf@vger.kernel.org>
In-Reply-To: <20080208210905.GB12923@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:

> 
> Indirect call from where?
> 
> BIOS jumps to address you provide.
> 
>> Where is this code?
> 
> arch/x86/kernel/acpi/realmode/wakeup.S
> 
> BIOS jumps to wakeup_code. With CS=something, IP=0. If wakeup code is
> at other address than zero, I'll not be able to easily address data
> below it.
> 								Pavel

Ah, okay.  Yes, the canonical way to deal with that is to put a short 
jump at the top.

	-hpa
