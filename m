From: Hugh Dickins <hughd@google.com>
Subject: Re: [REGRESSION] [4.11/4.12-rc3] Hang on Suspend to RAM
Date: Thu, 1 Jun 2017 12:55:28 -0700 (PDT)
Message-ID: <alpine.LSU.2.11.1706011236420.4437@eggly.anvils>
References: <748157628.hqj47iI04h@merkaba>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1753845095-1496346935=:4437"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <748157628.hqj47iI04h@merkaba>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1753845095-1496346935=:4437
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Jun 2017, Martin Steigerwald wrote:

> Hello.
>=20
> I live with that linux kernels since about 2-3 years at least or even lon=
ger=20
> occasionally hang on hibernation to disk on this ThinkPad T520 with=20
> Sandybridge. It happens so rarely and if usually leaves me without any ea=
sy=20
> way to gather any debug information, that I just put up with it. The hang=
 is=20
> as follows: Power LED of ThinkPad T520 dims on and off like it does durin=
g a=20
> hibernation or suspend cycle. Screen is black. And thats it. Sometimes it=
=20
> eventually completed the process after a few minutes, but usually it is s=
tuck=20
> there for 10 minutes or more and I give up waiting then. Actually maybe e=
ven=20
> it was with Nigel Cunningham=C2=B4s Tux On Ice when hibernation worked re=
liably. I=20
> remember uptimes of 100-200 days for some old workstation and even my lap=
top=20
> back then made 40 days or more. I never see this with any kind of somewha=
t=20
> recent kernel on my current laptop.
>=20
> Since 4.11 I have it quite often that a hang like this even happens on su=
spend=20
> to RAM (standby) as well. And even quite often about 1 time of of 2-3 sus=
pend=20
> attempts. The hang symptoms are similar. Power LED dims on and off. Scree=
n is=20
> black.
>=20
> Since this is my holidays and this again does not happen all of the time =
and=20
> thus would be considerable effort to bisect, I think I am out here now. U=
nless=20
> you have something I can test easily.
>=20
> It seems I am much better off with opting out out of kernel testing as I =
tend=20
> to usually get the nasty "I hang and I won=C2=B4t tell you any hint as ab=
out why I=20
> do so and do so only sometimes" kind of bugs that are too much effort for=
 me=20
> to provide any usable debug information about.
>=20
> At least the most nasty i915 bugs in 4.9 and 4.10 seem to be gone meanwhi=
le =E2=80=93=20
> will close my reports about them today. So maybe I look back at 4.11 and =
4.12=20
> with ten or more stable releases. Seems current release candidates and ev=
en=20
> releases by Linus are just to unstable for me to bear with. Which hints a=
t a=20
> lack of testing=E2=80=A6 but then testing for me (and quite some others?)=
 just seems=20
> to be too much of an hassle and effort=E2=80=A6
>=20
> so draw your own conclusions from there.
>=20
> I still wanted to provide feedback on these quality issues, as no feedbac=
k can=20
> easily be interpreted as "works correctly".
>=20
> If you have any idea of useful information I can provide to you *easily* =
and=20
> in a *short amount of time*, then feel free to share it. I have holidays=
=20
> tough, so I am especially picky about the easily and short amount of time=
=20
> part.=20
>=20
> Switching back to 4.10, last known working kernel, now.

The commit below reached Linus's tree a few hours ago, and fixes an i915
issue that several of us were seeing in 4.11 and 4.12-rc.  I didn't have
your symptoms - but I don't use hibernation: I think there's a good chance
that this commit will fix your issue (but I wouldn't be able help any
further if it does not work for you, sorry).

Depending on what tree you apply it to, it may not apply cleanly:
just delete the synchronize_rcu_expedited() and syncronize_rcu()
lines from that file.

Hugh

commit 4681ee21d62cfed4364e09ec50ee8e88185dd628
Author: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Date:   Thu May 18 11:49:39 2017 +0300

    drm/i915: Do not sync RCU during shrinking
   =20
    Due to the complex dependencies between workqueues and RCU, which
    are not easily detected by lockdep, do not synchronize RCU during
    shrinking.
   =20
    On low-on-memory systems (mem=3D1G for example), the RCU sync leads
    to all system workqueus freezing and unrelated lockdep splats are
    displayed according to reports. GIT bisecting done by J. R.
    Okajima points to the commit where RCU syncing was extended.
   =20
    RCU sync gains us very little benefit in real life scenarios
    where the amount of memory used by object backing storage is
    dominant over the metadata under RCU, so drop it altogether.
   =20
     " Yeeeaah, if core could just, go ahead and reclaim RCU
       queues, that'd be great. "
   =20
      - Chris Wilson, 2016 (0eafec6d3244)
   =20
    v2: More information to commit message.
    v3: Remove "grep _rcu_" escapee from i915_gem_shrink_all (Andrea)
   =20
    Fixes: c053b5a506d3 ("drm/i915: Don't call synchronize_rcu_expedited un=
der struct_mutex")
    Suggested-by: Chris Wilson <chris@chris-wilson.co.uk>
    Reported-by: J. R. Okajima <hooanon05g@gmail.com>
    Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
    Tested-by: Hugh Dickins <hughd@google.com>
    Tested-by: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Chris Wilson <chris@chris-wilson.co.uk>
    Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    Cc: J. R. Okajima <hooanon05g@gmail.com>
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Jani Nikula <jani.nikula@intel.com>
    Cc: <stable@vger.kernel.org> # v4.11+
    (cherry picked from commit 73cc0b9aa9afa5ba65d92e46ded61d29430d72a4)
    Signed-off-by: Jani Nikula <jani.nikula@intel.com>
    Link: http://patchwork.freedesktop.org/patch/msgid/1495097379-573-1-git=
-send-email-joonas.lahtinen@linux.intel.com

diff --git a/drivers/gpu/drm/i915/i915_gem_shrinker.c b/drivers/gpu/drm/i91=
5/i915_gem_shrinker.c
index 129ed303a6c4..57d9f7f4ef15 100644
--- a/drivers/gpu/drm/i915/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/i915_gem_shrinker.c
@@ -59,9 +59,6 @@ static void i915_gem_shrinker_unlock(struct drm_device *d=
ev, bool unlock)
 =09=09return;
=20
 =09mutex_unlock(&dev->struct_mutex);
-
-=09/* expedite the RCU grace period to free some request slabs */
-=09synchronize_rcu_expedited();
 }
=20
 static bool any_vma_pinned(struct drm_i915_gem_object *obj)
@@ -274,8 +271,6 @@ unsigned long i915_gem_shrink_all(struct drm_i915_priva=
te *dev_priv)
 =09=09=09=09I915_SHRINK_ACTIVE);
 =09intel_runtime_pm_put(dev_priv);
=20
-=09synchronize_rcu(); /* wait for our earlier RCU delayed slab frees */
-
 =09return freed;
 }
=20
--0-1753845095-1496346935=:4437--
