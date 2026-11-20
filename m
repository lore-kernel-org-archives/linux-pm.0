Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189955;
	b=EwJQrVMSI2Gl1QaFcIkYVuAJjr8p7eD0QuGEqr5aRhJp7B+COs6SxAJgZ8yq5hNiQtZf
	 3dEB5dqLe2vYCPjgffhbPM4uZ03kAUiNGLNGN7VFyJxxmQ7nLvyxU4qpVmJo4B70RWNRq
	 cb7CVj7hhdTPXFZ+6xVBptBe2lmpb2EFlZuqpubNsH97pvByYgpwbjJ4aZRSHcdeGOcln
	 Nf6cY+eO7ULHZa4VBLq4d4jyxNt/5UXli4gdTfdYec6zZ8B6UymES0IWIlvu4PCb+WTGm
	 82VNz2Fb7vfOQ0V3FbcKI6L+JYemnVgY3bmvBq59d6Dk01lVb4QSDc5tYdrK/0D/6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189955;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KgPfdp4Oa/xHgT7JwhfkFJEF8T47u5YkoKBmHOtSXV4=;
	b=hf1WDCLqThwr8OYKSbyDqHzTFrZ51oR+Qy0ELjOZ6ui0TJeO5oAC5kggvXUhJxVYer8/
	 gkw4Wx15SR+hBZs8JjBjVQ1Oz+f/FGs8hiDfc+uJoAMaWfCD+00PIMr3kPdQSdIsnn84z
	 CwHg2qHU3PMJMysL+W/bz1+fsy8PaP368yuGnm49YOjCAOcN4pXUTB9yWgYEZC4BbpUw/
	 JppbUssBIr2plLp+07vGe5cDQ/zRXoCV3SSaAUexpeiZayj7j/jvhLV2ajpjQ++ZSMk35
	 sPl57JIxANgTKk8tWlMn/CTcLMWh9dGW4/xTHRzbdp6iyIZcfqh1Nniyyfq/8MtcFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvqFCeXh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AA60A2604
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvqFCeXh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C8C1F0089F
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189955;
	bh=KgPfdp4Oa/xHgT7JwhfkFJEF8T47u5YkoKBmHOtSXV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IvqFCeXhPfb9+WbF3/DTwu1qtRoDuw0tDvH/JL+8kQTmboyZwsad4bLR+FlbFpKYx
	 s/M1f1E5SHf6h9fOV7tFiUrwq1D8XtsrCIbPr8i+KkQwJfI0zZH7HXALyNwVp+bdfK
	 9gWOB6EVpr7LKSIkzcWDt9JGHtpgiWMesMqlm983xU8+LJdbIQwv0DsyR5ZAcbz1t+
	 d2PB+A2dnJaIvafli6VOIfgW8WSMvETufzjz2rz7yVw8FjIjWJqsx/Gza/zWeTDAbC
	 tD/9jJtqBXCtzpuQASeMKpx3L+KxPz6ZdN612jiRCk2OZBzejUSwpXrUHtaM+AVkqW
	 W47xYkA2hajSg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso826487e87.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:52:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHxZGffNQv/+oBinnWakqP7G3Gr2YaoxJ+w3np5+EFpGsDFVNqceEiT/f8FuYA7m9rsezqeKJ1XEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jmWktl3DGbjIFAqJz8mu4rHTYogWHirA+82ANXDukg5uS73qf
	aYtfUiX6iX5gxtku9EZhFcqSy833PPnbgL+b5Le45kU5GJ3nlapybGZGpal/cIUMnYZl+6OZwcE
	zlrhAmZdXJJ4WqyBVVMPJ9cmUgoplKhM=
X-Received: by 2002:a05:6512:3f0c:b0:5bf:b22d:bf30 with SMTP id
 2adb3069b0e04-5c1bc8466b1mr1192456e87.11.1795189953427; Fri, 20 Nov 2026
 07:52:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
 <20261028-hfi-kexec-v1-1-956234dcfb2b@sfcompute.com> <20261119054230.GB7495@ranerica-svr.sc.intel.com>
In-Reply-To: <20261119054230.GB7495@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 16:52:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h+vgSGQ62vYMWJTxqj17X8NTL9g3EUoQ4ZVXU8cGGQmw@mail.gmail.com>
X-Gm-Features: Aa3M54o7hlulJ8PmUe8L48n0QBNLW-6TPHG8fhCmO0JlJZL8HXLvnbfxNw06tjA
Message-ID: <CAJZ5v0h+vgSGQ62vYMWJTxqj17X8NTL9g3EUoQ4ZVXU8cGGQmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: intel: hfi: Disable HFI on shutdown and kexec
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, jez@sfcompute.com
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Andrew James <ajames@sfcompute.com>, 
	John Ranzie <jranzie@sfcompute.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 6:34=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Oct 28, 2026 at 12:14:45AM +0000, Jez Ng via B4 Relay wrote:
> > From: Jez Ng <jez@sfcompute.com>
>
> [ ... ]
>
> > +static void hfi_syscore_shutdown(void *data)
> > +{
> > +     struct hfi_instance *hfi_instance;
> > +     int i;
> > +
> > +     /*
> > +      * Hardware keeps writing to the HFI table after a kexec, into me=
mory
> > +      * that the next kernel owns. Disable HFI in every package, and k=
eep it
> > +      * disabled: user space runs until machine_shutdown() stops the o=
ther
> > +      * CPUs, and kexec enables CPU hotplug again, so a new thermal ne=
tlink
> > +      * client or a CPU coming online could otherwise enable it.
> > +      */
> > +     mutex_lock(&hfi_instance_lock);
> > +     hfi_shutdown_done =3D true;
> > +     for (i =3D 0; i < max_hfi_instances; i++) {
> > +             hfi_instance =3D &hfi_instances[i];
> > +             if (cpumask_empty(hfi_instance->cpus))
> > +                     continue;
> > +
> > +             smp_call_function_single(cpumask_any(hfi_instance->cpus),
> > +                                      hfi_shutdown_instance, hfi_insta=
nce, true);
> > +     }
> > +     mutex_unlock(&hfi_instance_lock);
>
> Using guard(mutex)(&hfi_instance_lock) would read more simply here.
> However, this patch is tagged for stable, and kernels older than v6.5,
> such as 6.1, do not have guard(). It is probably better to leave it as
> is.
>
> I tested this patch once on a Panther Lake-H client system (one
> package, 16 CPUs), together with patch 2. With a thermal netlink client
> subscribed, a kexec left HW_FEEDBACK_CONFIG at 0 in the new kernel.
>
> Reviewed-by: Ricardo Neri ricardo.neri-calderon@linux.intel.com
> Tested-by: Ricardo Neri ricardo.neri-calderon@linux.intel.com

Applied as 7.5 material, thanks!
