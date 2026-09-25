Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229634854EB
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357878; cv=none; b=MrHI7prBm9ZT9bTXENVrpiUNMYAiPQGE26TxsrMpvMXJtac2Ssij3Fu9W2bVxc4XoFWA8vp3P95D5YCSZZ0lOOTm2MRwjI5fnAPVYruRXhsv8XeRcoAbDW7wiM9U/utKTsKoS4BDRxipIrDF0J32WTJ9YMwAppFuxuzuiTn536M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357878; c=relaxed/simple;
	bh=Bdl08usoKa5ZLUDFYc2INVDx6kIHXm3j1JVQnycIzAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACJnDHAiKDZiri1ZUZFU+8XUU/ROu2NmcVZtcjKHeGb7CrpZ02GXTy5qbE4Fnj/WEUbgmIPKfBCvzJZRSiOuqAHCpp7WivlsLRdVK9l9WoZ7SYlkIuoZGMhE0WnMcKszXZu7lXwpZTdqPhReQp7cdRLRj63DhgCGOzIkmbO8X98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1IiK30x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1IiK30x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B7E1F00893
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357876;
	bh=fHsW8/DFZORknHBuSvP/MhtmL9u48N0qxeDqzEMHIFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J1IiK30xByLTifqrJZPNP7pkKrKHSgjirje+BXzReFYTUKtLUD8K2ExghgiDDN4VM
	 TqCTH5hqtGEtSrjPjgGfK+N73J9HcdDC05kwaOyObknSucQ7qcxtGWtN7IGuP8BdkL
	 K1Ud+Dzxn4kwGWPCvXxDCD2XN1KN9k/COIDZOb2DjqnNpqPVunPvDhFlmbbhzaAaJl
	 xpteHchtdMkxA9eMkLjYtmV+K1nS8vn4CZbqUkc2VPwMugUBhcaDzV+mSOtoaOgj0F
	 zEDIhPNAPmE75iHkxluJ1gA9O/n3qxhbk0UsEQv6toPRe1rMMMlyp2RekI6Tw2SC8U
	 DLq+mM83tdJeg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a3156692c6so8347161fa.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 10:37:56 -0700 (PDT)
X-Gm-Message-State: AFuF++mopy5NiXFJkWd9BaWeVfh3yZWUUbDJKX9DARqHiQa1PHiguxMJ
	tOe3gs1PC04+v+iMo+fkoGvr75Vf9RebRYZRYdFi/gd6PnNoECkNQi13wLjCU2v3srugwpOzGbC
	FvR8K7M99IsapzEVaGUh6fsiRZAKdim8=
X-Received: by 2002:a2e:a596:0:b0:3a3:74b7:fc03 with SMTP id
 38308e7fff4ca-3a63c0f53efmr17009951fa.15.1790357875094; Fri, 25 Sep 2026
 10:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915131310.1053834-1-aharivel@redhat.com> <20260915131310.1053834-2-aharivel@redhat.com>
In-Reply-To: <20260915131310.1053834-2-aharivel@redhat.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 19:36:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-EC+kvo0wPEVv8FmL56UQuXqhZvFHEb8t1+qhfoDLqQ@mail.gmail.com>
X-Gm-Features: AclHuK9Q1SZqt3r_g5KTt1HbKlHHGOBg8LuKOQuSFEPhRy8I7-wLps_FCe6cYPQ
Message-ID: <CAJZ5v0h-EC+kvo0wPEVv8FmL56UQuXqhZvFHEb8t1+qhfoDLqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpuidle: add per-CPU latency_limit_ns sysfs attribute
To: Anthony Harivel <aharivel@redhat.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:13=E2=80=AFPM Anthony Harivel <aharivel@redhat.co=
m> wrote:
>
> Add a per-CPU sysfs attribute at:
>   /sys/devices/system/cpu/cpuN/cpuidle/latency_limit_ns
>
> This allows privileged userspace to set a governor-respected upper
> bound on the exit latency for idle state selection on a given CPU.

Which is already present in the form of

/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us

See Documentation/admin-guide/pm/cpuidle.rst for more information.

> When set (non-zero), cpuidle_governor_latency_req() returns the
> minimum of the existing PM QoS constraints and latency_limit_ns,
> so all governors (menu, TEO, haltpoll) automatically respect it
> without per-governor modifications.
>
> Use case: cloud operators running mixed workloads can cap idle
> depth on CPUs pinned to latency-sensitive VMs while allowing other
> CPUs to enter deep C-states for energy savings. The interface is
> latency-based (nanoseconds) rather than C-state-index-based, making
> it portable across Intel/AMD/ARM without uarch-specific tuning.
>
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  drivers/cpuidle/governor.c | 10 +++++++++-
>  drivers/cpuidle/sysfs.c    | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpuidle.h    |  1 +
>  3 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index 5d0e7f78c6c5..4c6f77ce2028 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -112,6 +112,8 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>         int device_req =3D dev_pm_qos_raw_resume_latency(device);
>         int global_req =3D cpu_latency_qos_limit();
>         int global_wake_req =3D cpu_wakeup_latency_qos_limit();
> +       struct cpuidle_device *dev;
> +       s64 result;
>
>         if (global_req > global_wake_req)
>                 global_req =3D global_wake_req;
> @@ -119,5 +121,11 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
>         if (device_req > global_req)
>                 device_req =3D global_req;
>
> -       return (s64)device_req * NSEC_PER_USEC;
> +       result =3D (s64)device_req * NSEC_PER_USEC;
> +
> +       dev =3D per_cpu(cpuidle_devices, cpu);
> +       if (dev && dev->latency_limit_ns && dev->latency_limit_ns < resul=
t)
> +               result =3D dev->latency_limit_ns;
> +
> +       return result;
>  }
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index b81d22479234..d060a4b7facc 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -207,8 +207,44 @@ static void cpuidle_sysfs_release(struct kobject *ko=
bj)
>         complete(&kdev->kobj_unregister);
>  }
>
> +static ssize_t show_latency_limit_ns(struct cpuidle_device *dev, char *b=
uf)
> +{
> +       return sysfs_emit(buf, "%llu\n", dev->latency_limit_ns);
> +}
> +
> +static ssize_t store_latency_limit_ns(struct cpuidle_device *dev,
> +                                      const char *buf, size_t count)
> +{
> +       u64 value;
> +       int err;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       err =3D kstrtou64(buf, 0, &value);
> +       if (err)
> +               return err;
> +
> +       dev->latency_limit_ns =3D value;
> +
> +       return count;
> +}
> +
> +static struct cpuidle_attr attr_latency_limit_ns =3D {
> +       .attr =3D { .name =3D "latency_limit_ns", .mode =3D 0644 },
> +       .show =3D show_latency_limit_ns,
> +       .store =3D store_latency_limit_ns,
> +};
> +
> +static struct attribute *cpuidle_device_default_attrs[] =3D {
> +       &attr_latency_limit_ns.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(cpuidle_device_default);
> +
>  static const struct kobj_type ktype_cpuidle =3D {
>         .sysfs_ops =3D &cpuidle_sysfs_ops,
> +       .default_groups =3D cpuidle_device_default_groups,
>         .release =3D cpuidle_sysfs_release,
>  };
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index a2485348def3..f70d6288e13d 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -101,6 +101,7 @@ struct cpuidle_device {
>         u64                     last_residency_ns;
>         u64                     poll_limit_ns;
>         u64                     forced_idle_latency_limit_ns;
> +       u64                     latency_limit_ns;
>         struct cpuidle_state_usage      states_usage[CPUIDLE_STATE_MAX];
>         struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
>         struct cpuidle_driver_kobj *kobj_driver;
> --
> 2.55.0
>
>
