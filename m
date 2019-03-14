From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
Date: Thu, 14 Mar 2019 09:35:57 -0700
Message-ID: <CAE=gft52W2+-_FxNMyWkBKNQQDGWSB9-PzhBxqZARzQ50ER1EA@mail.gmail.com>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
 <20190208172152.1807-3-georgi.djakov@linaro.org> <CAE=gft47bF-zJReobnUnsVGtiMCMqz4jWZLDWdMJ5qRUL+PH7g@mail.gmail.com>
 <9b93d5e4-2f68-06ee-82b9-29ccffc961e1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9b93d5e4-2f68-06ee-82b9-29ccffc961e1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Dai <daidavid1@codeaurora.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>, Sean Sweeney <seansw@qti.qualcomm.com>, Michael Turquette <mturquette@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 13, 2019 at 6:00 PM David Dai <daidavid1@codeaurora.org> wrote:
>
>
> On 3/8/2019 10:35 AM, Evan Green wrote:
> > On Fri, Feb 8, 2019 at 9:22 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >> From: David Dai <daidavid1@codeaurora.org>
> >>
> >> Add support for wake and sleep commands by using a tag to indicate
> >> whether or not the aggregate and set requests are active only or
> >> dual context for a particular path.
> >>
> >> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> >> ---
> >>   drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
> >>   1 file changed, 75 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> >> index fb526004c82e..13499f681160 100644
> >> --- a/drivers/interconnect/qcom/sdm845.c
> >> +++ b/drivers/interconnect/qcom/sdm845.c
> >> @@ -65,6 +65,12 @@ struct bcm_db {
> >>   #define SDM845_MAX_BCMS                30
> >>   #define SDM845_MAX_BCM_PER_NODE        2
> >>   #define SDM845_MAX_VCD         10
> >> +#define SDM845_MAX_CTX         2
> >> +#define SDM845_EE_STATE                2
> >> +#define EE_STATE_WAKE          0
> >> +#define EE_STATE_SLEEP         1
> >> +#define AO_CTX                 0
> >> +#define DUAL_CTX               1
> >>
> > I get really lost with these two sets of numbers here. I think this
> > needs some explanation in the comments. From staring at this what I've
> > understood so far is:
> > 1) Clients pass in a tag that buckets their requests into either AO or
> > DUAL within the node. (Although, the requests all seem to get
> > aggregated together no matter what the tag is, more on that later).
> > 2) During icc_set(), we go through the many-to-many mapping of BCMs to
> > nodes. For each BCM, we aggregate all the nodes it has, bucketed again
> > by AO or DUAL.
> > 3) The actual votes sent to RPMh are in terms of WAKE and SLEEP.
> > 4) The mapping from AO/DUAL to WAKE/SLEEP for a particular BCM is:
> > WAKE = AO+DUAL, SLEEP=DUAL.
> > 5) qcom_icc_set() sends EE_STATE_WAKE stuff to RPMH_ACTIVE_ONLY_STATE.
> > 6) If there's any difference between SLEEP and WAKE, then the
> > EE_STATE_WAKE commands are gathered together and sent to
> > RPMH_WAKE_ONLY_STATE, and all the EE_STATE_SLEEP commands are sent to
> > RPMH_SLEEP_STATE.
> >
> > So ultimately the muxing ends up like
> > RPMH_ACTIVE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL
> > RPMH_SLEEP_STATE <-- EE_STATE_SLEEP <-- DUAL
> > RPMH_WAKE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL
> This muxing explanation is correct, there's also an inherent limitation
> in this muxing where RPMH_ACTIVE cannot differ from RPMH_WAKE.
> >
> > Why do we need this complicated muxing to happen? Is it because we're
> > trying to avoid requiring drivers to specify three different paths in
> > the simple case, when all they care about is "use this bandwidth all
> > the time"?
> That's a part of it, I don't have strong justification for this legacy
> way of supporting wake/sleep, so I'm open to new suggestions.
> > What I think would make more sense would be to use the "tag" as a
> > bitfield instead. So you'd have
> >
> > #define QCOM_ICC_TAG_ACTIVE_ONLY 0x00000001
> > #define QCOM_ICC_TAG_SLEEP 0x00000002
> > #define QCOM_ICC_TAG_WAKE 0x00000004
> > #define QCOM_ICC_TAG_ALL_TIMES (QCOM_ICC_TAG_ACTIVE_ONLY |
> > QCOM_ICC_TAG_SLEEP | QCOM_ICC_TAG_WAKE)
> >
> > Drivers that don't care about sleep/wake sets would just not set a
> > tag, or set a tag of QCOM_ICC_TAG_ALL_TIMES. Then in
> > qcom_icc_aggregate(), you aggregate the same values up to three times,
> > one for each bit they have set. Finally in qcom_icc_set, you can pass
> > the votes directly down in their buckets, without doing a weird
> > mapping from AO/DUAL to SLEEP/WAKE/ACTIVE_ONLY.
> Works for me, I'd still want to optimize out the WAKE/SLEEP commands
> that are equal to each other though.

Yeah, that makes sense.

> > The sticky part about this is that now rather than one set of sum/peak
> > values, there are now three independent ones, corresponding to each of
> > the tag bits. It seems like the interconnect core wouldn't want to
> > mandate whether providers use the tag as a bitfield or a value. So the
> > provider would need to keep not only the official set of aggregates
> > that are returned back to the core (probably ACTIVE_ONLY, or maybe a
> > max of the three), but also the two shadow copies internally for SLEEP
> > and WAKE.
> I would ideally like to return the most accurate current state of the
> system which may be ACTIVE_ONLY or WAKE. We might also run into some
> confusion when printing out the summaries for each node. In a case where
> the votes for WAKE != ACTIVE(assuming one or more multiple consumers are
> intentionally doing this with multiple paths), the state of system will
> change depending on whether or not we've completed a sleep cycle(If it's
> prior to sleep, the ACTIVE_ONLY vote will be accurate, and post waking
> up the WAKE request will be correct) but this is more of a book keeping
> concern than anything else, as long as consumers understand that this is

Yeah, I thought about that too and agree it would be ideal if the
framework could report the actual state, rather than a guess. Maybe
someday when we have a clearer picture of what sort of automatic
switching other SoCs are capable of doing we could try to enlighten
the framework about these dynamic changes.

I had suggested reporting the max of the three buckets back to the
framework since I'm guessing most of the debugging will come down to
votes accidentally left on, so seeing an on vote might be helpful. But
then I guess that masks issues with votes not being set high enough,
or not being high enough after a resume... sigh.

> the expected behavior. On a side note, I don't like the ACTIVE_ONLY name
> designation for this which was brought over from the rpmh driver, it
> really means let's set the current state immediately and it has no
> association with the execution environment state unlike the other
> WAKE/SLEEP types.

I agree, it's very confusing. I'd be okay with another define like
SET_NOW whose value defines to ACTIVE_ONLY.

> >
> > If you organized the tag that way, the only extra thing you'd need is
> > a callback to the provider just before the core starts aggregation, so
> > that the provider can reset the shadow buckets to 0 the same way the
> > core resets the main sum/peak to 0 before looping.With this, we've
> > plumbed out the full abilities of RPMh to the client drivers, but
> > without complicating the simple case of "set this bandwidth all the
> > time". What do you think?
>
> I really like this idea for the most part, it certainly simplifies some
> of the muxing that happens underneath the layer and makes the
> aggregation to the RPMH driver a lot more transparent. Though we should
> probably just reset the shadow buckets to 0 at the end of a call into
> provider icc_set as part of cleaning up the state after we've committed
> some requests into hardware? I don't see a need to have to add another
> call back into the provider before aggregation.

Sure, that would work too. It bakes in a little bit of assumption
about how the framework is going to call the callbacks (ie it assumes
we will always do a set() following aggregate()), so it would be nice
to at least call that out in a comment when you aggregate in the
buckets.
