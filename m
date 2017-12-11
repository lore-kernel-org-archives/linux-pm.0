From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH] cpufreq: powernv: Correctly parse the sign of pstates
 on POWER8 vs POWER9
Date: Mon, 11 Dec 2017 10:54:45 +0530
Message-ID: <20171211052445.GA21437@in.ibm.com>
References: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnzkWRm6BOoHLvO+rTmXh8frCJW4uGuccHLSW+WQnWseuhQ@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKTCnzkWRm6BOoHLvO+rTmXh8frCJW4uGuccHLSW+WQnWseuhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Balbir,

On Fri, Dec 08, 2017 at 02:44:40PM +1100, Balbir Singh wrote:
> On Thu, Dec 7, 2017 at 4:59 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
> > negatively numbered while on POWER9 they are positively
> > numbered. Thus, on POWER9, the maximum number of pstates could be as
> > high as 256.
> >
> > The current code interprets pstates as a signed 8-bit value. This
> > causes a problem on POWER9 platforms which have more than 128 pstates.
> > On such systems, on a CPU that is in a lower pstate whose number is
> > greater than 128, querying the current pstate returns a "pstate X is
> > out of bound" error message and the current pstate is reported as the
> > nominal pstate.
> >
> > This patch fixes the aforementioned issue by correctly differentiating
> > the sign whenever a pstate value read, depending on whether the
> > pstates are positively numbered or negatively numbered.
> 
> Yikes! Is there no better way of fixing this?

There is. In fact, I am working on cleaning up the whole thing to make
it not depend on the sign until it is really needed (and that is to
check whether the pstate that we read from the PMSR is within bounds)

Besides, currently the kernel code assumes a few things that the
device-tree doesn't guarantee, such as the continguity of pstates.

> 
> >
> > Fixes: commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
> > Cc: <stable@vger.kernel.org> #v4.8
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Tested-and-reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 33 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index b6d7c4c..bb7586e 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -41,11 +41,14 @@
> >  #define POWERNV_MAX_PSTATES    256
> >  #define PMSR_PSAFE_ENABLE      (1UL << 30)
> >  #define PMSR_SPR_EM_DISABLE    (1UL << 31)
> > -#define PMSR_MAX(x)            ((x >> 32) & 0xFF)
> > +#define EXTRACT_BYTE(x, shift) (((x) >> shift) & 0xFF)
> > +#define MAX_SHIFT              32
> >  #define LPSTATE_SHIFT          48
> >  #define GPSTATE_SHIFT          56
> > -#define GET_LPSTATE(x)         (((x) >> LPSTATE_SHIFT) & 0xFF)
> > -#define GET_GPSTATE(x)         (((x) >> GPSTATE_SHIFT) & 0xFF)
> > +#define GET_PMSR_MAX(x)                EXTRACT_BYTE(x, MAX_SHIFT)
> > +#define GET_LPSTATE(x)         EXTRACT_BYTE(x, LPSTATE_SHIFT)
> > +#define GET_GPSTATE(x)         EXTRACT_BYTE(x, GPSTATE_SHIFT)
> > +
> 
> Can you hide all of this in pstate_to_idx(), do the casting inside? I
> was reviewing this
> code earlier before being distracted with something else, this did
> come across as
> strange and I was looking at using abs values to simplify the code,
> but I did not get
> to it.
> 
> Balbir Singh.
> 
