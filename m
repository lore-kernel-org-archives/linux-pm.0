From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [linux-pm] Re: [rft] s2ram wakeup moves to .c, could fix few
 machines
Date: Fri, 08 Feb 2008 13:27:30 -0800
Message-ID: <47ACC942.1020308@zytor.com>
References: <20080208210004.GA12923@elf.ucw.cz> <Pine.LNX.4.44L0.0802081617280.5958-100000@iolanthe.rowland.org> <20080208212317.GD12923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757308AbYBHV20@vger.kernel.org>
In-Reply-To: <20080208212317.GD12923@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> 
> See arch/x86/kernel/acpi/realmode/wakeup.S (the version that was sent
> to the list). No problem there, but table stored at nonzero
> offset. Short jump at the beggining of table would fix it (ugly).
> 

Ugly, but it's the standard way to deal.  We have it in the bzImage 
format, too.

	-hpa
