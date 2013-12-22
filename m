From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: add support for ValleyView Soc
Date: Sun, 22 Dec 2013 22:21:55 +0100
Message-ID: <3683372.O2J0Fy185V@vostro.rjw.lan>
References: <1386801567-26661-1-git-send-email-jacob.jun.pan@linux.intel.com> <1553570.ISCzPqBYzN@vostro.rjw.lan> <alpine.DEB.2.02.1312221420400.13165@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55903 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755285Ab3LVVIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2013 16:08:31 -0500
In-Reply-To: <alpine.DEB.2.02.1312221420400.13165@pianoman.cluster.toy>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vince Weaver <vince@deater.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Gavin Hindman <gavin.hindman@intel.com>, "Triplett, Josh" <josh.triplett@intel.com>

On Sunday, December 22, 2013 02:22:48 PM Vince Weaver wrote:
> On Sun, 22 Dec 2013, Rafael J. Wysocki wrote:
> > On Wednesday, December 11, 2013 02:39:27 PM Jacob Pan wrote:
> 
> > > @@ -941,6 +949,7 @@ static void package_power_limit_irq_restore(int package_id)
> > >  static const struct x86_cpu_id rapl_ids[] = {
> > >  	{ X86_VENDOR_INTEL, 6, 0x2a},/* SNB */
> > >  	{ X86_VENDOR_INTEL, 6, 0x2d},/* SNB EP */
> > > +	{ X86_VENDOR_INTEL, 6, 0x37},/* VLV */
> > >  	{ X86_VENDOR_INTEL, 6, 0x3a},/* IVB */
> > >  	{ X86_VENDOR_INTEL, 6, 0x45},/* HSW */
> > >  	/* TODO: Add more CPU IDs after testing */
> 
> This isn't a problem introduced in this patch, but it made me notice it...
> 
> Would it really hurt anyone to spell out the architectures here, rather
> than using obscure 3-letter abbreviations?  It's bad enough trying to
> map the hex model numbers to the decimal ones in /proc/cpuinfo without
> also having to remember what a VLV is.

I guess you can prepare a patch for that?

Rafael

