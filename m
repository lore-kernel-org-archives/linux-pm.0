Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02A1F8691;
	Fri, 20 Feb 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604383; cv=none; b=dzIt8iQuEijxQrwrIvzcn61aRyIxFrM82lLKpT447H8OOmyxOhy1Byp16Owzu5BT8MESr3uFiWIlAZyBBB9A3N5y1XdRNzPmM/KNv/Y5Zu5TR7PTdcOrsmCVV5X0a0vAVMbUHjpTNgGoY80GoHmVtqNl0m1RB4cmuwMxbD83SAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604383; c=relaxed/simple;
	bh=fbIuMAOrr0Nt3alD+VLiC66+4DvkcvaorPDAJHY32Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEG9yeoL37wKrLq+DaxJX40zTXK14lF9P9e1CynW+QASCAZM+olmRgD4HH/JD/t846WRvkfrtYTXRDrOEYCr6KQdz0te9SyFE3+did+JSmG7r2oYwBsNPFtnuOYJGxDlR7p/YgcXToNXWDkijWi88cxFdtakQssEk0JPI4r6q8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZO2BBFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZO2BBFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A9BC19424;
	Fri, 20 Feb 2026 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771604383;
	bh=fbIuMAOrr0Nt3alD+VLiC66+4DvkcvaorPDAJHY32Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZZO2BBFnBNaUwTCYJrktFE5E4TVllKrJH95xF32lHW2lHnc8atpQ3mS2gJVIE0wdu
	 ynjDfmmg0Y2zfJVAMwoKdoeuGPWzVBnoEck1YR4FugKDpcTzbgKFzakhVau8URmGI3
	 NhmanMu0dlkYdH4bFIawVInJuZuY51Kc5YpJv8mb0Xa9278hz3ZdRBkG3ucOBAk+Yy
	 J0MLcCU+1gNh4d8TQjOuspsEMBOd9evQMRmoR9tkEZZwLrR3epiMFXAwYL8tXUMtfq
	 5yQhJg89XWWVocJiIikDysQ851rR6CxuDUdJrkB9wh/oVJGShCvLzZFDTilExg+C+p
	 63vbwAHFMO5UQ==
Message-ID: <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
Date: Fri, 20 Feb 2026 09:19:41 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add support for setting EPP via systemd service
To: Jan Kiszka <jan.kiszka@siemens.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 shuah <shuah@kernel.org>
References: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/26 04:12, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Extend the systemd service so that it can be used for tuning the Energy
> Performance Preference (EPP) as well.

How would users use this support? Add a few lines to help them.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   tools/power/cpupower/cpupower-service.conf | 5 +++++
>   tools/power/cpupower/cpupower.sh           | 6 ++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/tools/power/cpupower/cpupower-service.conf b/tools/power/cpupower/cpupower-service.conf
> index 02eabe8e3614..abbb46967565 100644
> --- a/tools/power/cpupower/cpupower-service.conf
> +++ b/tools/power/cpupower/cpupower-service.conf
> @@ -30,3 +30,8 @@
>   # its policy for the relative importance of performance versus energy savings to
>   # the processor. See man CPUPOWER-SET(1) for additional details
>   #PERF_BIAS=
> +
> +# Set the Energy Performance Preference
> +# Available options can be read from
> +# /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> +#EPP=
> diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
> index a37dd4cfdb2b..6283e8bf275d 100644
> --- a/tools/power/cpupower/cpupower.sh
> +++ b/tools/power/cpupower/cpupower.sh
> @@ -23,4 +23,10 @@ then
>       cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
>   fi
>   
> +# apply Energy Performance Preference
> +if test -n "$EPP"
> +then
> +    cpupower set -e "$EPP" > /dev/null || ESTATUS=1
> +fi
> +
>   exit $ESTATUS

thanks,
-- Shuah
