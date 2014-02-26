From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] drivers: cpufreq: Mark function as static in cpufreq.c
Date: Wed, 26 Feb 2014 22:56:45 +0100
Message-ID: <16591432.HQVTHU5NYJ@vostro.rjw.lan>
References: <20140226154625.GA10701@rashika> <1393432962-3647-1-git-send-email-rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53883 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752895AbaBZVlp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2014 16:41:45 -0500
In-Reply-To: <1393432962-3647-1-git-send-email-rashika.kheria@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rashika Kheria <rashika.kheria@gmail.com>
Cc: josh@joshtriplett.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, February 26, 2014 10:12:42 PM Rashika Kheria wrote:
> Mark function as static in cpufreq.c because it is not
> used outside this file.
>=20
> This eliminates the following warning in cpufreq.c:
> drivers/cpufreq/cpufreq.c:355:9: warning: no previous prototype for =E2=
=80=98show_boost=E2=80=99 [-Wmissing-prototypes]
>=20
> Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>

v2 has been Reviewed-by: Josh already, right?

> ---
> Changes since v1:
> Incorrect Fix
> Changes since v2:
> Show Changelog
>=20
>  drivers/cpufreq/cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 08ca8c9..54fd670 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(cpufreq_notify_post_transition)=
;
>  /*******************************************************************=
**
>   *                          SYSFS INTERFACE                         =
 *
>   *******************************************************************=
**/
> -ssize_t show_boost(struct kobject *kobj,
> +static ssize_t show_boost(struct kobject *kobj,
>  				 struct attribute *attr, char *buf)
>  {
>  	return sprintf(buf, "%d\n", cpufreq_driver->boost_enabled);
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
