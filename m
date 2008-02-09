From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 08 Feb 2008 16:32:08 -0800
Message-ID: <47ACF488.7070502@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802082301.51582.rjw@sisk.pl> <20080208220834.GA1631@elf.ucw.cz> <200802090118.50418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759018AbYBIAdc@vger.kernel.org>
In-Reply-To: <200802090118.50418.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> 
> Consolidated patch is appended.  I'll test it tomorrow on x86-64.
> 
> I'd like to add the cleaned up beeping code to it and perhaps try to push it
> for -mm testing without any further changes.  We can still do more cleanups in
> followup patches.
> 

The other thing to figure out is to what extent we can clean up the 
conditionals in the video mode code by refactoring.  All they really do 
here is save space by removing functionality not needed for wakeup, 
because I didn't know how much space was realistic.

It's possible we can remove them altogether by having a dummy 
boot_params structure (4K).

	-hpa
