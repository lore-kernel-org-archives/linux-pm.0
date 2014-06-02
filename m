From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] PM / Runtime: Make autosuspend_delay == 0 work as intended
Date: Mon, 02 Jun 2014 14:14:45 +0200
Message-ID: <3312453.gOy4hhKZIh@vostro.rjw.lan>
References: <1401704952-32046-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56994 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754292AbaFBL5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 07:57:32 -0400
In-Reply-To: <1401704952-32046-1-git-send-email-bjorn@mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

Alan has to see this in the first place.

On Monday, June 02, 2014 12:29:12 PM Bj=C3=B8rn Mork wrote:
> OK, I don't like the result I came up with here.  So I am sending thi=
s
> as an RFC in the hope that smarter people than me can come up with
> something nicer. I hope the patch illustrates my problem:  While
> trying do debug some runtime suspend issues in a driver, I temporaril=
y
> set autosuspend to 0 to deliberately make it aggressive enough for my
> driver to fail. I was surprised to learn than this effectively
> *disabled* autosuspend if the driver ever return -EBUSY from the
> runtime suspend callback.

That results from pm_runtime_autosuspend_expiration() always returning =
0 in
that case.

> I believe that is too unexpected to be
> acceptable. Either we should not allow 0, or we should make it work
> at least as well as 1.
>=20
>=20
> Bj=C3=B8rn
> 8<--------------
> We should always reschedule if the driver runtime suspend callback
> returns -EBUSY and the driver updated the last_busy time.  But if
> autosuspend_delay is 0, then this cannot be detected because
> pm_runtime_autosuspend_expiration() always returns 0.
>=20
> Fix by rescheduling if autosuspend_delay is 0.
>=20
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> ---
>  drivers/base/power/runtime.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtim=
e.c
> index 67c7938e430b..c52e630a2e54 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -421,6 +421,7 @@ static int rpm_suspend(struct device *dev, int rp=
mflags)
>  {
>  	int (*callback)(struct device *);
>  	struct device *parent =3D NULL;
> +	unsigned long retry_delay =3D 0;
>  	int retval;
> =20
>  	trace_rpm_suspend(dev, rpmflags);
> @@ -441,7 +442,7 @@ static int rpm_suspend(struct device *dev, int rp=
mflags)
>  	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
>  	if ((rpmflags & RPM_AUTO)
>  	    && dev->power.runtime_status !=3D RPM_SUSPENDING) {
> -		unsigned long expires =3D pm_runtime_autosuspend_expiration(dev);
> +		unsigned long expires =3D pm_runtime_autosuspend_expiration(dev) +=
 retry_delay;
> =20
>  		if (expires !=3D 0) {
>  			/* Pending requests need to be canceled. */
> @@ -571,8 +572,11 @@ static int rpm_suspend(struct device *dev, int r=
pmflags)
>  		 * reschedule another autosuspend.
>  		 */
>  		if ((rpmflags & RPM_AUTO) &&
> -		    pm_runtime_autosuspend_expiration(dev) !=3D 0)
> +		    (pm_runtime_autosuspend_expiration(dev) !=3D 0 ||
> +		     ACCESS_ONCE(dev->power.autosuspend_delay) =3D=3D 0)) {
> +			retry_delay++;
>  			goto repeat;
> +		}
>  	} else {
>  		pm_runtime_cancel_pending(dev);
>  	}

Well, as I said.

Perhaps pm_runtime_autosuspend_expiration() could simply treat
power.autosuspend_delay equal to 0 in a special way, but then what abou=
t
power.autosuspend_delay equal to 1?

Rafael

