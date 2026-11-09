Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215320;
	b=iKYgBAnd9So4njozrTl0zeboLgQMIMSAUqCL+LvbaBgpLev28WkrdadOGKAEGq0AHFId
	 X/wonTK1NNc9HuenkaFE/wJmkQgLViJX7cwd6DA4Xs5+kVvWqUgDrWAkxhOpKKXF0UqfS
	 NjCEoTFkcBwVwTxFO68lYLjh+NSAgr3+gjksajK/GnLEcFNaQEescSyDOQJ12K4AKhojz
	 CPW/v5CrdgKzSWRSJKIxnbKF3Ek+q6sL6UEEu8BdiF/1WrgnI9jxkNd9zNHF3RrDM7l7b
	 begWPSXvezQ/qH3D+S5ViHYXSc6J0m9F7Ap49PauYfd22JcfTWWaR6fNA53JsuA0Uuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215320;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=asv+L+6XrSQhvTA+x8KlHG7bpla/glF8wUGDppGecfM=;
	b=Qf0kjWiINDBb1YauY+ewdoUpgjoiQ9ePfLxkcR27zquRC50c+3qiMP1tVgvUa389o8o4
	 dn/obf3wOumNODlrMLOVMa4vElmdBcx3wV5hp+XYLEunI9ha7DbbiL6LQTlcbhfRViGul
	 WRwFcwf4gckNlWtWsj9SaSrrvH29o84u/mnE/LIgs94XUJchKcDeuzUGtmVH3TtBfKJlV
	 T/9Y5QXmcO4rzjvgCSUejOYQkZ1r8ryoUsaVkITn6luaT3UzNPtTqmL5aOMS3z38KsZ3Q
	 cyNk6bxT+FKxK8h4dKOcqXoiV0eurbS0Sykf6MU9QcoC+VyCpVImd3n5u5ZfHEGxzrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ozg8aZ+6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF7606A321;
	Mon,  9 Nov 2026 09:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CAF7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ozg8aZ+6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891F114BF;
	Mon,  9 Nov 2026 01:08:35 -0800 (PST)
Received: from [10.57.12.22] (unknown [10.57.12.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB8E3F85F;
	Mon,  9 Nov 2026 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794215318; bh=b/Z8FOQeGGjUmR5j+LUi8n9Jv3kX2zKWVa4aDbKzjXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ozg8aZ+6ju7WL3UUHR16QwAhksplV/ASDDZW3dQr9NmR9+OrjSnwnB/YOwK6Sn6eT
	 +kIEQtT4khd5vClwnlxABv+rMZ8rWsoTdj93yBRbD6f4dn+ZaVIkqT/uh+26cpQaZ/
	 O1NXsHR5Qj7I7BU7NBsc33Kqv2YFefS6QtncQW+8=
Message-ID: <bcb0bfcb-e359-4710-aa6f-8de032327d03@arm.com>
Date: Mon, 9 Nov 2026 09:09:09 +0000
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
Subject: Re: [PATCH v5 4/6] powercap: dtpm: Use generic powercap hierarchy
 helpers
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, rafael@kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kselftest@vger.kernel.org
References: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <bded992091c92baa7246b939f266297f99c8942b.1793666444.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <bded992091c92baa7246b939f266297f99c8942b.1793666444.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 04:48, Daniel Lezcano wrote:
> DTPM implements its own hierarchy creation and destruction logic while
> the powercap core now provides generic helpers for this purpose.
> 
> Convert DTPM to use the generic powercap hierarchy infrastructure.
> Duplicate the platform hierarchy before creating it, and use
> powercap_hierarchy_create() and powercap_hierarchy_destroy() to manage
> the DTPM zones.
> 
> Add DTPM callbacks to create and destroy the zones associated with each
> powercap hierarchy node. Adapt the CPU and devfreq backends to return
> the created DTPM instance and use the node name provided by the
> hierarchy.
> 
> Convert the Rockchip RK3399 description to struct powercap_hierarchy
> and keep the device tree path as DTPM-specific node data.
> 
> This removes the DTPM-specific hierarchy traversal and destruction code
> and leaves the hierarchy management to the powercap core.
> 
> Preserve best-effort creation: an unavailable backend returns NULL to
> skip its branch, and setup failures are warned about and skipped rather
> than rolling back independent zones. Invalid node descriptors remain
> fatal. Reject a DT node with a NULL path before calling
> of_find_node_by_path(), treating it as an invalid descriptor rather
> than an unavailable backend.
> 
> When the representative CPU is offline, find an active policy through an
> online sibling whose related_cpus mask contains it. Hold the CPU hotplug
> read lock during selection and setup, and initialize the zone through the
> policy's active CPU while keeping the hierarchy-provided name. An entirely
> offline policy still has no active CPU to initialize through.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
> Changes in v5 (since v4):
> - Reject a NULL DT node path with -EINVAL before invoking
>    dtpm_setup_dt(), as suggested by Lukasz Luba.
> - Document that a missing path is an invalid hierarchy descriptor.
> 
> Changes in v4 (since v3):
> - Rebase on v7.3; no code or commit-description changes.
> 
> Changes in v3 (since v2):
> - Rebase on v7.3-rc7.
> - Preserve best-effort branch creation using the generic NULL result.
> - Find an online policy sibling for offline CPU representatives and
>    protect policy selection and setup against CPU hotplug.
> - Keep generic API behavior and documentation in patch 1.
> - Fix __initdata placement; match-table indentation is handled in patch 3.
> - Name setup callback arguments and remove whitespace-only lines.
> - Update the description.
> 
>   drivers/powercap/dtpm.c         | 180 +++++++++++++++-----------------
>   drivers/powercap/dtpm_cpu.c     |  62 ++++++++---
>   drivers/powercap/dtpm_devfreq.c |  22 ++--
>   drivers/soc/rockchip/dtpm.c     |  67 +++++++++---
>   include/linux/dtpm.h            |   6 +-
>   5 files changed, 198 insertions(+), 139 deletions(-)
> 

Thank you Daniel for addressing that, LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
