From: Vince Weaver <vince@deater.net>
Subject: Re: [PATCH] powercap/rapl: add support for ValleyView Soc
Date: Sun, 22 Dec 2013 14:22:48 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1312221420400.13165@pianoman.cluster.toy>
References: <1386801567-26661-1-git-send-email-jacob.jun.pan@linux.intel.com> <1553570.ISCzPqBYzN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553570.ISCzPqBYzN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Gavin Hindman <gavin.hindman@intel.com>, "Triplett, Josh" <josh.triplett@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Dec 2013, Rafael J. Wysocki wrote:
> On Wednesday, December 11, 2013 02:39:27 PM Jacob Pan wrote:

> > @@ -941,6 +949,7 @@ static void package_power_limit_irq_restore(int package_id)
> >  static const struct x86_cpu_id rapl_ids[] = {
> >  	{ X86_VENDOR_INTEL, 6, 0x2a},/* SNB */
> >  	{ X86_VENDOR_INTEL, 6, 0x2d},/* SNB EP */
> > +	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
> >  	{ X86_VENDOR_INTEL, 6, 0x3a},/* IVB */
> >  	{ X86_VENDOR_INTEL, 6, 0x45},/* HSW */
> >  	/* TODO: Add more CPU IDs after testing */

This isn't a problem introduced in this patch, but it made me notice it...

Would it really hurt anyone to spell out the architectures here, rather
than using obscure 3-letter abbreviations?  It's bad enough trying to
map the hex model numbers to the decimal ones in /proc/cpuinfo without
also having to remember what a VLV is.

Vince
