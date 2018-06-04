From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
Date: Mon, 4 Jun 2018 17:15:00 +0530
Message-ID: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
> Is this a new property ? I'm not fan of adding yet another of those
> silly arrays.
> 
> I would say this is the right time now to switch over to a node per
> state instead, as we discussed with Vaidy.

I posted  the node based device tree here :
skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
kernel patch : https://lkml.org/lkml/2018/5/30/1146

Do you have any inputs for this design ?

> 
> Additionally, while doing that, we can provide the versioning mechanism
> I proposed so we can deal with state specific issues and erratas.
> 
> Cheers,
> Ben.
> 
