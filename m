From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86, irq: Fix regression caused by commit b568b8601f05
Date: Tue, 17 Feb 2015 19:50:12 +0100
Message-ID: <20150217185012.GI7119@twins.programming.kicks-ass.net>
References: <1424039150-4115-1-git-send-email-syrjala@sci.fi>
 <1424052673-22974-1-git-send-email-jiang.liu@linux.intel.com>
 <20150216193637.GA13497@amd>
 <14690730.85W95cg85M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <14690730.85W95cg85M@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Sander Eikelenboom <linux@eikelenboom.it>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 17, 2015 at 06:55:14PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 16, 2015 08:36:37 PM Pavel Machek wrote:
> > On Mon 2015-02-16 10:11:13, Jiang Liu wrote:
> > > Commit b568b8601f05 ("Treat SCI interrupt as normal GSI interrupt=
")
> > > accidently removes support of legacy PIC interrupt when fixing a
> >=20
> > accidentaly?
> >=20
> > > regression for Xen, which causes a nasty regression on HP/Compaq
> > > nc6000 where we fail to register the ACPI interrupt, and thus
> > > lose eg. thermal notifications leading a potentially overheated
> > > machine.
> > >=20
> > > So reintroduce support of legacy PIC based ACPI SCI interrupt.
> > >=20
> > > Reported-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
> > > Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> Is anyone taking care of this one or should I take it?
>=20
> Ingo, Peter?

Gots it, thanks!
