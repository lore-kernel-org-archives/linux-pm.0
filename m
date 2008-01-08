From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [linux-pm] Re: Unify arch/x86/kernel/acpi/sleep*.c
Date: Tue, 8 Jan 2008 10:46:23 +0100
Message-ID: <20080108094623.GH27671@elte.hu>
References: <20080107122305.GA11062@elf.ucw.cz> <200801071741.02577.rjw@sisk.pl> <200801080148.14208.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758035AbYAHJq7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200801080148.14208.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Monday, 7 of January 2008, Rafael J. Wysocki wrote:
> > On Monday, 7 of January 2008, Pavel Machek wrote:
> > > Unify arch/x86/kernel/acpi/sleep*.c
> > > 
> > > Pretty trivial unification; when two functions differed, it was
> > > usually in error handling, and better of the two was picked up.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > Looks-okay-to: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > > ---
> > > 
> > > (Seems to work on i386, but needs some x86-64 testing.)
> > 
> > I'll test it later today.
> 
> Tested, works.

thanks - i've picked up Pavel's patch for x86.git and have added:

 Looks-okay-to: Rafael J. Wysocki <rjw@sisk.pl>
 Tested-by: Rafael J. Wysocki <rjw@sisk.pl>

Len, is this fine with you too, or do you have any outstanding 
fixes/changes in this area?

	Ingo
