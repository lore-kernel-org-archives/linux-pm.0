Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395F5908DE
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655802; cv=none; b=Lm/BHrBQo4i5P78IcB9yNUkx3Uf7rDAYH5Pa7BhmQlVFB9sqAEYhAfnE3VdoFrNJAvB+nuPvHZMBE97LOuVuezGQ0d/1kkrs0zQlYNKdCBptXxiZmsQzh5wYMpa7S3tS7fen5Vz11n3PU510DIQhC3zqZGhn6vUSkn11k7Wxuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655802; c=relaxed/simple;
	bh=qXfADDzsfmD+8zF+G8Ti+6sPkyfTJNIlgRnwzG3jmII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rimzJ36KiTKaYlRL1f3IRsABOkrd7IW+RQ3OVdt04yw7Z7snP8efHxXKCTT8Wy7cV7sWHZoQVOLWTk41zrNkxu0jHkWxRWFAbYe2OboJ6Rmxv3LNR+EMzvLaVJsTL8ivNx+hdEg2AtXU8aokAy9NKSrwT3wHICkLqYqdkN8fheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7neBrWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7neBrWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52D61F00898
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655800;
	bh=YJ9By9xlanJ7LT/vqhWLGY4bzMDNOpTYeD6ECVxBkSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B7neBrWGA7q0fAr6Y8IPM384lbYMzPvuWg0Efy5OAPCJcpdSr+3oBybuQ8nkAd4En
	 Vxjc6CBcTPX585O7Pw4hOO4oEUOEzMVMbxVfLf9BQdX5PfNDgku4H/zP/fJeOvmNRV
	 ydn7x5ZipZgmtJ07/QIifOn4S0ZRCrH7wyiTBUVzDwc+QU0JpG1MJWz2lJi+P7mu0w
	 jmDufHcNczReAgPqCLFaq+TFTqTnCYvhwnGLNf9lppieH0V1b9ivZ1KJwaJaiZ/HXZ
	 DggqWa8QnBUbyDr+rBLEjyz6cFxi+IojaB3zEYJBI6rVMUtgd59b6GYXB06ONrM7kd
	 DjhkBVtX/TIJg==
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso506594e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 07:36:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwsb25pRF36/lyEgoh3/Zrdzkf5wF3ZO1TLRjAtm65+2xX8FTBBpxu4OPyPNewFkKZjRJs6w67FMw==@vger.kernel.org
X-Gm-Message-State: AFuF++kIQzB+kyO2izmIEEUkTk/NojlzhjLGhisMVH4BNC3aRU0cWymb
	qjbPznLIdFkwNopIasIV7yW96aAPFBfH1Rx4zN2hnVrtFIIt/Mnr89N8X/mMB4e+GvzXDP4CBB4
	VFbFN7cgUDjbgRib2UDSPk1JfleY6gq8=
X-Received: by 2002:a05:6102:50ab:b0:7a1:b6c2:56df with SMTP id
 ada2fe7eead31-7a1b6c27177mr4845476137.10.1789655799951; Thu, 17 Sep 2026
 07:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904073844.2740931-1-saranya.gopal@intel.com>
In-Reply-To: <20260904073844.2740931-1-saranya.gopal@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 17 Sep 2026 16:35:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLxKdg_4Fs2uJAq20=jd=6PrFKW55xGc=83JWYk7_S8A@mail.gmail.com>
X-Gm-Features: AcwNN1UnHgaYXwQ_ob6pRJUfKwZEiwXBier1kCP2NyWNC_JSXhs9r5sdKCmW2nI
Message-ID: <CAJZ5v0hLxKdg_4Fs2uJAq20=jd=6PrFKW55xGc=83JWYk7_S8A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: s2idle: Add _Ixx GPE wake indicator support
To: Saranya Gopal <saranya.gopal@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 9:38=E2=80=AFAM Saranya Gopal <saranya.gopal@intel.c=
om> wrote:
>
> ACPI 6.6 defines _Ixx indicator objects under \_GPE to mark GPEs that
> should remain wake-enabled in s2idle without a _PRW association.
> To support them, add new function acpi_setup_ixx_gpes() that looks for
> _Ixx objects for all GPEs in the FADT 0/1 blocks and if it finds any, it
> marks the corresponding GPE as wake-capable, in which case the GPE is
> also enabled so long as it has a handler method because marking it as
> wake-capable causes acpi_update_all_gpes() to skip it. Since that only
> needs to be done if suspend-to-idle is enabled, make acpi_s2idle_setup()
> call that new function.
>
> For now, this is limited to x86 systems and it assumes that the GPEs
> with _Ixx will not cause spurious wakeups to occur while suspended.
>
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>

Applied as 7.4 material, thanks!

> ---
>  drivers/acpi/x86/s2idle.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index b6b1dd76a06b..ac49f9e75fae 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -24,6 +24,31 @@
>
>  #ifdef CONFIG_SUSPEND
>
> +static void acpi_setup_ixx_gpes(void)
> +{
> +       acpi_handle gpe_root;
> +       unsigned int i;
> +       char gpe_nr_str[5];
> +
> +       if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_GPE", &gpe_root)))
> +               return;
> +
> +       for (i =3D 0; i <=3D 0xff; i++) {
> +               scnprintf(gpe_nr_str, sizeof(gpe_nr_str), "_I%02X", i);
> +               if (!acpi_has_method(gpe_root, gpe_nr_str))
> +                       continue;
> +               /*
> +                * Enable the GPE if it has a handler method because mark=
ing it
> +                * as wake-capable causes acpi_update_all_gpes() to skip =
it.
> +                */
> +               if (ACPI_FAILURE(acpi_enable_gpe_cond(NULL, i, ACPI_GPE_D=
ISPATCH_METHOD)))
> +                       continue;
> +               acpi_mark_gpe_for_wake(NULL, i);
> +               acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
> +               pm_pr_dbg("ACPI: GPE 0x%02x armed for wake via %s\n", i, =
gpe_nr_str);
> +       }
> +}
> +
>  static bool sleep_no_lps0 __read_mostly;
>  module_param(sleep_no_lps0, bool, 0644);
>  MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device inte=
rface");
> @@ -649,6 +674,7 @@ void __init acpi_s2idle_setup(void)
>  {
>         acpi_scan_add_handler(&lps0_handler);
>         s2idle_set_ops(&acpi_s2idle_ops_lps0);
> +       acpi_setup_ixx_gpes();
>  }
>
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
> --
> 2.34.1
>
>
