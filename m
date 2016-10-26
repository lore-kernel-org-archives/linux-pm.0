From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 20:11:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610262010420.5013@nanos>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>  <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>  <alpine.DEB.2.20.1610261251550.4983@nanos> <1477505006.2680.25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-664602524-1477505485=:5013"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbcJZSN6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 14:13:58 -0400
In-Reply-To: <1477505006.2680.25.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-664602524-1477505485=:5013
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Oct 2016, Tim Chen wrote:

> On Wed, 2016-10-26 at 12:52 +0200, Thomas Gleixner wrote:
> > On Thu, 20 Oct 2016, Tim Chen wrote:
> > > 
> > >  
> > > +	if (itmt_sysctl_header)
> > > +		unregister_sysctl_table(itmt_sysctl_header);
> > What sets itmt_sysctl_header to NULL?
> > 
> 
> If the registration of the itmt sysctl table has failed, it will
> be NULL.

And what clears it _AFTER_ the deregistration? Nothing, AFAICT.
--8323329-664602524-1477505485=:5013--
