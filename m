From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Mon, 26 Jan 2015 15:24:27 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1501261523370.5526@nanos>
References: <54866625.8010406@linux.intel.com> <54C5FE6A.9010300@linux.intel.com> <alpine.DEB.2.11.1501260946390.5526@nanos> <2137807.aqSxQQCuJ3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2137807.aqSxQQCuJ3@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Jan 2015, Rafael J. Wysocki wrote:
> On Monday, January 26, 2015 10:40:24 AM Thomas Gleixner wrote:
> > The only remaining issue might be a NMI calling into
> > ktime_get_mono_fast_ns() before timekeeping is resumed. Its probably a
> > non issue on x86/tsc, but it might be a problem on other platforms
> > which turn off devices, clocks, It's not rocket science to prevent
> > that.
> 
> I don't see any users of ktime_get_mono_fast_ns() at all, unless some non-trivial
> macros are involved.  At least grepping for it only returns the definition,
> declarations and the line in trace.c.

You can trace in NMI and perf is going to use ktime_get_mono_fast_ns()
eventually as well.

Thanks,

	tglx
