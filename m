From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
Date: Wed, 6 Dec 2017 16:49:44 +0530
Message-ID: <20171206111944.GB22880@in.ibm.com>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <87r2s8dt3w.fsf@concordia.ellerman.id.au>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <87r2s8dt3w.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, huntbag@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

Hi Michael,

On Wed, Dec 06, 2017 at 09:54:27PM +1100, Michael Ellerman wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > Pstates are 8bit values but on POWER8 they are negative and on POWER9
> > they are positive. This patch adds helper routines to differentiate
> > the sign to read the correct pstate value.
> 
> This sounds like it could be a bad bug, but I can't really tell from the
> change log. What is the actual impact of not having this patch?

On some POWER9 platforms, there can be more than 128 pstates. 

Without this patch, on such platforms, if the value of the current
frequency corresponds to a pstate greater than 128, then the code will
interpret it as a negative number, and report that the "pstate is out
of bound" while returning a nominal frequency.

> 
> Should it have a Fixes/Cc-stable tag?

This doesn't fix any prior commit, but is fixes a newly discovered
bug.

I will resend the patch Cc'ing stable.

> 
> cheers
> 
