From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] drivers: cpufreq: Mark function as static in cpufreq.c
Date: Thu, 27 Feb 2014 01:07:28 +0100
Message-ID: <2246444.oMnRuKn9p2@vostro.rjw.lan>
References: <20140226154625.GA10701@rashika> <16591432.HQVTHU5NYJ@vostro.rjw.lan> <20140226221651.GA24021@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140226221651.GA24021@cloud>
Sender: cpufreq-owner@vger.kernel.org
To: josh@joshtriplett.org
Cc: Rashika Kheria <rashika.kheria@gmail.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 26, 2014 02:16:51 PM josh@joshtriplett.org wrote=
:
> On Wed, Feb 26, 2014 at 10:56:45PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 26, 2014 10:12:42 PM Rashika Kheria wrote:
> > > Mark function as static in cpufreq.c because it is not
> > > used outside this file.
> > >=20
> > > This eliminates the following warning in cpufreq.c:
> > > drivers/cpufreq/cpufreq.c:355:9: warning: no previous prototype f=
or =E2=80=98show_boost=E2=80=99 [-Wmissing-prototypes]
> > >=20
> > > Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
> >=20
> > v2 has been Reviewed-by: Josh already, right?
>=20
> Feel free to forward-propagate to v3 as well, if that helps.

OK

Applied, thanks!

> > > ---
> > > Changes since v1:
> > > Incorrect Fix
> > > Changes since v2:
> > > Show Changelog
> > >=20
> > >  drivers/cpufreq/cpufreq.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.=
c
> > > index 08ca8c9..54fd670 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(cpufreq_notify_post_transit=
ion);
> > >  /***************************************************************=
******
> > >   *                          SYSFS INTERFACE                     =
     *
> > >   ***************************************************************=
******/
> > > -ssize_t show_boost(struct kobject *kobj,
> > > +static ssize_t show_boost(struct kobject *kobj,
> > >  				 struct attribute *attr, char *buf)
> > >  {
> > >  	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
> > >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
