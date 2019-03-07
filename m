From: Kevin Hilman <khilman@baylibre.com>
Subject: RE: [PATCH 1/2] PM / Domains: Support enter deepest state for
 multiple states domains
Date: Fri, 08 Mar 2019 01:01:21 +0900
Message-ID: <7htvgeekry.fsf@baylibre.com>
References: <1551878926-8455-1-git-send-email-aisheng.dong@nxp.com>
 <1551878926-8455-2-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFoMymoG1yUsA+aqZpYq-wNwuWQnA43kgb0SsY=p0JKgCQ@mail.gmail.com>
 <AM0PR04MB42119819041F85FC41510D9180730@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB42119819041F85FC41510D9180730@AM0PR04MB4211.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aisheng Dong <aisheng.dong@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Aisheng Dong <aisheng.dong@nxp.com> writes:

>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, March 6, 2019 11:18 PM> 
>> On Wed, 6 Mar 2019 at 14:35, Aisheng Dong <aisheng.dong@nxp.com>
>> wrote:
>> >
>> > Currently the generic power domain will power off the domain if all
>> > devices in it have been stopped during system suspend.
>> >
>> > It is done by checking if the domain is active in
>> > genpd_sync_power_off, then disable it. However, for power domains
>> > supporting multiple low power states, it may have already entered an
>> > intermediate low power state by runtime PM before system suspend and
>> > the status is already GPD_STATE_POWER_OFF which results in then the
>> > power domain stay at an intermediate low power state during system
>> suspend.
>> > Then genpd_sync_power_off will keep it at the low power state instead
>> > of completely gate off it.
>> 
>> I agree that this could be a concern. However, before we look for a solution, do
>> you have practical use case where you observes this?
>> 
>
> Yes, this solution[1] is used by NXP internally for former releases that we have two
> Level states for power Domains[2].
> We use state 0 (Low Power Mode with state retention) for device runtime pm support
> and state 1 (power off with no state retention) for system suspend resume case.
>
> Without [1], we will meet the issue that all domains runtime suspended will stay at
> low power mode instead of power off during system suspend which consumes more power.
>
> 1. https://source.codeaurora.org/external/imx/linux-imx/log/drivers/base/power?h=imx_4.14.78_1.0.0_ga
> 2. https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/soc/imx/pm-domains.c?h=imx_4.14.78_1.0.0_ga#n325
>
>> >
>> > Let's give the power domain a chance to switch to the deepest state in
>> > case it's already off but in an intermediate low power state.
>> >
>> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> > ---
>> >  drivers/base/power/domain.c | 18 +++++++++++++++++-
>> >  include/linux/pm_domain.h   |  1 +
>> >  2 files changed, 18 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 61cd500..847a69e 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -959,7 +959,17 @@ static void genpd_sync_power_off(struct
>> > generic_pm_domain *genpd, bool use_lock,  {
>> >         struct gpd_link *link;
>> >
>> > -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
>> > +       /*
>> > +        * Give the power domain a chance to switch to the deepest state
>> in
>> > +        * case it's already off but in an intermediate low power state.
>> > +        */
>> > +       genpd->state_idx_saved = genpd->state_idx;
>> > +
>> > +       if (genpd_is_always_on(genpd))
>> > +               return;
>> > +
>> > +       if (!genpd_status_on(genpd) &&
>> > +           genpd->state_idx == (genpd->state_count - 1))
>> >                 return;
>> 
>> This means that the ->power_off() callback may be called twice in a raw, for
>> the genpd in question and in cases of multiple idle states.
>> It could be a problem.
>> 
>> Well, currently it may not be a real issue, as I doubt there is rather few genpd
>> backend drivers supporting multiple idle states, but still.
>> 
>
> So far, I've no idea what the problem could be as there's no multi states power domain
> drivers in tree.

A problem could arise if the drivers need to do something before they
can switch from retention to OFF (e.g. save context).

AFAICT without seeing the affected drivers in your solution, I can't
tell if the drivers have an opportunity to save context to prepare for
off-mode.

> For IMX, there's no problem as the driver could handle it well.

In that case, I guess you're assuming that system suspsend will always
hit off-mode, so all your drivers always save context in their suspend
callbacks?

> The core code just provides an interface for driver to handle such requirement.

I think we're up against a terminology problem/confusion since we added
multiple states around what does "off" really mean.  For example, should
"off" mean in the deepest, possible state, or does it mean idle in the
last selected state?  

Before we had multiple states, it always meant the former, and the code
was built around the idea of really, truly off (zero volts, no
retention.)  With multiple states, it's now a bit ambigious.  In this
series, you're using it to mean both, which is part of the confusion.

Stated differently, while we technically have support for mulitple
states, in the core we still just have 2:

enum gpd_status {
    GPD_STATE_ACTIVE = 0,   /* PM domain is active */
    GPD_STATE_POWER_OFF,    /* PM domain is off */
};

So bascially we have to make a decsion whether retention is _ACTIVE or
_OFF.  This series is assuming it should be _OFF, but when we were
adding multiple states, I had always assumed retention states would be
considered _ACTIVE.  Yes, I know tha neither "active" nor "off"
accurately defines retention, but since there is still voltage applied,
it may not be active, but it's definitely not off.

When we were adding multiple states, I had always imagined domains with
multiple states would handle this kind of thing with a governor.
Retention states whould leave the domain in GPD_STATE_ACTIVE, and the
governor would then determine when to switch to the real off state.

Note that this gets you more flexiblity than just switching to off in
suspend.  You could also use the governor to let the domain switch to
off based on other criteria such as long idle time, or QoS criteria.

It seems you may be the first upstream solution to start really
exercising the multiple states, so we may still have some kinks to work
out, but thanks for pushing your changes upstream so we can work all
this out together.

Thanks,

Kevin
