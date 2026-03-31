Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1753DE45B;
	Tue, 31 Mar 2026 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958982; cv=none; b=QO+T7zNIvAFNWgrkpkFVZM/kSCzT7OQN+7hsXdkwX6UTKnEWF4FgDg+9EHGbqzXc0RexoHa09gBtbrfBV52jlEJW0iXU2gmE1D8L4WhlaI8Cf5Ygd6OAo9VUrm5piY5n7jynmh01qtxeMiEpCklP4s1UHq6FDzRBd22rs20wSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958982; c=relaxed/simple;
	bh=/1gjLdAXndG9xIJqHrjGfEe2m1okbPgEwCLI5HGrZjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nesZEg0RTQSsOUuLduozB/UVKJWpAhQIvKdMK6pFRD4HfuJocWqewHMKGFLHsnIxU6BVuV2CWSdfc+I9Jid/7G2kj1+WGRrj92L6ysie/S6dVoprYpUUdGVN1g6V308w4/Gztn80ikn2o4+WAQOx40ZXUIEMhv4U5oRThUYFJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKazu/rc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKazu/rc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D41C2BCB3;
	Tue, 31 Mar 2026 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774958981;
	bh=/1gjLdAXndG9xIJqHrjGfEe2m1okbPgEwCLI5HGrZjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKazu/rcEUvvM7mrhf80kwXxzNk0BW2CyP6NRm6eRA3PfbuNhdo2W81ugVIIuFPU4
	 vLjYJbLt1B6gp7vmFxtXfu+JwIH28ToNqiMfGhnOKo1Io7yiprfEHFC9bh1NJlWW84
	 A5KLdoBsBawVZ4QT5T8GPSOwhgrIO9oKQSppbTjrnhMdyPlwniYrrmO2S4kDrGwako
	 bWQojzjtpPGw+Wds8qJ6Azr0iCbSF0GMypU/0ru6kvqQPmmPOILV9MQjbCXqYUJ/ci
	 8ouKTeRLi+Cv2U4alfR4qV694Shv8z4vxOKg2BO85WXA8Qiy6cBqrbkwXiGD7dE6e3
	 fMlVmG7FsG0AQ==
Message-ID: <0f6496f0-14ee-4b8e-a888-3c4db1ee7e48@kernel.org>
Date: Tue, 31 Mar 2026 07:09:40 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] amd-pstate Dynamic EPP and raw EPP
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260106051441.60093-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260106051441.60093-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/5/26 11:14 PM, Mario Limonciello (AMD) wrote:
> Dynamic EPP allows the kernel to register amd-pstate as part of
> a platform profile. It will change EPP modes matching the user's
> preference to the platform profile sysfs files as well as power
> adapter state.
> 
> Raw EPP allows userspace to write integers to
> energy_performance_preference.
> 
> v4: https://lore.kernel.org/linux-pm/20250321022858.1538173-1-superm1@kernel.org/
> Mario Limonciello (5):
>    cpufreq/amd-pstate: Add dynamic energy performance preference
>    cpufreq/amd-pstate: add kernel command line to override dynamic epp
>    cpufreq/amd-pstate: Add support for platform profile class
>    cpufreq/amd-pstate: Add support for raw EPP writes
>    cpufreq/amd-pstate-ut: Add a unit test for raw EPP
> 
>   .../admin-guide/kernel-parameters.txt         |   7 +
>   Documentation/admin-guide/pm/amd-pstate.rst   |  41 ++-
>   drivers/cpufreq/Kconfig.x86                   |  13 +
>   drivers/cpufreq/amd-pstate-ut.c               |  58 ++++
>   drivers/cpufreq/amd-pstate.c                  | 283 ++++++++++++++++--
>   drivers/cpufreq/amd-pstate.h                  |  16 +-
>   6 files changed, 394 insertions(+), 24 deletions(-)
> 

I've applied this series.
