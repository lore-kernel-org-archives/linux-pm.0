From: Len Brown <lenb@kernel.org>
Subject: Re: tsc breaks atkbd suspend
Date: Tue, 19 Feb 2008 19:17:36 -0500
Message-ID: <200802191917.36641.lenb@kernel.org>
References: <20080218133852.GA1573@elf.ucw.cz> <20080219140552.GC9965@elte.hu> <alpine.LFD.1.00.0802191748110.7583@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764058AbYBTASz@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.00.0802191748110.7583@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, jbohac@suse.cz, kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 February 2008 11:51, Thomas Gleixner wrote:
> On Tue, 19 Feb 2008, Ingo Molnar wrote:
> > * Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > TSC is used even on machines when CONFIG_X86_TSC is not set (X86_TSC 
> > > means _require_ TSC), but it is not properly disabled when it is 
> > > unusable, because acpi code understood the config switch as "may use 
> > > TSC".
> > > 
> > > This actually fixes suspend problems on my x60.
> > 
> > ah! This makes tons of sense. I've applied your patch

please do not.

> > - but i guess it  should go via the ACPI tree.

yes.

> Right. The breakage was introduced there when IA64 switched to
> GENERIC_TIME and the X86_TSC dependency was added.

so do we need a patch for 2.6.23.stable and 2.6.24.stable?

thanks,
-Len
