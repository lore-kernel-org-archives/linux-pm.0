From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] fix cpufreq/cpufreq.c null pointer access issue
Date: Mon, 31 Aug 2015 12:49:20 +0530
Message-ID: <20150831071920.GB5215@linux>
References: <tencent_71BE8275037B1C3E4F56914E@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36314 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbHaHTZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 03:19:25 -0400
Received: by pacgr6 with SMTP id gr6so328115pac.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 00:19:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <tencent_71BE8275037B1C3E4F56914E@qq.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?5L+e5Lyf?= <yuwei06082130@foxmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, yuweieric <yuweieric@163.com>

On 29-08-15, 01:32, =E4=BF=9E=E4=BC=9F wrote:
> Hi,
> This patch fixes an issue in cpufreq_init_policy().
>=20
> Best regards,
> Yu Wei

You have done the right thing in the wrong way.

=46irstly, this is not how you send patches. Please read
Documentation/SubmittingPatches for right details..

Secondly, this is even more screwed up as you sent it as html :)

> Subject: [PATCH] cpufreq: print the last governor while restoring gov=
ernor
>=20
> Commit 35afd02e30d6 ("cpufreq: Initialize the governor again while
> restoring policy") clears policy->governor to initialize the governor

This isn't the patch which broke it, but this one:

6e2c89d16d98 ("cpufreq: move call to __find_governor() to cpufreq_init_=
policy()")

> while restoring governor. The policy->governor is NULL and
> find_governor() returns last used governor matching last_governor
> string, so print last_governor instead of policy->governor->name.
>=20

Add this line here:

=46ixes: 6e2c89d16d98 ("cpufreq: move call to __find_governor() to cpuf=
req_init_policy()")

> Signed-off-by: Yu Wei <yuweieric@163.com>
>=20
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7a3c30c..5a9e50e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1072,7 +1072,7 @@ static void cpufreq_init_policy(struct cpufreq_=
policy
> *policy)
>      gov =3D find_governor(policy->last_governor);
>      if (gov)
>          pr_debug("Restoring governor %s for cpu %d\n",
> -                policy->governor->name, policy->cpu);
> +                policy->last_governor, policy->cpu);

The right thing to do here is to print gov->name instead.

>      else
>          gov =3D CPUFREQ_DEFAULT_GOVERNOR;
> =20
> --
> 1.9.1
>=20
> SECURITY NOTE: file ~/.netrc must not be accessible by others

--=20
viresh
