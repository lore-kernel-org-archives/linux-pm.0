From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 1/5] power: domain: add pm_genpd_exit
Date: Wed, 9 Dec 2015 11:47:58 +0100
Message-ID: <20151209104752.GB1036@omega>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
 <1449251148-19344-2-git-send-email-eric@anholt.net>
 <5665599A.4060509@nvidia.com>
 <7h8u54lqbv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7h8u54lqbv.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Dec 08, 2015 at 10:59:00AM -0800, Kevin Hilman wrote:
> Jon Hunter <jonathanh@nvidia.com> writes:
> 
> > On 04/12/15 17:45, Eric Anholt wrote:
> >> From: Alexander Aring <alex.aring@gmail.com>
> >> 
> >> This patch adds function pm_genpd_exit for undo a pm_genpd_init. This
> >> is useful for multiple power domains while probing. If the probing fails
> >> after one pm_genpd_init was called we need to undo all previous
> >> registrations of generic pm domains inside the gpd_list list.
> >> 
> >> There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
> >> registered power domains and not registered domains, the driver can use
> >> this mechanism to have an array with registered and non-registered power
> >> domains, where non-registered power domains are NULL.
> >> 
> >> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >> Cc: Kevin Hilman <khilman@kernel.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: Pavel Machek <pavel@ucw.cz>
> >> Cc: Len Brown <len.brown@intel.com>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>  drivers/base/power/domain.c | 22 ++++++++++++++++++++++
> >>  include/linux/pm_domain.h   |  4 ++++
> >>  2 files changed, 26 insertions(+)
> >> 
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index 167418e..e7aca27 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -1509,6 +1509,28 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> >>  }
> >>  EXPORT_SYMBOL_GPL(pm_genpd_init);
> >>  
> >> +/**
> >> + * pm_genpd_exit - Uninitialize a generic I/O PM domain object.
> >> + * @genpd: PM domain object to uninitialize.
> >> + */
> >> +void pm_genpd_exit(struct generic_pm_domain *genpd)
> >> +{
> >> +	if (IS_ERR_OR_NULL(genpd))
> >> +		return;
> >> +
> >> +	/* check if domain is still in registered inside the pm subsystem */
> >> +	WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
> >> +		     !list_empty(&genpd->slave_links) ||
> >> +		     !list_empty(&genpd->dev_list));
> >> +
> >
> > Why not return an error here? Seems bad to remove it, if it could still
> > be referenced by other domains.
> 
> I had pointed this out as well in an earlier review.
> 

I talked with Ulf Hansson about such handling and there exists currently
no handling to remove the pm_genpd on error handling (what our use case
is for RPi domains).

The real solution would be a "pm_genpd_exit_recursive" functionality to
remove subdomains, etc -> simple everything. Anway I am not a expert into
power domain functionality and this simple approach was enough to him to
add "something" which we have actually a lack of support.


Now "returning an errno" here:

I don't know how it should be handled in an "error handling" case. The
WARN_ON_ONCE should say "somebody use this API wrong" which is a very
unlikely case.
These lists should be empty when calling pm_genpd_exit before in any case.


Example: the error case is while probing, how we react on a -EBUSY there
"in an error case" -> simple ignore it? But then nobody see that the use
of this function is wrong.

Should it be something like that?

err_probe:
	WARN_ON_ONCE(pm_genpd_exit(foo) < 0);

This function should be "void" here, I never saw some unregistration
functionality which returns some "int" for error handling. Which brings
us back to the "real" solution, a "pm_genpd_exit_recursive" functionality
which unregister everything which belongs to a "generic_pm_domain".

To have a "pm_genpd_exit" is only the first step. That we can improve error
handling for pm_genpd_init. (Which RPi power domains use and doesn't
register any subdomains, etc. for probing).

> > Also not sure if you need to lock around the above test and removing the
> > domain.
> >
> >> +	mutex_lock(&gpd_list_lock);
> >> +	list_del(&genpd->gpd_list_node);
> >> +	mutex_unlock(&gpd_list_lock);
> >> +
> >> +	mutex_destroy(&genpd->lock);
> >> +}
> >> +EXPORT_SYMBOL_GPL(pm_genpd_exit);
> >> +
> >
> > BTW, I had just submitted a similar patch here [0]. So I would also like
> > to see such an API added.
> 

:-)

> Between the two of you, maybe come up with an agreed upon patch and
> re-submit.
> 
> Kevin
> 
> > Cheers
> > Jon
> >
> > [0] http://marc.info/?l=devicetree&m=144924138932726&w=2
