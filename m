From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 12:38:53 -0700
Message-ID: <1477510733.2680.32.camel@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
          <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
          <alpine.DEB.2.20.1610261251550.4983@nanos>
         <1477505006.2680.25.camel@linux.intel.com>
         <alpine.DEB.2.20.1610262010420.5013@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1610262010420.5013@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-10-26 at 20:11 +0200, Thomas Gleixner wrote:
> On Wed, 26 Oct 2016, Tim Chen wrote:
> 
> > 
> > On Wed, 2016-10-26 at 12:52 +0200, Thomas Gleixner wrote:
> > > 
> > > On Thu, 20 Oct 2016, Tim Chen wrote:
> > > > 
> > > > 
> > > >  
> > > > +	if (itmt_sysctl_header)
> > > > +		unregister_sysctl_table(itmt_sysctl_header);
> > > What sets itmt_sysctl_header to NULL?
> > > 
> > If the registration of the itmt sysctl table has failed, it will
> > be NULL.
> And what clears it _AFTER_ the deregistration? Nothing, AFAICT.

Ok. I'll clear itmt_sysctl_header here.

Thanks.

Tim
