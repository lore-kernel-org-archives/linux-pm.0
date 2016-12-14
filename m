From: Gautham R Shenoy <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/4] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Wed, 14 Dec 2016 12:05:45 +0530
Message-ID: <20161214063545.GA26271@in.ibm.com>
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <0947ced2f87c68a0a10ede8e1aaf39838a6f8d52.1481288905.git.ego@linux.vnet.ibm.com>
 <f1bc3387-1118-6fd7-8e1b-2e59bfabdad1@gmail.com>
Reply-To: ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f1bc3387-1118-6fd7-8e1b-2e59bfabdad1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Balbir,

On Tue, Dec 13, 2016 at 09:13:26PM +1100, Balbir Singh wrote:
> 
> 
> On 10/12/16 00:32, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> > diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> > index 3919332..0a3255b 100644
> > --- a/arch/powerpc/include/asm/cpuidle.h
> > +++ b/arch/powerpc/include/asm/cpuidle.h
> > @@ -21,7 +21,7 @@
> >  
> >  /* Idle state entry routines */
> >  #ifdef	CONFIG_PPC_P7_NAP
> > -#define	IDLE_STATE_ENTER_SEQ(IDLE_INST)				\
> > +#define IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
> >  	/* Magic NAP/SLEEP/WINKLE mode enter sequence */	\
> >  	std	r0,0(r1);					\
> >  	ptesync;						\
> > @@ -29,6 +29,9 @@
> >  1:	cmpd	cr0,r0,r0;					\
> >  	bne	1b;						\
> >  	IDLE_INST;						\
> > +
> 
> Is the power saving magic sequence the same as before for power 9
> as well?

Yes, this is the same magic sequence for POWER9.

--
Thanks and Regards
gautham.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
