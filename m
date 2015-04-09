From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH V4 1/3] Thermal: initialize thermal zone device correctly
Date: Thu, 9 Apr 2015 15:56:44 +0100
Message-ID: <20150409145644.GB27702@e104805>
References: <1428373476-14257-1-git-send-email-rui.zhang@intel.com>
 <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:49853 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755600AbbDIO4q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Apr 2015 10:56:46 -0400
In-Reply-To: <1428373476-14257-2-git-send-email-rui.zhang@intel.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 07, 2015 at 03:24:34AM +0100, Zhang Rui wrote:
> After thermal zone device registered, as we have not read any
> temperature before, thus tz->temperature should not be 0, which actually
> means 0C, and thermal trend is not available.
> In this case, we need specially handling for the first
> thermal_zone_device_update().
> 
> Both thermal core framework and step_wise governor is enhanced to handle this.
> 
> CC: <stable@vger.kernel.org> #3.18+
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c    | 15 +++++++++++++--
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
>  drivers/thermal/thermal_core.h |  1 +
>  include/linux/thermal.h        |  3 +++
>  4 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 5a0f12d..c2bb37c 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -63,6 +63,16 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>  	next_target = instance->target;
>  	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
>  
> +	if (!instance->initialized) {
> +		if (throttle) {
> +			next_target = (cur_state + 1) >= instance->upper ?
> +					instance->upper :
> +					((cur_state + 1) < instance->lower ?
> +					instance->lower : (cur_state + 1));
> +		} else
> +			next_target = THERMAL_NO_TARGET;

CodingStyle says that if one branch of an if statement needs braces,
all branches must have braces:

if (condition) {
        do_this();
        do_that();
} else {
        otherwise();
}

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/CodingStyle#n169

> +	}
> +

I pointed out before and I think Eduardo has said it as well.  I think
you should "return next_target;" at the end of the "if
(!instance->initialized)"

>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
>  		if (throttle) {

Cheers,
Javi

