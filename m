From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv: Pass PSSCR value and mask to power9_idle_stop
Date: Thu, 13 Oct 2016 16:53:57 +0530
Message-ID: <20161013112357.GB9002@in.ibm.com>
References: <cover.1475130107.git.ego@linux.vnet.ibm.com>
 <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
 <87int84d6w.fsf@concordia.ellerman.id.au>
 <0e7ad8ff-8c44-86bc-f560-258bc7b29a32@gmail.com>
 <20161007072058.GC13873@in.ibm.com>
 <87lgxuf7tk.fsf@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <87lgxuf7tk.fsf@linux.vnet.ibm.com>
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
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "skiboot@lists.ozlabs.org" <skiboot@lists.ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

Hi Stewart,

On Wed, Oct 12, 2016 at 04:35:35PM +1100, Stewart Smith wrote:
> 
> What if we just treat the 0xF state from firmware as special and set it
> to DEFAULT_PSSCR_MASK in that case? That deals with old skiboot, new
> kernel, and sets a pretty small special case that's easy to track into
> the future as something we should watch out for.

Yes, that will work. I will use this approach in the next version.

> 
> Additionally, if we make skiboot set sane values in ~DEFAULT_PSSCR_MASK
> for valid fields in PSSCR on boot/(also kexec?), then
> we should end up in a situation where everything works with everything
> (even if you don't get the best power saving). Specifically, new
> skiboot, old kernel... but it looks like there's nothing currently
> missing there

No we're not missing much there. From the code of the old kernel, I
see that if we pass the psscr_val instead of just the RL to
power9_idle_stop(), we end up saving all the SPRs in
power_enter_stop() even if the psscr_val didn't correspond to a deep
idle state.

But that should be ok.

> 
> Should this patch also have Fixes: 3005c597ba4 and CC to stable?

Yes, thanks for pointing it out. I shall mark the next version to
stable.

> 
> -- 
> Stewart Smith
> OPAL Architect, IBM.

--
Thanks and Regards
gautham.
