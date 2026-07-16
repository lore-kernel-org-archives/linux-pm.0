Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE5364028;
	Thu, 16 Jul 2026 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245151; cv=none; b=F45gNPq5MiVu8vgVMmUSFdGPb5d3LV5C7jm/RylN1RCIe+xoBhI/+/adx9ZAZCQv66Tt7iXFyXwC52XhC44NXtNcxkjciN7oJPKE501fiVUoKbtV3RSaqGrczcpL85I5BZDqW8V6Bz831FlXDAogL5nEXs0lnPLq0hPXYd9XNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245151; c=relaxed/simple;
	bh=3DzSElZyhKto/tf7xI55Ysg67M4OHoFtBT5XBwQogbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMCdb84ndTbb+KmM1tKUtMQdaLG2LkQW4+tQyCD+VXc9xP1PZSYpvBZqrOWUGOUsboaXDReaBGk0qh6EhO+9PazADHYdTLBVrQ0HgozFJ3OQ7mR27IWiHh/S8dJkUzPxoDsI8TsFf7XPDzsqeXaUKSIC7OrGwmOWKx/4j8N9MN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhiasleo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhiasleo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07C91F000E9;
	Thu, 16 Jul 2026 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784245150;
	bh=/w2HxnhRaYWADBOrSvgtOWS5kDz1u6p6b7gw8sOwkXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Vhiasleo6WJDutUcrsJ96arg/XN7q4ucizg5ULGlALQoJHS+5Cy2SYp6FJGx7LRz+
	 JpigO5rECWpUcqeWEoe/jwuakXQC9XO4+6dxbBih/CnAKyjO1c0H3f8D/IHW5UEZHg
	 4fh96K6EeB+l8AU/sPGkabx/Xe6r3XUN7Dqq37mzcnAClZyIDwzYHZtadCqYKr8Ui9
	 StVPjoKYPHJgGSnfpVAkTn2GtSxoMBDUpC9VGE8ccKQT5HWPC0fih9+DA2F8IAqLly
	 FRSqTW5Vt6wQDzNpvT05KdPuD74LgyTqjqyTZkZ+gItMuIkF0VKYNabQp1MfFGQc7E
	 VZqSHbYu/L+ew==
Message-ID: <ede0c771-5a49-4c71-85c9-87bed8ac789f@kernel.org>
Date: Thu, 16 Jul 2026 17:39:07 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpupower: Improve arm64 frequency and CPPC reporting
To: Jeremy Linton <jeremy.linton@arm.com>, linux-pm@vger.kernel.org
Cc: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 kaushlendra.kumar@intel.com, sashal@kernel.org, fj5851bi@fujitsu.com,
 rui.zhang@intel.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260709221344.1919794-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 16:13, Jeremy Linton wrote:
> On x86, cpupower can report both kernel requested frequency
> information and hardware reported frequency information, along with
> CPPC related performance limits when available.
> 
> Arm64 platforms using ACPI CPPC, expose similar standardized
> information, but cpupower does not currently make it visible.
> 
> This set adds a generic CPPC performance display based on the
> standardized ACPI CPPC sysfs fields, wires it up for non AMD
> processors, and updates debug frequency output so cpupower prints both
> kernel reported and hardware reported current frequencies when both
> are available.
> 
> Jeremy Linton (3):
>    cpupower: Add generic CPPC performance display
>    cpupower: Build and call CPPC information on non-AMD processors
>    cpupower: Print kernel and hardware frequency information
> 
>   tools/power/cpupower/Makefile                |  2 +-
>   tools/power/cpupower/utils/cpufreq-info.c    | 11 ++--
>   tools/power/cpupower/utils/helpers/cppc.c    | 56 ++++++++++++++++++++
>   tools/power/cpupower/utils/helpers/helpers.h |  2 +
>   4 files changed, 65 insertions(+), 6 deletions(-)
>   create mode 100644 tools/power/cpupower/utils/helpers/cppc.c
> 

Applied to https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for Linux 7.3-rc1.

thanks,
-- Shuah
