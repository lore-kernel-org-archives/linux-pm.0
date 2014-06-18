From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Wed, 18 Jun 2014 11:57:25 +0300
Message-ID: <20140618085725.GI3407@tbergstrom-lnx.Nvidia.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <20140617223518.GA25309@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140617223518.GA25309@mithrandir>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 18, 2014 at 12:35:27AM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jun 17, 2014 at 02:16:06PM +0200, Tomeu Vizoso wrote:
> > On 06/16/2014 10:02 PM, Stephen Warren wrote:
> > >On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
> > >>+
> > >>+Child device nodes describe the memory settings for different configurations and
> > >>+clock rates.
> > >
> > >How do the child nodes do that? The binding needs to specify the format
> > >of the child node.
> > 
> > Sorry, that file was sent before I had finished removing the bits from
> > downstream that aren't needed yet. There's no current need for any child
> > nodes.
> > 
> > >This binding looks quite anaemic vs.
> > >Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
> > >would expect that this binding needs all the EMC register data from the
> > >tegra20-emc binding too. Can the two bindings be identical?
> > 
> > There's even less stuff needed right now, as all what ultimately the EMC
> > driver does is call clk_set_rate on the EMC clock. As the T124 EMC driver
> > gains more features, they should get more similar.
> > 
> > >Can you explain what the nvidia,mc and nvidia,pmc references are needed
> > >for? Hopefully, this driver isn't going to reach into those devices and
> > >touch their registers directly.
> > 
> > Not really needed, see above.
> 
> I've been working on a prototype driver for the memory controller. Part
> of what I've added is programming of the latency allowance registers (it
> doesn't yet expose an API to do so yet, though). I think that needs to
> eventually take into account the EMC frequency (and needs to be notified
> of changes to the same).
> 
> Without having thought this through very thoroughly, I suspect that
> rather than referencing the MC from the EMC it might be better to have
> the MC register with the EMC for notifications.
> 
> But perhaps there are other services from MC that EMC needs to work?
> 

If the emc frequency change is modelled as a clock, you could use CCF
notifications for this?

Cheers,

Peter.
