From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
Date: Tue, 18 Dec 2018 11:08:33 +0100
Message-ID: <CAKfTPtDAnCR16dr1wkT3U1+ZfwjP=JqeBhuRKoUcN5ocB7_fpg@mail.gmail.com>
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
 <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
 <CAKfTPtBbZgZtU-qZhh-nKoC=cNj=ZT_LTn=cTX4V10MCZhDFEg@mail.gmail.com>
 <CAJZ5v0i0FMw90vBH9L9EirX-mfFzh4Fb0npE8Y7rHbFn0JpZyw@mail.gmail.com>
 <CAKfTPtCNYz6a5rqvpGGGNgsAw_=HdqtpEOfXjn309saNUBjbrw@mail.gmail.com> <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g9ceG=dVTTfwkqdZQ0-YMswvfHNfmryZfXAfH=yJV__g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thara Gopinath <thara.gopinath@linaro.org>, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Dec 2018 at 11:03, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 18, 2018 at 10:58 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 18 Dec 2018 at 10:57, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Dec 17, 2018 at 3:22 PM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Fri, 14 Dec 2018 at 15:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
> > > > > <vincent.guittot@linaro.org> wrote:
> > > > > >
> > > > > > With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> > > > > > updated to use this new time infrastructure.
> > > > > >
> > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
> > > > > >  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
> > > > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > index d6c8f8f..cf6437d 100644
> > > > > > --- a/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > +++ b/drivers/gpu/drm/i915/i915_pmu.c
> > > > > > @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
> > > > > >                  */
> > > > > >                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
> > > > > >                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> > > > > > -                               i915->pmu.suspended_jiffies_last =
> > > > > > -                                                 kdev->power.suspended_jiffies;
> > > > > > +                               i915->pmu.suspended_time_last =
> > > > > > +                                       kdev->power.suspended_time;
> > > > > >
> > > > >
> > > > > Huh, so patch 2 introduces a complier error because of removing the
> > > > > old fields. We can't have that.
> > > >
> > > > I agree
> > > > The patch was mainly to raise discussion
> > >
> > > OK, so patch [1/3] from this series should be applicable regardless, right?
> >
> > Yes
>
> OK, I'll queue it up, then.

Thanks

>
> Next time you do something like that  please mark patches for
> discussion in a series as [RFC] so it is all clear.

ok. will do for the next version of the last 2 patches
