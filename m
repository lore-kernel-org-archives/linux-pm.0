From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RESEND PATCH] thermal: helpers: Check return value of get_temp
Date: Thu, 28 Jul 2016 16:50:03 +0800
Message-ID: <1469695803.2367.106.camel@intel.com>
References: <1465232019-12441-1-git-send-email-rklein@nvidia.com>
	 <7cf6dc8c-d914-d978-8550-440717bd9b77@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15868 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbcG1IuK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jul 2016 04:50:10 -0400
In-Reply-To: <7cf6dc8c-d914-d978-8550-440717bd9b77@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On =E4=BA=8C, 2016-07-05 at 12:22 -0400, Rhyland Klein wrote:
> On 6/6/2016 12:53 PM, Rhyland Klein wrote:
> >=20
> > Check the return value of get_temp, which can fail. If it does,
> > then
> > unlock and return the error code.
> >=20
> > Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> > ---
> > =C2=A0drivers/thermal/thermal_helpers.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/thermal/thermal_helpers.c
> > b/drivers/thermal/thermal_helpers.c
> > index 5e1c160944c9..dc260749f8d6 100644
> > --- a/drivers/thermal/thermal_helpers.c
> > +++ b/drivers/thermal/thermal_helpers.c
> > @@ -90,6 +90,10 @@ int thermal_zone_get_temp(struct
> > thermal_zone_device *tz, int *temp)
> > =C2=A0	mutex_lock(&tz->lock);
> > =C2=A0
> > =C2=A0	ret =3D tz->ops->get_temp(tz, temp);
> > +	if (!ret) {
> > +		mutex_unlock(&tz->lock);
> > +		goto exit;
> > +	}
> > =C2=A0
> > =C2=A0	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz-
> > >emul_temperature) {
> > =C2=A0		for (count =3D 0; count < tz->trips; count++) {
> >=20
> I haven't seen any comments on this patch, has anyone had a chance to
> review it yet?

Patch applied, it would be merged together with the thermal reorg
patches.

thanks,
rui
