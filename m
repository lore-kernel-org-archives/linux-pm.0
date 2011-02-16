From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: disable HW auto-demotion
Date: Wed, 16 Feb 2011 01:19:18 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102160115160.843__39239.6714458757$1297908354$gmane$org@x980>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
	<20110119144152.GA23020@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110119144152.GA23020@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Jan 2011, Matthew Garrett wrote:

> On Tue, Jan 18, 2011 at 09:52:26PM -0500, Len Brown wrote:
> > + * Disable HW auto demotion on tick-less idle kernels
> > + */
> > +static unsigned int has_nhm_snb_hw_auto_demotion;
> > +#ifdef CONFIG_NO_HZ
> > +static unsigned int auto_demotion;
> > +#else
> > +static unsigned int auto_demotion = 1;
> > +#endif
> 
> What if someone boots with nohz=off?

The next version of this patch will disable auto-demotion
independent of HZ, on the assumption that the governor
is smart enough today to get what it asks for, HZ or NO_HZ.

It is also now limits the change to NHM/WSM,
as SNB has auto-un-demotion to address this scenario.

> Just so I'm clear on this - this is unrelated to the auto-popup on DMA, 
> right?

Right, C2 popup is a different feature, and that is smart
enought to return to the power saving state after the
DMA is done.

cheers,
Len Brown, Intel Open Source Technology Center
