From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [REGRESSION] [4.11/4.12-rc3] Hang on Suspend to RAM
Date: Fri, 09 Jun 2017 00:19:16 +0200
Message-ID: <1881047.mYXPBF1WqU@merkaba>
References: <748157628.hqj47iI04h@merkaba> <alpine.LSU.2.11.1706011236420.4437@eggly.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.11.1706011236420.4437@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hughd@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hugh Dickins - 01.06.17, 12:55:
> On Thu, 1 Jun 2017, Martin Steigerwald wrote:
> > Hello.
> > 
> > I live with that linux kernels since about 2-3 years at least or even
> > longer occasionally hang on hibernation to disk on this ThinkPad T520
> > with Sandybridge. It happens so rarely and if usually leaves me without
> > any easy way to gather any debug information, that I just put up with it.
> > The hang is as follows: Power LED of ThinkPad T520 dims on and off like
> > it does during a hibernation or suspend cycle. Screen is black. And thats
> > it. Sometimes it eventually completed the process after a few minutes,
> > but usually it is stuck there for 10 minutes or more and I give up
> > waiting then. Actually maybe even it was with Nigel Cunningham´s Tux On
> > Ice when hibernation worked reliably. I remember uptimes of 100-200 days
> > for some old workstation and even my laptop back then made 40 days or
> > more. I never see this with any kind of somewhat recent kernel on my
> > current laptop.
> > 
> > Since 4.11 I have it quite often that a hang like this even happens on
> > suspend to RAM (standby) as well. And even quite often about 1 time of of
> > 2-3 suspend attempts. The hang symptoms are similar. Power LED dims on
> > and off. Screen is black.
> > 
> > Since this is my holidays and this again does not happen all of the time
> > and thus would be considerable effort to bisect, I think I am out here
> > now. Unless you have something I can test easily.
> > 
> > It seems I am much better off with opting out out of kernel testing as I
> > tend to usually get the nasty "I hang and I won´t tell you any hint as
> > about why I do so and do so only sometimes" kind of bugs that are too
> > much effort for me to provide any usable debug information about.
> > 
> > At least the most nasty i915 bugs in 4.9 and 4.10 seem to be gone
> > meanwhile – will close my reports about them today. So maybe I look back
> > at 4.11 and 4.12 with ten or more stable releases. Seems current release
> > candidates and even releases by Linus are just to unstable for me to bear
> > with. Which hints at a lack of testing… but then testing for me (and
> > quite some others?) just seems to be too much of an hassle and effort…
> > 
> > so draw your own conclusions from there.
> > 
> > I still wanted to provide feedback on these quality issues, as no feedback
> > can easily be interpreted as "works correctly".
> > 
> > If you have any idea of useful information I can provide to you *easily*
> > and in a *short amount of time*, then feel free to share it. I have
> > holidays tough, so I am especially picky about the easily and short
> > amount of time part.
> > 
> > Switching back to 4.10, last known working kernel, now.
> 
> The commit below reached Linus's tree a few hours ago, and fixes an i915
> issue that several of us were seeing in 4.11 and 4.12-rc.  I didn't have
> your symptoms - but I don't use hibernation: I think there's a good chance
> that this commit will fix your issue (but I wouldn't be able help any
> further if it does not work for you, sorry).

FWIW I tested 4.12-rc4. Still failing. So back to 4.11, this time 4.11.17, as 
I just cannot be bothered right now with these repeated worst case, only 
happening sometimes complete hang regressions after a wonderfully warm day in 
Spain. Its certainly not the first of those regressions within the last 3-4 
kernel releases. I am just fed up with it.

> Depending on what tree you apply it to, it may not apply cleanly:
> just delete the synchronize_rcu_expedited() and syncronize_rcu()
> lines from that file.
> 
> Hugh
> 
> commit 4681ee21d62cfed4364e09ec50ee8e88185dd628
> Author: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Date:   Thu May 18 11:49:39 2017 +0300
> 
>     drm/i915: Do not sync RCU during shrinking
> 
>     Due to the complex dependencies between workqueues and RCU, which
>     are not easily detected by lockdep, do not synchronize RCU during
>     shrinking.
> 
>     On low-on-memory systems (mem=1G for example), the RCU sync leads
>     to all system workqueus freezing and unrelated lockdep splats are
>     displayed according to reports. GIT bisecting done by J. R.
>     Okajima points to the commit where RCU syncing was extended.
> 
>     RCU sync gains us very little benefit in real life scenarios
>     where the amount of memory used by object backing storage is
>     dominant over the metadata under RCU, so drop it altogether.
> 
>      " Yeeeaah, if core could just, go ahead and reclaim RCU
>        queues, that'd be great. "
> 
>       - Chris Wilson, 2016 (0eafec6d3244)
> 
>     v2: More information to commit message.
>     v3: Remove "grep _rcu_" escapee from i915_gem_shrink_all (Andrea)
> 
>     Fixes: c053b5a506d3 ("drm/i915: Don't call synchronize_rcu_expedited
> under struct_mutex") Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
>     Reported-by: J. R. Okajima <hooanon05g@gmail.com>
>     Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>     Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
>     Tested-by: Hugh Dickins <hughd@google.com>
>     Tested-by: Andrea Arcangeli <aarcange@redhat.com>
>     Cc: Chris Wilson <chris@chris-wilson.co.uk>
>     Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>     Cc: J. R. Okajima <hooanon05g@gmail.com>
>     Cc: Andrea Arcangeli <aarcange@redhat.com>
>     Cc: Hugh Dickins <hughd@google.com>
>     Cc: Jani Nikula <jani.nikula@intel.com>
>     Cc: <stable@vger.kernel.org> # v4.11+
>     (cherry picked from commit 73cc0b9aa9afa5ba65d92e46ded61d29430d72a4)
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Link:
> http://patchwork.freedesktop.org/patch/msgid/1495097379-573-1-git-send-emai
> l-joonas.lahtinen@linux.intel.com
> 
> diff --git a/drivers/gpu/drm/i915/i915_gem_shrinker.c
> b/drivers/gpu/drm/i915/i915_gem_shrinker.c index 129ed303a6c4..57d9f7f4ef15
> 100644
> --- a/drivers/gpu/drm/i915/i915_gem_shrinker.c
> +++ b/drivers/gpu/drm/i915/i915_gem_shrinker.c
> @@ -59,9 +59,6 @@ static void i915_gem_shrinker_unlock(struct drm_device
> *dev, bool unlock) return;
> 
>  	mutex_unlock(&dev->struct_mutex);
> -
> -	/* expedite the RCU grace period to free some request slabs */
> -	synchronize_rcu_expedited();
>  }
> 
>  static bool any_vma_pinned(struct drm_i915_gem_object *obj)
> @@ -274,8 +271,6 @@ unsigned long i915_gem_shrink_all(struct
> drm_i915_private *dev_priv) I915_SHRINK_ACTIVE);
>  	intel_runtime_pm_put(dev_priv);
> 
> -	synchronize_rcu(); /* wait for our earlier RCU delayed slab frees */
> -
>  	return freed;
>  }


-- 
Martin
