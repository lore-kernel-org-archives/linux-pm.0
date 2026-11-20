Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193905;
	b=K9TC5oc9eN3BqKCMbE4wp6UwJfxO3FMxcMXBiarTmZuUD8hI3jtr90o8ewQBFMDaADm0
	 Vbge7UZ34XOqnMgV/sUbaMG1eJVbHUZQaUa9nIewMDIUyMxRznE50luopgKTLtUt7Ypmr
	 aFoDiPuu4FkoH3rO0bBniE97oMY/93hwveiWGFCweLTkamIcraBbBQZqs3C/JiUUSMbL3
	 RWJIaBmB2XKE9pzJ7Nvv0vcD2Q/rpGyyeyAX3E1f8xPwJV5wSmEeSappCqJl/BNuqE+Fe
	 L8x2QGxCUwJPI652wF8RAt+lKea9onsPuQVJuh/T9zOJY7Ydg5FtFZ7nfe6AaSmJ9kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193905;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9jZ4+rAq97xzIuC4xG2ZJWOZ5cooeGeG8AAMQWHuR3s=;
	b=oVq+y8xq2Fz5fPy6654ryMrWohlttKsN1RRT8uwb4IYmAVDL9k5CsEo03zt3lIdXBOnG
	 JF4WK8TCUoobuapCJi9JHpegK0IO9+PrDzKzJTJFCLrgjwsJIk9GW9CZSW5nMXzCNUumM
	 9LSA8kwrPq5HrYFcdEP03QwARONhXpUh9Wh5LmafJwEzrYX+dwSCQ9INzHWDXBARET5h/
	 Qp49bbFRD9HRp6j9r3g1roRxK/zTsK1AwoaqLwEHceRnY0m6kowaqVLpM7YH7f2QpT3l9
	 oHYST3YfQUTLFQ+vFB5/SMQ7jUp0OVEetq1Lr8metztQhFVNh4DGkq07QhfNrOIkEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7Cgjfm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C760A2600
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7Cgjfm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8749A1F000D1
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193904;
	bh=9jZ4+rAq97xzIuC4xG2ZJWOZ5cooeGeG8AAMQWHuR3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e7Cgjfm0heIEJ6EmMKuFcBWj2wbQaYtANOHNY4MWD0wOwtVMk6nn/vRJw0hDdeQNr
	 wuM1fDErsZZ67x8WBJvMaOyCg6Qp2mCLAbUl2/lsDcGyHV2hlOqKzaiHAHbGADp40l
	 mtjPSWarB1aHpUJLtizZL+PONygB71Ft6oI76m50oZtvyFJ0jHifL8jSFtOdYahJe0
	 LlZtSR/bFXaBx0fAdbag67wGv13aL9HhbepnliO0epowy+vvc34IqCvMYcFhP8H9EX
	 QiXhwkEPRYpfGBTlwmDMcYsZMMGMDbrmw68oON8UN7ETiX7VEktcITUOb4tRZmnd5X
	 kwXfPvnCcrhOg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be4fea434bso2234937e87.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:58:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErENjeodkNy3fl+x/RM6BQA3VMRoNnmymwhc2sn+rTlUnUZ/Tg54OQ503o696mlt7HEObIr6laZO0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bMjCLLg2gF99FfqBPk1kwCWM0QVb0kGTRpyGtHupVJo+bW2MA
	oIBz0CAkZ7CA3X2pgPI9PJ/p2E0QBW4L9ucPsPXRKSGKuB1sprxfiAGWDHyDJ/qvIzcsjz2oxJq
	29EW8PdlswBD0ViYgf3QRw9AENl0GrZw=
X-Received: by 2002:a05:6512:33d5:b0:5c1:ac5f:e596 with SMTP id
 2adb3069b0e04-5c1b7c18c90mr1682792e87.23.1795193902944; Fri, 20 Nov 2026
 08:58:22 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113223501.1581-3-blum@kernel.org>
In-Reply-To: <20261113223501.1581-3-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:58:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ifrYQrGXbKZ8fy4eRok_pyOiMc7wbLNxCvKv=nvyDUiQ@mail.gmail.com>
X-Gm-Features: Aa3M54pp-AFDmJfBzgfjF-_mLzo7QeN4NbEY4VMq9mgjnl0e0FKueW5bPTEo4rE
Message-ID: <CAJZ5v0ifrYQrGXbKZ8fy4eRok_pyOiMc7wbLNxCvKv=nvyDUiQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: intel: powerclamp: Use guard(mutex) to
 simplify the code
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 11:35=E2=80=AFPM Thorsten Blum <blum@kernel.org> wr=
ote:
>
> Use guard(mutex) to replace explicit mutex_{lock,unlock}() calls.
>
> Simplify the return paths and drop redundant ret initializations in
> duration_set(), window_size_set(), and powerclamp_set_cur_state().
>
> In cpumask_set(), use __free(free_cpumask_var) to remove all goto
> statements.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 89 +++++++++---------------
>  1 file changed, 33 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index df898fc3f3e6..3c031ce2a80c 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -80,25 +80,22 @@ static unsigned int window_size;
>
>  static int duration_set(const char *arg, const struct kernel_param *kp)
>  {
> -       int ret =3D 0;
> +       int ret;
>         unsigned long new_duration;
>
>         ret =3D kstrtoul(arg, 10, &new_duration);
>         if (ret)
> -               goto exit;
> +               return ret;
>         if (new_duration > 25 || new_duration < 6) {
>                 pr_err("Out of recommended range %lu, between 6-25ms\n",
>                         new_duration);
> -               ret =3D -EINVAL;
> -               goto exit;
> +               return -EINVAL;
>         }
>
> -       mutex_lock(&powerclamp_lock);
> +       guard(mutex)(&powerclamp_lock);
>         duration =3D new_duration * 1000;
> -       mutex_unlock(&powerclamp_lock);
> -exit:
>
> -       return ret;
> +       return 0;
>  }
>
>  static int duration_get(char *buf, const struct kernel_param *kp)
> @@ -146,31 +143,25 @@ static bool check_invalid(const struct cpumask *mas=
k, u8 idle)
>
>  static int cpumask_set(const char *arg, const struct kernel_param *kp)
>  {
> -       cpumask_var_t new_mask;
> +       cpumask_var_t new_mask __free(free_cpumask_var) =3D CPUMASK_VAR_N=
ULL;
>         int ret;
>
> -       mutex_lock(&powerclamp_lock);
> +       guard(mutex)(&powerclamp_lock);
>
>         /* Can't set mask when cooling device is in use */
> -       if (powerclamp_data.clamping) {
> -               ret =3D -EAGAIN;
> -               goto skip_cpumask_set;
> -       }
> +       if (powerclamp_data.clamping)
> +               return -EAGAIN;
>
> -       if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
> -               ret =3D -ENOMEM;
> -               goto skip_cpumask_set;
> -       }
> +       if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
> +               return -ENOMEM;
>
>         ret =3D bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
>                            nr_cpumask_bits);
>         if (ret)
> -               goto free_cpumask_set;
> +               return ret;
>
> -       if (cpumask_empty(new_mask) || check_invalid(new_mask, max_idle))=
 {
> -               ret =3D -EINVAL;
> -               goto free_cpumask_set;
> -       }
> +       if (cpumask_empty(new_mask) || check_invalid(new_mask, max_idle))
> +               return -EINVAL;
>
>         /*
>          * When module parameters are passed from kernel command line
> @@ -179,14 +170,7 @@ static int cpumask_set(const char *arg, const struct=
 kernel_param *kp)
>          * cpumask can be allocated and copied before here. Also
>          * in this case this cpumask is used as the default mask.
>          */
> -       ret =3D allocate_copy_idle_injection_mask(new_mask);
> -
> -free_cpumask_set:
> -       free_cpumask_var(new_mask);
> -skip_cpumask_set:
> -       mutex_unlock(&powerclamp_lock);
> -
> -       return ret;
> +       return allocate_copy_idle_injection_mask(new_mask);
>  }
>
>  static int cpumask_get(char *buf, const struct kernel_param *kp)
> @@ -264,25 +248,22 @@ static struct powerclamp_calibration_data cal_data[=
MAX_TARGET_RATIO];
>
>  static int window_size_set(const char *arg, const struct kernel_param *k=
p)
>  {
> -       int ret =3D 0;
> +       int ret;
>         unsigned long new_window_size;
>
>         ret =3D kstrtoul(arg, 10, &new_window_size);
>         if (ret)
> -               goto exit_win;
> +               return ret;
>         if (new_window_size > 10 || new_window_size < 2) {
>                 pr_err("Out of recommended window size %lu, between 2-10\=
n",
>                         new_window_size);
> -               ret =3D -EINVAL;
> -               goto exit_win;
> +               return -EINVAL;
>         }
>
>         window_size =3D new_window_size;
>         smp_mb();
>
> -exit_win:
> -
> -       return ret;
> +       return 0;
>  }
>
>  static const struct kernel_param_ops window_size_ops =3D {
> @@ -507,10 +488,9 @@ static void poll_pkg_cstate(struct work_struct *dumm=
y)
>         msr_last =3D msr_now;
>         tsc_last =3D tsc_now;
>
> -       mutex_lock(&powerclamp_lock);
> +       guard(mutex)(&powerclamp_lock);
>         if (powerclamp_data.clamping)
>                 schedule_delayed_work(&poll_pkg_cstate_work, HZ);
> -       mutex_unlock(&powerclamp_lock);
>  }
>
>  static struct idle_inject_device *ii_dev;
> @@ -634,9 +614,8 @@ static int powerclamp_get_max_state(struct thermal_co=
oling_device *cdev,
>  static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long *state)
>  {
> -       mutex_lock(&powerclamp_lock);
> +       guard(mutex)(&powerclamp_lock);
>         *state =3D powerclamp_data.target_ratio;
> -       mutex_unlock(&powerclamp_lock);
>
>         return 0;
>  }
> @@ -644,15 +623,15 @@ static int powerclamp_get_cur_state(struct thermal_=
cooling_device *cdev,
>  static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long new_target_ratio)
>  {
> -       int ret =3D 0;
> +       int ret;
>
> -       mutex_lock(&powerclamp_lock);
> +       guard(mutex)(&powerclamp_lock);
>
>         new_target_ratio =3D clamp(new_target_ratio, 0UL,
>                                 (unsigned long) (max_idle - 1));
>
>         if (powerclamp_data.target_ratio =3D=3D new_target_ratio)
> -               goto exit_set;
> +               return 0;
>
>         if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
>                 pr_info("Start idle injection to reduce power\n");
> @@ -660,23 +639,21 @@ static int powerclamp_set_cur_state(struct thermal_=
cooling_device *cdev,
>                 ret =3D start_power_clamp();
>                 if (ret)
>                         powerclamp_data.target_ratio =3D 0;
> -               goto exit_set;
> -       } else  if (powerclamp_data.target_ratio > 0 && new_target_ratio =
=3D=3D 0) {
> +               return ret;
> +       }
> +
> +       if (powerclamp_data.target_ratio > 0 && new_target_ratio =3D=3D 0=
) {
>                 pr_info("Stop forced idle injection\n");
>                 end_power_clamp();
>                 powerclamp_data.target_ratio =3D 0;
> -       } else  /* adjust currently running */ {
> -               unsigned int runtime;
> -
> -               powerclamp_data.target_ratio =3D new_target_ratio;
> -               runtime =3D get_run_time();
> -               idle_inject_set_duration(ii_dev, runtime, duration);
> +               return 0;
>         }
>
> -exit_set:
> -       mutex_unlock(&powerclamp_lock);
> +       /* adjust currently running */
> +       powerclamp_data.target_ratio =3D new_target_ratio;
> +       idle_inject_set_duration(ii_dev, get_run_time(), duration);
>
> -       return ret;
> +       return 0;
>  }
>
>  /* bind to generic thermal layer as cooling device*/
>

Applied as 7.5 material, thanks!
