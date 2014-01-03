From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH resend] scripts: Coccinelle script for pm_runtime_*
 return checks with IS_ERR_VALUE
Date: Fri, 3 Jan 2014 14:40:10 +0100
Message-ID: <20140103134010.GA1676@sepie.suse.cz>
References: <1385991581-16843-1-git-send-email-nm@ti.com>
 <52C6B3C8.7040509@suse.cz>
 <alpine.DEB.2.10.1401031429140.2095@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbaACNkM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jan 2014 08:40:12 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1401031429140.2095@hadrien>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Nishanth Menon <nm@ti.com>, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr, linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr, linux-pm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Fri, Jan 03, 2014 at 02:29:35PM +0100, Julia Lawall wrote:
> 
> On Fri, 3 Jan 2014, Michal Marek wrote:
> 
> > On 2013-12-02 14:39, Nishanth Menon wrote:
> > > As indicated by Sekhar in [1], there seems to be a tendency to use
> > > IS_ERR_VALUE to check the error result for pm_runtime_* functions which
> > > make no sense considering commit c48cd65 (ARM: OMAP: use consistent
> > > error checking) - the error values can either be < 0 for error OR
> > > 0, 1 in cases where we have success.
> > >
> > > So, setup a coccinelle script to help identify the same.
> >
> > Julia, Gilles, do you have any objections to this semantic patch?
> 
> No objections.
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks, applied to kbuild.git#misc.

Michal
