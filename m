Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AB3E9C17
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527978; cv=none; b=PxELCrSg6QRhWsTmV39Hd2MOp0C8YiWjQpqUbyGiIhv5c9cbyUKjAbbLu5tlRnBCcLIVwwHV+g/tpw7sDHiu95gWdzhVGau+uPbBapTDeHq8Iq3p6Ux7HNSofBxls3EjZbNm8tHokh7xarrEvKSbDVJs4uaqwSZIb7GqO0N2l+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527978; c=relaxed/simple;
	bh=GXD7zH2qIJRt0KkgrA97ul/q1ROmZAC24+KHDm6gIDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPOV/0h/j47V3sInuuZjfSdJ07S7QQcHtKbazf0VKksZlsv/d8qiI63z/HajcGtMT5kWBdP088NdCC25b3ga7ziMOY4qfMBq1eAJPSX6z+Nj/8YWdHiyBBq7NhKcEQrE9TJtg7bEgfF4/1msOOLIMa58tGEW149o+g5MRLLc2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkGoW7ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkGoW7ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F301F00A3D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527975;
	bh=82UL9N9XStIY4v0MSPhTksMMT1/SR3fZlj7u8qqk05I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CkGoW7ZE6pMK/KccVNpmU23LisaMxBEJWnfVx9z3U07pxE58HeKGdKz6mpZBMpQvU
	 NsIcYldHBHQvE554BuqIWXGusvLP+GIaCaKAcLXQuYvdw59tdualYEQ8/ifl2kF9mZ
	 qXabuCfRI5JsC2oE59GcgQ5vuX3etj/fz7Q2hg0ZKAaTQKtF38D4bmHEN1pLicGuE6
	 DRnVUYDKXyNb5ZFOFL8zq+azDMqVbsD2nEYxXBEagJ6OlYtH3U9NtEq4MleDzku2zf
	 xnB70qsXXw7HreKYchcJorXHutrbzEmYLi9U8XSIWJiwuW5geNiZ5qUlusd4Xi5usR
	 hP/OxtY2EGGQw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso16678851fa.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 06:19:35 -0700 (PDT)
X-Gm-Message-State: AFuF++kpt7zcdoy/KCEy5R+RkwbjFaN01ymv464moJPfwcQY9ZHchxaQ
	9I5W9TLv4sIwPZbR1F0GkHKu7fNG3VAdr+HdQrDpcQyJc3VQAws+RqJXIIOxAacAhvNEae+KnHt
	uENLA63eJuGERxLRVmAK0qfibr+bucSk=
X-Received: by 2002:a05:651c:a181:b0:3a4:178:7a6f with SMTP id
 38308e7fff4ca-3a401787e99mr1250481fa.18.1788527972857; Fri, 04 Sep 2026
 06:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>
In-Reply-To: <20260831222926.34698-1-todd.e.brandt@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 15:18:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPuf4wpqMgMUVEAvETcyKVNvSXK6=Fe0DYfHbp-J1zLQ@mail.gmail.com>
X-Gm-Features: AcwNN1UagRzcxplFiS8Qt6ZUG_Kn3CpdLlDgesjMrCgPHlbHXXbUFT8rb9PjIzU
Message-ID: <CAJZ5v0gPuf4wpqMgMUVEAvETcyKVNvSXK6=Fe0DYfHbp-J1zLQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: dpm_show_time changes to suspend/resume dmesg prints
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net, 
	todd.e.brandt@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 12:29=E2=80=AFAM Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
>
> Organize the optional dpm_show_time prints to focus on the 8 possible
> suspend/resume callbacks devices can use and their associated phases
> when they're called in suspend:
>
> Remove "start suspend" as it is currently a combination of "suspend" and
> "suspend prepare". Replace it with "prepare suspend" as a separate print.
> Add "complete resume" over the dpm_complete call. For example:
>
> [   66.680479] PM: suspend entry (s2idle)
> [   66.826646] PM: prepare suspend of devices complete after 114.081 msec=
s
> [   67.119306] PM: suspend of devices complete after 292.639 msecs
> [   67.121309] PM: late suspend of devices complete after 1.983 msecs
> [   67.190184] PM: noirq suspend of devices complete after 68.309 msecs
> [   81.227706] PM: noirq resume of devices complete after 49.196 msecs
> [   81.230847] PM: early resume of devices complete after 2.922 msecs
> [   82.444735] PM: resume of devices complete after 1213.869 msecs
> [   82.447943] PM: complete resume of devices complete after 2.850 msecs
> [   82.457131] PM: suspend exit
>
> v2 change: replace error variable with NULL in dpm_complete
>
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> ---
>  drivers/base/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e130da428141..7496f76bf9f8 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1329,6 +1329,7 @@ static void device_complete(struct device *dev, pm_=
message_t state)
>  void dpm_complete(pm_message_t state)
>  {
>         struct list_head list;
> +       ktime_t starttime =3D ktime_get();
>
>         trace_suspend_resume(TPS("dpm_complete"), state.event, true);
>
> @@ -1358,6 +1359,7 @@ void dpm_complete(pm_message_t state)
>         thermal_pm_complete();
>         /* Allow device probing and trigger re-probing of deferred device=
s */
>         device_unblock_probing();
> +       dpm_show_time(starttime, state, NULL, "complete");

Integer 0 should be passed to the above, not NULL.

>         trace_suspend_resume(TPS("dpm_complete"), state.event, false);
>  }
>
> @@ -2352,6 +2354,7 @@ int dpm_suspend_start(pm_message_t state)
>         int error;
>
>         error =3D dpm_prepare(state);
> +       dpm_show_time(starttime, state, error, "prepare");
>         if (error)
>                 dpm_save_failed_step(SUSPEND_PREPARE);
>         else {
> @@ -2359,7 +2362,6 @@ int dpm_suspend_start(pm_message_t state)
>                 error =3D dpm_suspend(state);
>         }
>
> -       dpm_show_time(starttime, state, error, "start");
>         return error;
>  }
>  EXPORT_SYMBOL_GPL(dpm_suspend_start);
> --
> 2.34.1
>
>
