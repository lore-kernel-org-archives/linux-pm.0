From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: Unify arch/x86/kernel/acpi/sleep*.c
Date: Tue, 8 Jan 2008 01:48:13 +0100
Message-ID: <200801080148.14208.rjw@sisk.pl>
References: <20080107122305.GA11062@elf.ucw.cz> <200801071741.02577.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755968AbYAHAq3@vger.kernel.org>
In-Reply-To: <200801071741.02577.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 7 of January 2008, Rafael J. Wysocki wrote:
> On Monday, 7 of January 2008, Pavel Machek wrote:
> > Unify arch/x86/kernel/acpi/sleep*.c
> > 
> > Pretty trivial unification; when two functions differed, it was
> > usually in error handling, and better of the two was picked up.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> Looks-okay-to: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > ---
> > 
> > (Seems to work on i386, but needs some x86-64 testing.)
> 
> I'll test it later today.

Tested, works.

Thanks,
Rafael
