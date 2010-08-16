From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] Notes from the Boston Linux Power Management
	Mini-summit - August 9th, 2010
Date: Mon, 16 Aug 2010 15:49:14 +0100
Message-ID: <20100816144914.GB10354@sirena.org.uk>
References: <alpine.LFD.2.00.1008150134180.7641@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1008150134180.7641@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 15, 2010 at 01:36:33AM -0400, Len Brown wrote:

> A gap:
> 
> On OMAP, bus control is independent of CPU frequency control,
> so cpufreq and cpuidle don't quite fit the bill.
> 
> Perhaps a "bus-idle" analogous to "cpu-idle" may be appropriate?

FWIW this applies to a bunch of other embedded processors too - OMAP
isn't particularly unique here, though it's one of the furthest along in
terms of exploting this in mainline Linux.
