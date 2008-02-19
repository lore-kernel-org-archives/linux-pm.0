From: Ingo Molnar <mingo@elte.hu>
Subject: Re: tsc breaks atkbd suspend
Date: Tue, 19 Feb 2008 15:05:52 +0100
Message-ID: <20080219140552.GC9965@elte.hu>
References: <20080218133852.GA1573@elf.ucw.cz> <alpine.LFD.1.00.0802181515070.7583@apollo.tec.linutronix.de> <20080218143757.GB1960@elf.ucw.cz> <alpine.LFD.1.00.0802181545090.7583@apollo.tec.linutronix.de> <20080219100029.GA1637@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755512AbYBSOGa@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080219100029.GA1637@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, jbohac@suse.cz, kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> TSC is used even on machines when CONFIG_X86_TSC is not set (X86_TSC 
> means _require_ TSC), but it is not properly disabled when it is 
> unusable, because acpi code understood the config switch as "may use 
> TSC".
> 
> This actually fixes suspend problems on my x60.

ah! This makes tons of sense. I've applied your patch - but i guess it 
should go via the ACPI tree.

	Ingo
