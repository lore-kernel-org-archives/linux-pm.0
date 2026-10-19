Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436551;
	b=Fw9+eOJ7gUMNifr4be44N2W2RBzj9xUB1ApTZ5hIVL9kmMPwz/XsMDfKcvYZOyJ0fesG
	 m5ZyzA+ItcYW+72QC2hScwnXxDRKMYhI7Ks+8XVMbxa8IMGHisF472yRj9dsrQ0c7Bn37
	 SsMOrJe793GWStL80afGzx+JyAoOq9ho4qyRYHGm9/8nBH7KUqJyWaF3nfQOiBaUGl+j+
	 nngrJulQwEHBK4ST8Sb6gQpU3Rd3hhJflG3VECQVYJN0TZY/Y0ORhX6PcUtLurpbCHwsm
	 tnU0Y3W9fOtESPvowVP382FzGDHcgIOQ3w1W1ZE6pIPdwbA4caiEc6WZwtwRukX4tvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436551;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+idouJd8yKJTP+et7afpjbqgYs2V8q4MRoUN7rJZ0V0=;
	b=MEdHaYYlEhxcwzBlOdAbVHHRKi0p5qY7KV+RwAFT8ns1R7HN5SJWKanB74ACgEkO7GO+
	 jKiO8t+xStQzq3KYritbjpPsEXcTnBrDK9S4F/DeAmJLohcsrW0U4e2p5ppEk6FKRgCpT
	 j4lUQJaqBG2f1FP7dVwT4lPtaIIXPCUn4GNKWkTFawJ97QbflVnJ4BAEeI4dsS23NBvbd
	 WzGJDM8hBirVp8JbsSAphThxu3hrjqmVS/7LnWtneVRDwX/9e+F/vWB7ONiPYfEfcjdQW
	 CPSuh12rEgCXdj79AaNozdLBHl9aD8FWIV5TwcOccOP4/hpqyZX/fTmwxW1ZUsqGS5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjIhKZ+Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE6606A33D;
	Mon, 19 Oct 2026 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjIhKZ+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EBC1F000C4;
	Mon, 19 Oct 2026 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792436549;
	bh=+idouJd8yKJTP+et7afpjbqgYs2V8q4MRoUN7rJZ0V0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QjIhKZ+QHHIiP9nhnbAbuQBwS6cxuuZZHmGGS46rFvOwhUSwVKvh/rk3t6skOTlna
	 nVruQcbmeTGUCUW+IvzcpeYhemOhBPYgjdp4IQW6XeQCuxT7DXlisEpTFMDx3LTeKp
	 b8RcBUutHkYdZ74tXJ40RK36+1lFNxtqHEd9ZdiRox3Iyc7PIDa/2zl+ywqYVZfKCq
	 bRi+ZiaGAxnOmvKSeRuB9/sWpMsas8Suvd63OWc4zq+LZI1Ey8DLFCbqBRVlN14naM
	 P/WpnUSABn/C0mF7AR61LMw8s5BG8JwaT0/4AUZUoTtNF/T1FSM9nV83v3lva8iVLc
	 boGl/R9H6YLMg==
Message-ID: <f70456fc-9ca0-4086-80a2-0d704526f2b2@kernel.org>
Date: Mon, 19 Oct 2026 14:02:25 -0500
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] platform profile: Make legacy ACPI aggregate
 interface optional
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,
 Jai Luthra <jai.luthra@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jack Wu <jackbb_wu@compal.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Zhang DM <jixianqiang1540@gmail.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
 <20261019073930.2352283-6-daniel.lezcano@oss.qualcomm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261019073930.2352283-6-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 02:39, Daniel Lezcano wrote:
> The aggregate attributes under /sys/firmware/acpi/ are retained
> for backwards compatibility. Firmware-independent userspace can already
> discover providers through /sys/class/platform-profile/ and control each
> provider using its choices and profile attributes.
> 
> Add PLATFORM_PROFILE_LEGACY, a boolean depending on PLATFORM_PROFILE and
> ACPI, to control the legacy aggregate sysfs interface. Default it to y so
> existing userspace continues to work when updating its configuration.
> 
> Compile the ACPI adapter and legacy sysfs callbacks only when the option
> is enabled. Keep common aggregation helpers in the core because kernel
> hotkey users still need platform_profile_cycle(). Class devices and their
> notifications remain available regardless of the legacy option.
> 
> Document the compatibility option and recommend individual class devices
> for new userspace. No daemon changes are included in this kernel series.
> Move the legacy ABI documentation to obsolete/, retain its original
> creation dates and attribute descriptions, identify the replacement class
> attributes, and update its MAINTAINERS entry.
> 
> Mark the legacy ABI deprecated and document removal after the 2028 LTS
> kernel, conditional on userspace migration. Keep the enabled default
> until class-device support has been released and deployed in userspace.
> Emit one shared pr_notice_once() when either legacy attribute is read or
> the profile is written, identifying actual legacy use rather than warning
> merely because the compatibility code was loaded.
> 
> Validate ARM64 without ACPI and x86 module builds with the option enabled
> and disabled. With ACPI active and the option disabled, QEMU tests confirm
> that the legacy attributes are absent while class controls, notifications,
> kernel cycling and concurrent registration/removal continue to work.
> 
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   .../{testing => obsolete}/sysfs-platform_profile   | 12 ++++
>   .../userspace-api/sysfs-platform_profile.rst       | 17 +++--
>   MAINTAINERS                                        |  2 +-
>   drivers/platform/Kconfig                           | 23 ++++++-
>   drivers/platform/profile/Makefile                  |  2 +-
>   drivers/platform/profile/core.c                    | 72 ++++++++++++++++++----
>   drivers/platform/profile/profile.h                 |  2 +-
>   7 files changed, 109 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/obsolete/sysfs-platform_profile
> similarity index 70%
> rename from Documentation/ABI/testing/sysfs-platform_profile
> rename to Documentation/ABI/obsolete/sysfs-platform_profile
> index 125324ab53a9..c001c8641a3a 100644
> --- a/Documentation/ABI/testing/sysfs-platform_profile
> +++ b/Documentation/ABI/obsolete/sysfs-platform_profile
> @@ -2,6 +2,12 @@ What:		/sys/firmware/acpi/platform_profile_choices
>   Date:		October 2020
>   Contact:	Hans de Goede <hdegoede@redhat.com>
>   Description:	This file contains a space-separated list of profiles supported for this device.
> +		Available with CONFIG_PLATFORM_PROFILE_LEGACY on active ACPI
> +		systems for backwards compatibility. New userspace should use
I don't think "new" vs old is a good distinction for documentation.

Just say "Userspace should use"

> +		/sys/class/platform-profile/platform-profile-X/choices instead.
> +		This interface is deprecated, with removal intended after the
> +		2028 LTS kernel once userspace migration is complete. Accessing
> +		either legacy attribute emits a one-time deprecation notice.
>   
>   		Drivers must use the following standard profile-names:
>   
> @@ -27,6 +33,12 @@ Description:	Reading this file gives the current selected profile for this
>   		device. Writing this file with one of the strings from
>   		platform_profile_choices changes the profile to the new value.
>   
> +		This legacy interface requires CONFIG_PLATFORM_PROFILE_LEGACY.
> +		Individual class devices remain available without that option.
> +		Use /sys/class/platform-profile/platform-profile-X/profile
> +		instead. This interface is deprecated, with removal intended
> +		after the 2028 LTS kernel once userspace migration is complete.
> +
>   		This file can be monitored for changes by polling for POLLPRI,
>   		POLLPRI will be signalled on any changes, independent of those
>   		changes coming from a userspace write; or coming from another
> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
> index a85ede3fb8e5..a3fc1ee20832 100644
> --- a/Documentation/userspace-api/sysfs-platform_profile.rst
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -26,11 +26,20 @@ The firmware-independent userspace interface is available under
>   ``/sys/class/platform-profile/platform-profile-X/``, with ``name``,
>   ``choices`` and ``profile`` attributes for each registered provider.
>   
> -On ACPI systems, ``/sys/firmware/acpi/platform_profile_choices`` and
> +On ACPI systems with ``CONFIG_PLATFORM_PROFILE_LEGACY`` enabled,
> +``/sys/firmware/acpi/platform_profile_choices`` and
>   ``/sys/firmware/acpi/platform_profile`` remain available as compatibility
>   interfaces for aggregate profile selection across registered providers.
> -On non-ACPI systems, userspace selects profiles through the individual
> -provider class devices.
> +New userspace should select profiles through the individual provider class
Similar comment.> +devices. These remain available when the legacy 
interface is disabled and
> +on non-ACPI systems. Kernel profile cycling also remains available without
> +the legacy interface.
> +
> +The legacy aggregate interface is deprecated. Removal is intended after the
> +2028 LTS kernel, once userspace has migrated to released software using the
> +class devices. Compatibility remains enabled by default during the migration;
> +the date alone does not trigger removal. Accessing either legacy attribute
> +emits a one-time kernel notice directing userspace to the class interface.
>   
>   Note that this API is only for selecting the platform profile, it is
>   NOT a goal of this API to allow monitoring the resulting performance
> @@ -70,7 +79,7 @@ Multiple driver support
>   When multiple drivers on a system advertise a platform profile handler, the
>   platform profile handler core will only advertise the profiles that are
>   common between all drivers to the ``/sys/firmware/acpi`` interfaces, when
> -ACPI is active.
> +ACPI is active and ``CONFIG_PLATFORM_PROFILE_LEGACY`` is enabled.
>   
>   This is to ensure there is no ambiguity on what the profile names mean when
>   all handlers don't support a profile.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 929e1e095f17..47b7724f20ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -283,10 +283,10 @@ S:	Supported
>   Q:	https://patchwork.kernel.org/project/linux-acpi/list/
>   B:	https://bugzilla.kernel.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +F:	Documentation/ABI/obsolete/sysfs-platform_profile
>   F:	Documentation/ABI/testing/configfs-acpi
>   F:	Documentation/ABI/testing/sysfs-bus-acpi
>   F:	Documentation/ABI/testing/sysfs-class-platform-profile
> -F:	Documentation/ABI/testing/sysfs-platform_profile
>   F:	Documentation/firmware-guide/acpi/
>   F:	Documentation/userspace-api/sysfs-platform_profile.rst
>   F:	arch/x86/kernel/acpi/
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index 395b75f2edf0..7270f24a3b6e 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -9,12 +9,31 @@ config PLATFORM_PROFILE
>   
>   	  The core exposes per-provider controls under /sys/class/platform-profile/.
>   	  A provider driver must register before profile attributes become
> -	  available. ACPI is not required; on ACPI systems the legacy system-wide
> -	  interface under /sys/firmware/acpi/ is also provided.
> +	  available. ACPI is not required. The legacy system-wide interface under
> +	  /sys/firmware/acpi/ can be enabled separately for existing userspace.
>   
>   	  To compile this as a module, choose M here: the module will be called
>   	  platform_profile.
>   
> +config PLATFORM_PROFILE_LEGACY
> +	bool "Legacy ACPI platform profile sysfs interface (DEPRECATED)"
> +	depends on PLATFORM_PROFILE && ACPI
> +	default y
> +	help
> +	  Expose platform_profile and platform_profile_choices under
> +	  /sys/firmware/acpi/ for compatibility with existing userspace. These
> +	  attributes aggregate the profiles of all registered providers.
> +
> +	  This interface is deprecated and is intended for removal after the
> +	  2028 LTS kernel, once userspace has migrated to the class interface.
> +	  It remains enabled by default until replacement userspace releases
> +	  are available and have had time to reach users.
> +
> +	  New userspace should use the individual devices under
> +	  /sys/class/platform-profile/ instead. Disabling this option removes
> +	  the legacy sysfs interface but retains class devices and kernel
> +	  profile cycling. If unsure, say Y to preserve compatibility.
> +
>   source "drivers/platform/mips/Kconfig"
>   
>   source "drivers/platform/loongarch/Kconfig"
> diff --git a/drivers/platform/profile/Makefile b/drivers/platform/profile/Makefile
> index ae95ba09383c..787fc9bc961a 100644
> --- a/drivers/platform/profile/Makefile
> +++ b/drivers/platform/profile/Makefile
> @@ -2,4 +2,4 @@
>   obj-$(CONFIG_PLATFORM_PROFILE) += platform_profile.o
>   
>   platform_profile-y := core.o
> -platform_profile-$(CONFIG_ACPI) += acpi.o
> +platform_profile-$(CONFIG_PLATFORM_PROFILE_LEGACY) += acpi.o
> diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/core.c
> index 320a5a964fea..1bffca947157 100644
> --- a/drivers/platform/profile/core.c
> +++ b/drivers/platform/profile/core.c
> @@ -25,12 +25,16 @@ static DEFINE_MUTEX(profile_lock);
>   /* Serialize registration and sysfs updates without blocking sysfs callbacks. */
>   static DEFINE_MUTEX(profile_registration_lock);
>   static LIST_HEAD(profile_handlers);
> +#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
>   static struct kobject *compat_kobj;
> +#endif
>   
>   static void profile_notify(void)
>   {
> +#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
>   	if (compat_kobj)
>   		sysfs_notify(compat_kobj, NULL, "platform_profile");
> +#endif
>   }
>   
>   static int profile_update(void);
> @@ -304,6 +308,12 @@ static int _aggregate_choices(struct device *dev, void *arg)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
> +static void profile_legacy_notice(void)
> +{
> +	pr_notice_once("The ACPI platform_profile sysfs interface is deprecated and planned for removal after the 2028 LTS kernel once userspace has migrated; use /sys/class/platform-profile/ instead\n");

I would just leave userspace out.  Maybe just:

"The ACPI platform_profile sysfs interface is deprecated with a planned 
removal in 2028".

> +}
> +
>   /**
>    * _remove_hidden_choices - Remove hidden choices from aggregate data
>    * @dev: The device
> @@ -342,6 +352,8 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
>   	};
>   	int err;
>   
> +	profile_legacy_notice();
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err = profile_walk_handlers(&data, _aggregate_choices);
>   		if (err)
> @@ -359,6 +371,7 @@ static ssize_t platform_profile_choices_show(struct kobject *kobj,
>   
>   	return _commmon_choices_show(data.aggregate, buf);
>   }
> +#endif
>   
>   /**
>    * _aggregate_profiles - Aggregate the profiles across providers
> @@ -403,6 +416,7 @@ static int _store_and_notify(struct device *dev, void *data)
>   	return _notify_class_profile(dev, NULL);
>   }
>   
> +#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
>   /**
>    * platform_profile_show - Show the current aggregate profile
>    * @kobj: The kobject
> @@ -418,6 +432,8 @@ static ssize_t platform_profile_show(struct kobject *kobj,
>   	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>   	int err;
>   
> +	profile_legacy_notice();
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err = profile_walk_handlers(&profile, _aggregate_profiles);
>   		if (err)
> @@ -451,6 +467,8 @@ static ssize_t platform_profile_store(struct kobject *kobj,
>   	int ret;
>   	int i;
>   
> +	profile_legacy_notice();
> +
>   	/* Scan for a matching profile */
>   	i = sysfs_match_string(profile_names, buf);
>   	if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
> @@ -502,6 +520,44 @@ static int profile_update(void)
>   	return 0;
>   }
>   
> +static int profile_compat_init(void)
> +{
> +	int err;
> +
> +	compat_kobj = platform_profile_compat_kobj();
> +	if (!compat_kobj)
> +		return 0;
> +
> +	err = sysfs_create_group(compat_kobj, &platform_profile_group);
> +	if (err)
> +		kobject_put(compat_kobj);
> +
> +	return err;
> +}
> +
> +static void profile_compat_exit(void)
> +{
> +	if (compat_kobj) {
> +		sysfs_remove_group(compat_kobj, &platform_profile_group);
> +		kobject_put(compat_kobj);
> +	}
> +}
> +#else
> +static int profile_update(void)
> +{
> +	return 0;
> +}
> +
> +static int profile_compat_init(void)
> +{
> +	return 0;
> +}
> +
> +static void profile_compat_exit(void)
> +{
> +}
> +#endif
> +
>   /**
>    * platform_profile_notify - Notify the provider and aggregate sysfs interfaces
>    * @dev: The class device
> @@ -728,24 +784,16 @@ static int __init platform_profile_init(void)
>   	if (err)
>   		return err;
>   
> -	compat_kobj = platform_profile_compat_kobj();
> -	if (compat_kobj) {
> -		err = sysfs_create_group(compat_kobj, &platform_profile_group);
> -		if (err) {
> -			kobject_put(compat_kobj);
> -			class_unregister(&platform_profile_class);
> -		}
> -	}
> +	err = profile_compat_init();
> +	if (err)
> +		class_unregister(&platform_profile_class);
>   
>   	return err;
>   }
>   
>   static void __exit platform_profile_exit(void)
>   {
> -	if (compat_kobj) {
> -		sysfs_remove_group(compat_kobj, &platform_profile_group);
> -		kobject_put(compat_kobj);
> -	}
> +	profile_compat_exit();
>   	class_unregister(&platform_profile_class);
>   }
>   subsys_initcall_sync(platform_profile_init);
> diff --git a/drivers/platform/profile/profile.h b/drivers/platform/profile/profile.h
> index 910c9f7da6a0..362eb8cc4592 100644
> --- a/drivers/platform/profile/profile.h
> +++ b/drivers/platform/profile/profile.h
> @@ -5,7 +5,7 @@
>   #include <linux/kconfig.h>
>   #include <linux/kobject.h>
>   
> -#ifdef CONFIG_ACPI
> +#ifdef CONFIG_PLATFORM_PROFILE_LEGACY
>   struct kobject *platform_profile_compat_kobj(void);
>   #else
>   static inline struct kobject *platform_profile_compat_kobj(void)

