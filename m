From: josh@joshtriplett.org
Subject: Re: [PATCH v3] drivers: cpufreq: Mark function as static in
 cpufreq.c
Date: Wed, 26 Feb 2014 14:16:51 -0800
Message-ID: <20140226221651.GA24021@cloud>
References: <20140226154625.GA10701@rashika>
 <1393432962-3647-1-git-send-email-rashika.kheria@gmail.com>
 <16591432.HQVTHU5NYJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53806 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaBZWQ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 17:16:57 -0500
Content-Disposition: inline
In-Reply-To: <16591432.HQVTHU5NYJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Feb 26, 2014 at 10:56:45PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 26, 2014 10:12:42 PM Rashika Kheria wrote:
> > Mark function as static in cpufreq.c because it is not
> > used outside this file.
> >=20
> > This eliminates the following warning in cpufreq.c:
> > drivers/cpufreq/cpufreq.c:355:9: warning: no previous prototype for=
 =E2=80=98show_boost=E2=80=99 [-Wmissing-prototypes]
> >=20
> > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
>=20
> v2 has been Reviewed-by: Josh already, right?

=46eel free to forward-propagate to v3 as well, if that helps.

> > ---
> > Changes since v1:
> > Incorrect Fix
> > Changes since v2:
> > Show Changelog
> >=20
> >  drivers/cpufreq/cpufreq.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 08ca8c9..54fd670 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(cpufreq_notify_post_transitio=
n);
> >  /*****************************************************************=
****
> >   *                          SYSFS INTERFACE                       =
   *
> >   *****************************************************************=
****/
> > -ssize_t show_boost(struct kobject *kobj,
> > +static ssize_t show_boost(struct kobject *kobj,
> >  				 struct attribute *attr, char *buf)
> >  {
> >  	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
> >=20
>=20
> --=20
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
