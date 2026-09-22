Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C58472079
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099508; cv=none; b=XPn3Sg0GU1TDIpAOjS651FfCdRIBWqfUq3ioAB8ERmdieZWP2al8Ng/ebIsn/3IDAdRm98vWhq4stxLEWXBIOUTWKQ6HIF8M6Vq23NL5yJzW6mDlHVlmAUrKepKNjQNYPtOe1XVL8dQ2Iy8vuLvkiWfi//hCysSRChNPF2Ldhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099508; c=relaxed/simple;
	bh=FQ9DS5iesg+Q/BcYhBZQGjCZ4nBfFql6vYXIjbJBC2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMvdtLa/3Q/i53PCgV8YabKDLd8hkRbj37UY92hGz+hBV7M3Fsqsn0uHDo5ZlALr8Yw/ZzPq5FUkdm4769aLAwfmawQKXujFfo13sspZ2dpPLmEkfy6Ee8TbNgwvCECLhu9oJ3JONU6EetGRfNqoEz8uZ59Z3++Hnc1dQOoXHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxBYbrYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxBYbrYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1981F00898
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099505;
	bh=pyNJDOLEfgLP4wzZmF4hygcfkmD+D8SQrjWiUmYWiXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GxBYbrYmMFsz5Vy+b6kBzPICmhxv00Xd2udX52Rym4khkegAoa2WbXpqvMrYcJ5mP
	 vjH63qxGez2wu2NvDv7qGD8f5sQwpaxOaAw/cQXyINCjVaoloNXuDGTzsnQvxdA2Mh
	 qbObK8Kx1P+jhbxxQxZ9Rvd3qWMF0hmCs5/rstrboxPB0O8DPUc8yXS2kR5+oKMnTm
	 NT4p2YN8ifmCK4m94lpb97h0TZF6Yw4OLjl8PM/pbtlo0Oe2WOOVi6A0MUM3TD9R87
	 CCo3ePHreZHnD+nOHS23u0VRmGOcuhHIe19833LcilBTrBwZ/tZmhYDqyoiK1oba6Y
	 heRZ7PJ0uj5Kg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16c81so24540e87.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 10:51:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwgcnOBvgLHIq7YiajKr4XXRvCFYJA+c1alXLLhQ4wF8DetdmvTxNJVEUCiJXNUhEq0rNTO+ZegaQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kzKfj+kWb8s1+PTjtk8aNJ0ZmPZEdYuirs2vImfi9sKTRo/sk9
	1igu/m4W5FFoKTlq4lQkeOgB6qGgACT3IgMtulYo6F914s8foSA3/6S8YZF8XNUSPX9wPgZjuRN
	RUHQGcX5rG+W8FBC/K2/+5XMAEWAOOXE=
X-Received: by 2002:a05:6512:1552:20b0:5b8:c147:f370 with SMTP id
 2adb3069b0e04-5b8d89c69abmr4823e87.52.1790099504207; Tue, 22 Sep 2026
 10:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-mb-pm-main-v1-0-1d4cbd9d2b2c@vt.edu> <20260921-mb-pm-main-v1-1-1d4cbd9d2b2c@vt.edu>
In-Reply-To: <20260921-mb-pm-main-v1-1-1d4cbd9d2b2c@vt.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 19:50:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jw=xzCw5Z_uDDKjAR_4BTPrEM51AXZQWGnbqSfB6wBYg@mail.gmail.com>
X-Gm-Features: AcwNN1W_WS704PDKarrDmCWjByh9KWW-Gc20nNiTf3MCqf6ACST5po8eafukvBM
Message-ID: <CAJZ5v0jw=xzCw5Z_uDDKjAR_4BTPrEM51AXZQWGnbqSfB6wBYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: sleep: publish pm_transition with release semantics
To: jaidevshastri@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:24=E2=80=AFAM Jaidev Shastri via B4 Relay
<devnull+jaidevshastri.vt.edu@kernel.org> wrote:
>
> From: Jaidev Shastri <jaidevshastri@vt.edu>
>
> Each dpm_*() phase function stores the current transition to
> pm_transition with a plain store before it schedules the asynchronous
> device callbacks. dev_pm_skip_resume() and pm_hibernate_is_recovering()
> read pm_transition.event from those callbacks, on other CPUs, with plain
> loads.

So how *exactly* is the race possible?

> Store the event with smp_store_release() and read it with
> smp_load_acquire().
>
> Found with MBCheck, a static herd7-based memory consistency checker.
>
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>  drivers/base/power/main.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e130da428..bf4b4fd1b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -78,7 +78,8 @@ static int async_error;
>   */
>  bool pm_hibernate_is_recovering(void)
>  {
> -       return pm_transition.event =3D=3D PM_EVENT_RECOVER;
> +       /* Pairs with the smp_store_release() in the dpm_*() phase functi=
ons. */
> +       return smp_load_acquire(&pm_transition.event) =3D=3D PM_EVENT_REC=
OVER;
>  }
>  EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
>
> @@ -682,10 +683,13 @@ static void dpm_watchdog_clear(struct dpm_watchdog =
*wd)
>   */
>  bool dev_pm_skip_resume(struct device *dev)
>  {
> -       if (pm_transition.event =3D=3D PM_EVENT_RESTORE)
> +       /* Pairs with the smp_store_release() in the dpm_*() phase functi=
ons. */
> +       int event =3D smp_load_acquire(&pm_transition.event);
> +
> +       if (event =3D=3D PM_EVENT_RESTORE)
>                 return false;
>
> -       if (pm_transition.event =3D=3D PM_EVENT_THAW)
> +       if (event =3D=3D PM_EVENT_THAW)
>                 return dev_pm_skip_suspend(dev);
>
>         return !dev->power.must_resume;
> @@ -902,7 +906,8 @@ static void dpm_noirq_resume_devices(pm_message_t sta=
te)
>         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
>
>         async_error =3D 0;
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>
>         mutex_lock(&dpm_list_mtx);
>
> @@ -1052,7 +1057,8 @@ void dpm_resume_early(pm_message_t state)
>         trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
>
>         async_error =3D 0;
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>
>         mutex_lock(&dpm_list_mtx);
>
> @@ -1230,7 +1236,8 @@ void dpm_resume(pm_message_t state)
>
>         trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>         async_error =3D 0;
>
>         mutex_lock(&dpm_list_mtx);
> @@ -1595,7 +1602,8 @@ static int dpm_noirq_suspend_devices(pm_message_t s=
tate)
>
>         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true)=
;
>
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>         async_error =3D 0;
>
>         mutex_lock(&dpm_list_mtx);
> @@ -1798,7 +1806,8 @@ int dpm_suspend_late(pm_message_t state)
>
>         trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
>
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>         async_error =3D 0;
>
>         wake_up_all_idle_cpus();
> @@ -2091,7 +2100,8 @@ int dpm_suspend(pm_message_t state)
>         devfreq_suspend();
>         cpufreq_suspend();
>
> -       pm_transition =3D state;
> +       /* Pairs with the smp_load_acquire() in dev_pm_skip_resume(). */
> +       smp_store_release(&pm_transition.event, state.event);
>         async_error =3D 0;
>
>         mutex_lock(&dpm_list_mtx);
>
> --
> 2.43.0
>
>
