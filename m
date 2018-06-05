From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
Date: Tue, 5 Jun 2018 14:38:27 +0530
Message-ID: <20180605090827.u535p5du5em3kgil@aksadiga.ibm>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
 <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
 <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek <huntbag@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 05, 2018 at 02:24:39PM +0530, Abhishek wrote:
> 
> 
> On 06/04/2018 05:15 PM, Akshay Adiga wrote:
> > On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
> > > Is this a new property ? I'm not fan of adding yet another of those
> > > silly arrays.
> > > 
> > > I would say this is the right time now to switch over to a node per
> > > state instead, as we discussed with Vaidy.
> 
> It is not a new property. Name was being used for description as description
> was not present in device tree. A skiboot patch adding description to device
> tree have been posted. This patch reads those description instead of copying
> name itself into description. And we fall back to reading name into
> description to not break the comaptibility with older firmware.

>From a cpuidle point of view this is a exisiting property, but for
powernv there was no device-tree property describing this. 

Abhishek has added the following skiboot patch for adding description
for each idle state in device-tree .
https://patchwork.ozlabs.org/patch/924879/

I agree this can go into new device tree format which each idle state
as a node. Probably i will roll this patch into mine in the next
version.


> 
> Thanks
> Abhishek
> 
> > I posted  the node based device tree here :
> > skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
> > kernel patch : https://lkml.org/lkml/2018/5/30/1146
> > 
> > Do you have any inputs for this design ?
> > 
> > > Additionally, while doing that, we can provide the versioning mechanism
> > > I proposed so we can deal with state specific issues and erratas.
> > > 
> > > Cheers,
> > > Ben.
> > > 
> 
