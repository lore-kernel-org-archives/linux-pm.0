From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Tue, 05 Feb 2008 17:51:22 -0800
Message-ID: <47A9129A.7050706@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <47A90F23.80009@zytor.com> <200802060242.15097.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763558AbYBFBvp@vger.kernel.org>
In-Reply-To: <200802060242.15097.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
>> The asm() for making beeps really need to be moved to a function and 
>> cleaned up (redone in C using inb()/outb()) if they are to be retained 
>> at all.
> 
> Yes, they are.  For some people they're the only tool to debug broken resume.

That's fine, but they should get cleaned up.

/me is tempted to provide a version which can send messages in Morse Code ;)

	-hpa
