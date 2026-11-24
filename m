Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539636;
	b=KL/TJ5W8UyK4x5e/y786VoxaniRMGt73I7pncvTC3tTDPzvQF5G3v4aaSfVUqlh5JWy7
	 N/esLKGiwP7uMLfjON3JFMOdO4uMyn/80QOIN7WILqvzgL+ZBi1XhcGygbdsjhr5LN1mj
	 JUmnwxqtD0DTTDh5SXCDxo+ouzc8TZb9P0JJ8hnXlmiYMoJ7YPKnp6rbnLKQRU5xoieav
	 zmNyK6ipuXb7nV8qIWKclPGI26qF/oBp3vmde5OSbQ5n/+PANVb80EGN0P3qHlQptr1In
	 LooMjaS2IVbyCEmfufzfhlVL+0gdvvtft9VDBvTF613JvnUx+X48Nd1b1XbpSRoR/6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539636;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0II4ljEDv0KUEOXTn1IfR+YqrPY597L6UYRDSKuHB+Y=;
	b=z5X223NYU2MrIV7OfG0GlFV0lSBQSmIWqakD8+ADIFItpZZZCrSzozqxgH4XWEIL/hqQ
	 ROokQmn/Rdcsbi251fvNt7cYSWYHego37afLEKaDSw3UD/Qz0TOliQlkws1sT+H44C+7a
	 F9duxmNKP0slMOKAFKryrrIxxmBgbPvyiZ8j0noWPjylW2GPslOGLHK66qFZYQBksLRfk
	 bmVigHGvxAjRROM7eARMdC1KR9Ngv4WyVT4zCYx8IEdpaD9XynhJpdn/3wwesQnzNurEy
	 +2kGNbAkeuV+pYC46V2RiBY+GpxNwpLY5S62DYUL8FhT8+4yCV5LhHab1ohM8hVm5lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Gri3ywFb;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E09606A32E
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 17:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E09606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Gri3ywFb
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ADFF339;
	Tue, 24 Nov 2026 09:00:31 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B60893F86C;
	Tue, 24 Nov 2026 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795539634; bh=z8lJkegZYqKQAhYH3KELOe4ZmkhKnWLIUsCGvv6e6b0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gri3ywFb6diRQ/1inXrBODLn5+HfbiqgZrEtYtH5OIFleXzz7NfhPbLJqA5kJXMG0
	 ivaGIl5DoCe3Phi1oADie/3IcidpAvWvZ8mK348FK1nqLEHJ/vZoF8CUgRuCxcDdC+
	 TY0AWUaBpMoNftMAh9ag9otVAmaFl/UJRP8WFJZk=
Message-ID: <090c12e4-2331-4d6f-be30-65303c5731d0@arm.com>
Date: Tue, 24 Nov 2026 17:00:30 +0000
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
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Driver Core Development <driver-core@lists.linux.dev>,
 Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 iommu@lists.linux.dev, Brian Norris <briannorris@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Ulf Hansson <ulf.hansson@oss.qualcomm.com>
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 4:36 pm, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.

Aha, indeed it was only this way to minimise conflicts with Sakari's 
original refactoring, since that led us to realise that we did actually 
want the mark_last_busy behaviour here anyway[1]. Evidently it missed 
anyone's to-do list to come back and clean it up post-merge - thanks for 
finally sorting it!

> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
> 
> No intentional functional impact.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

[1] https://lore.kernel.org/all/ZxpnFPsk2OBC8vqd@google.com/

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   Documentation/power/runtime_pm.rst    |    1 -
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |    7 ++-----
>   include/linux/pm_runtime.h            |   26 +-------------------------
>   3 files changed, 3 insertions(+), 31 deletions(-)
> 
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -338,7 +338,6 @@ It is safe to execute the following help
>   - pm_runtime_put_noidle()
>   - pm_runtime_put()
>   - pm_runtime_put_autosuspend()
> -- __pm_runtime_put_autosuspend()
>   - pm_runtime_enable()
>   - pm_suspend_ignore_children()
>   - pm_runtime_set_active()
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -79,11 +79,8 @@ static inline int arm_smmu_rpm_get(struc
>   
>   static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>   {
> -	if (pm_runtime_enabled(smmu->dev)) {
> -		pm_runtime_mark_last_busy(smmu->dev);
> -		__pm_runtime_put_autosuspend(smmu->dev);
> -
> -	}
> +	if (pm_runtime_enabled(smmu->dev))
> +		pm_runtime_put_autosuspend(smmu->dev);
>   }
>   
>   static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -588,30 +588,6 @@ static inline void pm_runtime_put(struct
>   }
>   
>   /**
> - * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
> - * @dev: Target device.
> - *
> - * Decrement the runtime PM usage counter of @dev and if it turns out to be
> - * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
> - *
> - * Return:
> - * * %1: Success. Usage counter dropped to zero, but device was already suspended.
> - * * %0: Success.
> - * * %-EINVAL: Runtime PM error.
> - * * %-EACCES: Runtime PM disabled.
> - * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
> - *   change ongoing.
> - * * %-EBUSY: Runtime PM child_count non-zero.
> - * * %-EPERM: Device PM QoS resume latency 0.
> - * * %-EINPROGRESS: Suspend already in progress.
> - * * %-ENOSYS: %CONFIG_PM not enabled.
> - */
> -static inline int __pm_runtime_put_autosuspend(struct device *dev)
> -{
> -	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
> -}
> -
> -/**
>    * pm_runtime_put_autosuspend - Update the last access time, drop usage counter
>    * and request autosuspend.
>    * @dev: Target device.
> @@ -635,7 +611,7 @@ static inline int __pm_runtime_put_autos
>   static inline int pm_runtime_put_autosuspend(struct device *dev)
>   {
>   	pm_runtime_mark_last_busy(dev);
> -	return __pm_runtime_put_autosuspend(dev);
> +	return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AUTO);
>   }
>   
>   DEFINE_GUARD(pm_runtime_noresume, struct device *,
> 
> 
> 

