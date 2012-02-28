From: mark gross <markgross@thegnar.org>
Subject: Re: [linux-pm] [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Mon, 27 Feb 2012 16:56:30 -0800
Message-ID: <20120228005630.GA15348@envy17>
References: <87d39fk2n3.fsf@ti.com>
 <20120217030453.GA3266@gs62>
 <CAGF5oy9LC4Ve8u6UqG3EbGkWmWYVMthHatJdaRR_ZMO4UQh3CA@mail.gmail.com>
 <87pqd94yeu.fsf@amiettinen-lnx.nvidia.com>
 <CAGF5oy-64J3vMKvzY=NvdV-m8_wFo=NGZANF_cnVm-iq0s-wZQ@mail.gmail.com>
 <20120221145632.GA2840@envy17>
 <87linw5aod.fsf@ti.com>
 <20120225174449.GA17141@envy17>
 <877gz8wcud.fsf@ti.com>
 <4F4B9B60.6040501@nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F4B9B60.6040501@nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti Miettinen <amiettinen@nvidia.com>
Cc: Kevin Hilman <khilman@ti.com>, "len.brown@intel.com" <len.brown@intel.com>, "markgross@thegnar.org" <markgross@thegnar.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "j-pihet@ti.com" <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 27, 2012 at 04:04:00PM +0100, Antti Miettinen wrote:
> To the lists too..
> 
> On 02/27/2012 04:49 PM, Kevin Hilman wrote:
> > mark gross <markgross@thegnar.org> writes:
> >
> >  >> Current QoS settings could be thought of as performance constraints
> >  >> too. It's just that they determine minimum performance. Adding
> >  >> constraints for maxium performance is not a big stretch in my mind.
> >  >
> >  > Its not a big stretch to me either. I just think its a bit of a hack
> >  > and there is a bigger more interesting issue getting overlooked.
> >  >
> >  > Lastly why not simply make cpufreq thermal aware and talk directly to
> >  > it if you even need too?
> >
> > In fact, making a thermal framework "cooling device" that talks directly
> > to CPUfreq is already what's being done by the Linaro PMWG folks.
> >
> > The problem is that CPUfreq only controls the CPU frequency.
> >
> > There are other devices that could be scaled back to reduce heat as well
> > (DSP, and especially GPU), so having a more generic per-device
> > constraint interface that can cap the frequency for *any* scalable
> > device is a better framework IMO.
> >
> > It just so happens that pm_qos is already a good per-device constraint
> > framework and can easily modified to cap performance as well as request
> > a minimum performance.
> >
> > Kevin

ok I'll stop trying to block it.

I want to re-do the whole works anyway.  If this helps in the mean time
then go for it.

--mark

