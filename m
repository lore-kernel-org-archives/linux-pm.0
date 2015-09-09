From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] x86, acpi: Handle apic/x2apic entries in MADT in
 correct order
Date: Wed, 9 Sep 2015 16:43:34 +0100
Message-ID: <20150909154334.GA12341@red-moon>
References: <55EF0C7A.7070105@arm.com>
 <1441791018-14669-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441791018-14669-2-git-send-email-lukasz.anaczkowski@intel.com>
 <1441791018-14669-3-git-send-email-lukasz.anaczkowski@intel.com>
 <20150909135619.GA11965@red-moon>
 <C1C2579D7BE026428F81F41198ADB172378BEA81@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C1C2579D7BE026428F81F41198ADB172378BEA81@irsmsx110.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "tomasz.nowicki@linaro.org" <tomasz.nowicki@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Craft, Clayton A" <clayton.a.craft@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 09, 2015 at 03:27:47PM +0100, Anaczkowski, Lukasz wrote:
> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com] 
> Sent: Wednesday, September 9, 2015 3:56 PM
> 
> > On Wed, Sep 09, 2015 at 10:30:18AM +0100, Lukasz Anaczkowski wrote:
> > > () it's hard to predict how cores and threads are enumerated
> 
> > So ? Why would the logical cpus order matters at all ? I guessed
> > there are probeable properties that allows the kernel to build
> > the affinity (ie topology list, shared caches, smt siblings, etc).
> > Please explain, since I am confused, to me all you need is a list
> > of existing physical ids, in whatever order they come, that's at least
> > what we need on ARM.
> 
> Hi Lorenzo,
> 
> Sure, let me try to explain this better.
> 
> Proper (i.e. predictable way of CPU enumeration) matters for HPC software,
> (this is where I come from) as there are workloads that have some assumptions 
> on CPU enumeration in order to keep cache hit ratio as high as possible.
> E.g. in KNL cores share L2 caches, and if during enumeration logical cores do not
> reflect physical cores, S/W can start affinitize threads to the same physical cores
> causing great performance impact exactly due to L2 cache misses.
> (e.g. s/w assumes that HT CPUs are separated by core count).
> 
> Now, those changes would not be required if someone who have written
> APIC spec had reserved more than just 1 byte for CPU id :)
> Unfortunately, it's the case for x86 APIC ID and once it turns out there's a need
> to enumerate more than that, they added X2APIC spec which has 4 bytes for ID.
> Even that would be also fine if there were just physical cores, but with HT, ACPI
> clearly says, that first must be listed physical cores and only after that HT CPUs
> (and that's why APIC/X2APIC subtables are interleaved).
> 
> When GIC spec was added, someone was smart enough to put 4 bytes from
> the begging, so you don't need to care about it on ARM :)
> 
> > > () enumeration is inconsistent with how threads are enumerated on
> > >    other Intel Xeon processors
> 
> > And why does that matter ? Is it because userspace is making assumptions
> > on the logical cpu enumeration scheme ? I am just asking, I would
> > like to understand.
> 
> Yes, HPC software makes some assumptions about CPU enumeration (as mentioned 
> above) and having inconsistent enumeration between different x86 CPUs (Xeon vs Xeon Phi)
> make such s/w basically not portable.

Eh, what about "other s/w" (since MADT APIC/X2APIC parsing is unchanged
since 2009 as you mentioned) that relies on the way current enumeration is
implemented ? I will leave that to you.

/me going back to commenting the code :)

> > > So, order in which MADT APIC/X2APIC handlers are passed is
> > > reverse and both handlers are passed to be called during same MADT
> > > table to walk to achieve correct CPU enumeration.
> 
> > Define "correct" please, you define the logical ordering you
> > want to achieve, you do not define why that's more "correct"
> > than the current implementation.
> 
> Ok, probably 'correct' word is not the best here :)
> Does 'compatible' sound better?

No, see above :)

Thanks,
Lorenzo
