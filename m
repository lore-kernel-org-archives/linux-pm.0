Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242831;
	b=ksjXvpsNBpX0L4ZYw+lrXvTGvZWZqdd+wApS3UacuTCwDsB+km0iVw9/KS4RDtHmzA+n
	 T1mwt9r+5Wj/XKE7o5sMsDj9slyOpz7FFWY0bQvqrYR/r4WOhoxpLsCFgbtgsKsEbFocT
	 y/NQzUNP96QldpwSyQ247HrfuSzdnbmcFA3cAJ1g9lgPZW4YYU45ySMFCK2uDLhfXwutK
	 RBS5jDQXf7lmHQY7pxw6mzmRqv0+1cMPdGptn3bco0HTGAuTS3azvjmnPub6ZvXycVERi
	 Vzr6uLU4S1KHUINgCMeFigI6IRAjLn89ouEj+ceCSJCvJgWSZVspxgwykmn6qYJTHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242831;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jQV5c6NkatZ0Eses+bAi+sUwiAR6q3hhUXHWX3VdAdw=;
	b=EDhFMYfpxC/aqFodcAoexth3rfe9ZakG4xtVaR/fqNFqw9oo9zDGyAbzcYSQ/frndGbC
	 nAkv3fq5MN1RaOKI37NRhkbNcOAwyTwJIjF1GL57vfPV76EvG2qKpnYx54aBytAUi9dKF
	 kDEpuqo/E2ScKYB/itrih4oP0JvVZWcSinZ+QVlQmS0AHN13AVQ8JwnXvgPivf16NoiUq
	 upzX+GCIczm5/LXyqCGxVRCjZttUC1d6s70W+J5j/B56Tp1R7sw/jBn3y3+4Y250mTici
	 Xp9BP48huRhjTWAqmCTcV3FSZMGm12lnu+5ABf3XDxTFJ3kxXsTwoqYWulPfCF95ubg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeQUAB+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996F606A32A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeQUAB+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E871F008A1
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242829;
	bh=jQV5c6NkatZ0Eses+bAi+sUwiAR6q3hhUXHWX3VdAdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EeQUAB+K3o2BE8CbM/vq5tKHXRrU4LpEjh/A6Yib0XkNa37hhWL0a40OO6Z9gghlU
	 3Q43aK76v9HNzOzOdx72/7s09xK15YM7wORJpbB/F3e1auWN+gFtw+l4MIdOW3Akmz
	 yqtB60eUQDwLBugC5y1pbdslO8C7R2fgAMA76imZtBOX0WU+f0vEafdvGh0Wg7Apcl
	 KmH3s7nMBtfmJy1+ipDOJzS1SL1dQ5cDiokbJsXSdAaLfPNorj/j2zASgF8dx7j8Lk
	 C1anCPZ04lJLBu8tJJJKuBZN+N1NSxvMavO0ruqozawapkAp0DFScTVWdziyDIjaTy
	 tMquGJkhmjCSQ==
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so605424241.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 08:47:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE8DoEJWosmMwULnF3pUwXwUIa6BcjuRoniW8k+SVLpcKZ9lU/g24T8PhcOmUmWsuXHBQB+1bJTHA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9gp7y1Ii0SCwrMC65faN2gdUbfyTv0D7GQMh4a7bghb2Lp+JRj
	zTnVS9sUFUfkcs8MlpHCofCHjvowB2fZHS0c/7CtYXJhX2uyve8gnvpvHklXKJOSk44QQr2SrwC
	zEx2XXDcYccRgUM2lRcuFC4kdgX6Krxs=
X-Received: by 2002:a05:6122:298a:b0:5ec:4653:2431 with SMTP id
 71dfb90a1353d-5ece73577efmr1865906e0c.15.1794242828771; Mon, 09 Nov 2026
 08:47:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com> <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com>
In-Reply-To: <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 17:46:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gGeKEqMWvP3cQrXztZt-faFZJF+yNfygcBPT57f-a8Lw@mail.gmail.com>
X-Gm-Features: AclHuK_21pB0sZBLQgS6pGtnjP6yV12ddWqNvd6v3npp0rwykw62-EY_ITW-xpY
Message-ID: <CAJZ5v0gGeKEqMWvP3cQrXztZt-faFZJF+yNfygcBPT57f-a8Lw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Make platform profiles firmware independent
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:37=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi,
>
> sashiko validated this series
>
> Is there any other comments for these changes I should take care of ?

I'd love to see some feedback from someone having a vested interest in
this interface.  Mario?  Mark?

> On 10/25/26 00:34, Daniel Lezcano wrote:
> > Make platform profile selection independent of ACPI firmware.
> >
> > The provider API already uses struct device, profile enums and callback=
s;
> > it does not require an ACPI handle or firmware node. However, the core =
is
> > built under drivers/acpi/, its Kconfig symbol depends implicitly on ACP=
I,
> > and initialization fails when ACPI is disabled, preventing non-ACPI
> > providers from using the existing firmware-independent class interface.
> >
> > This series moves the core to drivers/platform/profile/ and introduces
> > CONFIG_PLATFORM_PROFILE, updating all existing provider selectors. It
> > retains the tristate configuration and platform_profile module name.
> > Firmware-specific discovery and profile operations remain with provider=
s.
> > The core can also be selected directly through its Kconfig prompt.
> >
> > An optional ACPI adapter obtains the legacy sysfs kobject and is linked
> > into the same module. The generic core contains no ACPI types or symbol=
s
> > and initializes without ACPI support or with ACPI disabled at boot.
> > The existing /sys/firmware/acpi/platform_profile and
> > /sys/firmware/acpi/platform_profile_choices attributes remain available
> > on active ACPI systems.
> >
> > CONFIG_PLATFORM_PROFILE_LEGACY controls the backwards-compatible aggreg=
ate
> > sysfs interface. It defaults to enabled to preserve existing userspace.
> > Disabling it omits the legacy sysfs callbacks and ACPI adapter while
> > retaining class devices and kernel profile cycling. New userspace shoul=
d
> > discover and control individual class devices instead.
> > The interface is deprecated, with removal intended after the 2028 LTS
> > kernel once userspace migration is complete. A shared pr_notice_once()
> > warns on legacy attribute access rather than on merely loading the core=
.
> > The default remains enabled while userspace adopts released class-devic=
e
> > support; this series does not claim that ecosystem migration is complet=
e.
> >
> > The existing firmware-independent interface remains:
> >
> >    /sys/class/platform-profile/platform-profile-X/name
> >    /sys/class/platform-profile/platform-profile-X/choices
> >    /sys/class/platform-profile/platform-profile-X/profile
> >
> > Non-ACPI userspace controls providers individually through these class
> > devices. Aggregate selection remains available through the legacy ACPI
> > attributes, and aggregate profile cycling remains available to kernel
> > callers. No new sysfs directory or userspace ABI is introduced.
> >
> > The original first patch, "Separate handler locking from sysfs lifetime=
",
> > fixing the handler access race and sysfs teardown locking issue, has be=
en
> > sent separately as a standalone v3 fix. It is not included in this seri=
es.
> > The base tree used here already contains that fix.
> >
> > Patch 1 extracts the core and initializes it before built-in consumers.
> > Patch 2 completes class-device notifications and registration cleanup.
> > Patch 3 documents firmware-independent profile selection through class
> > devices. Patch 4 makes the legacy ACPI aggregate sysfs interface option=
al
> > and documents its deprecation.
> >
> > Validation performed during development (before this rebase):
> >
> >    - ARM64 built-in core with CONFIG_ACPI=3Dn: W=3D1 build and sparse.
> >    - x86 modular core with CONFIG_ACPI=3Dy: W=3D1 object build and spar=
se.
> >      Both CONFIG_PLATFORM_PROFILE_LEGACY=3Dy and =3Dn are covered.
> >    - Full x86 kernel link and QEMU boot with lockdep and list debugging=
,
> >      with active ACPI and with acpi=3Doff.
> >    - Firmware-less providers exercising common and hidden choices,
> >      profile reads/writes, invalid input, mixed profiles, cycling,
> >      partial callback failures and POLLPRI on the class and legacy ACPI
> >      interfaces. With acpi=3Doff, class get/set, notifications and kern=
el
> >      cycling are exercised. Both runs check that no new aggregate sysfs
> >      directory is created.
> >    - Concurrent sysfs I/O with two persistent providers while a third
> >      provider is registered and removed 200 times, last-provider attrib=
ute
> >      removal and repeated provider module reloads.
> >    - QEMU with active ACPI and CONFIG_PLATFORM_PROFILE_LEGACY=3Dn: veri=
fy
> >      the legacy attributes are absent, class get/set and notifications
> >      work, and kernel cycling and registration/removal stress pass.
> >
> > The provider API and profile names are unchanged. Aggregate writes reta=
in
> > their sequential, non-transactional behavior: a failing callback does n=
ot
> > roll back providers already updated.
> >
> > Changes in v3:
> >    - Send the original first patch fixing the handler access race and
> >      sysfs lifetime locking separately as a standalone v3 fix, includin=
g
> >      the requested profile_lock protection comment and Fixes tag.
> >    - Reduce this series to the four remaining patches and renumber them=
.
> >    - Rebase the remaining changes onto the current base, which already
> >      contains the separately submitted locking fix.
> >
> > Changes in v2:
> >    - Add the Fixes tag to patch 1 and explain how the mutex-guard conve=
rsion
> >      reintroduced the teardown deadlock previously fixed in 041142d7d25=
2,
> >      and how class-device support subsequently extended the affected pa=
ths.
> >    - Drop the proposed /sys/kernel/platform_profile/ aggregate interfac=
e
> >      and its ABI documentation. Use the existing firmware-independent
> >      /sys/class/platform-profile/platform-profile-X/ devices instead.
> >    - Preserve aggregate selection through the legacy ACPI attributes an=
d
> >      retain internal aggregation for kernel profile cycling.
> >    - Refocus patch 3 on class-device notifications for direct writes an=
d
> >      restoring aggregate visibility after failed registration.
> >    - Update the Kconfig help and documentation to describe the existing
> >      class interface and distinguish it from ACPI aggregate selection.
> >    - Revalidate class controls and notifications with acpi=3Doff, legac=
y
> >      aggregation with ACPI active, and the absence of a new aggregate A=
BI.
> >    - Add CONFIG_PLATFORM_PROFILE_LEGACY (default y) to make legacy aggr=
egate
> >      sysfs code optional, independently of class devices and kernel cyc=
ling.
> >    - Mark the legacy ABI deprecated and describe removal after the 2028=
 LTS
> >      kernel, conditional on userspace migration. Emit one shared notice=
 on
> >      legacy attribute access; retain the enabled default during migrati=
on.
> >    - Move the legacy ACPI ABI documentation from testing/ to obsolete/,
> >      document the replacement class attributes and update MAINTAINERS.
> >
> > Changes in v1:
> >    - Initial series extracting the core from ACPI, separating handler
> >      locking from sysfs lifetime operations and retaining the legacy AB=
I.
> >    - Proposed a firmware-neutral aggregate sysfs interface alongside th=
e
> >      existing per-provider class devices (removed in v2).
> >
> > Daniel Lezcano (4):
> >    platform profile: Extract the core from ACPI
> >    platform profile: Complete class notifications and registration
> >      cleanup
> >    platform profile: Document firmware-independent profile selection
> >    platform profile: Make legacy ACPI aggregate interface optional
> >
> >   .../sysfs-platform_profile                    |  12 ++
> >   .../ABI/testing/sysfs-class-platform-profile  |   2 +-
> >   .../userspace-api/sysfs-platform_profile.rst  |  55 ++++++--
> >   MAINTAINERS                                   |   5 +
> >   drivers/acpi/Kconfig                          |   3 -
> >   drivers/acpi/Makefile                         |   1 -
> >   drivers/cpufreq/Kconfig.x86                   |   2 +-
> >   drivers/platform/Kconfig                      |  35 +++++
> >   drivers/platform/Makefile                     |   2 +
> >   drivers/platform/profile/Makefile             |   5 +
> >   drivers/platform/profile/acpi.c               |  15 +++
> >   .../profile/core.c}                           | 122 ++++++++++++++---=
-
> >   drivers/platform/profile/profile.h            |  17 +++
> >   drivers/platform/surface/Kconfig              |   6 +-
> >   drivers/platform/x86/Kconfig                  |  10 +-
> >   drivers/platform/x86/amd/pmf/Kconfig          |   2 +-
> >   drivers/platform/x86/dell/Kconfig             |   4 +-
> >   drivers/platform/x86/hp/Kconfig               |   2 +-
> >   drivers/platform/x86/lenovo/Kconfig           |   6 +-
> >   drivers/thermal/intel/int340x_thermal/Kconfig |   2 +-
> >   include/linux/platform_profile.h              |   3 +
> >   21 files changed, 255 insertions(+), 56 deletions(-)
> >   rename Documentation/ABI/{testing =3D> obsolete}/sysfs-platform_profi=
le (70%)
> >   create mode 100644 drivers/platform/profile/Makefile
> >   create mode 100644 drivers/platform/profile/acpi.c
> >   rename drivers/{acpi/platform_profile.c =3D> platform/profile/core.c}=
 (88%)
> >   create mode 100644 drivers/platform/profile/profile.h
> >
> >
> > base-commit: 8244dc8f69f0e73cb1789355260b7d68bf5494e7
>
