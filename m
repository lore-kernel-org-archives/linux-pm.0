Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701E3D9540;
	Thu, 16 Jul 2026 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244398; cv=none; b=CPK+rRQfllyQRtgwLGdrzNtBoVBMbblJ4hvSsOtV713Fwde2a9mA59QVdq1No0HvcoSU+MJf7tew0dYcW+menoU1OoWipu3e8RCsy9QMbV3jTLemX/NoYv9GFNJoCk2qFlgaXOFf0w+K5JAgnu3LDUipwpCmIID0XH9sLdXVgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244398; c=relaxed/simple;
	bh=7deOdonkM5ZLxkiyJi+soIDv9Ujfe3A3+bHMyCagGy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubbh/k+2VQAD6JdZ9Fne0DXN90ov5cPm/qGY0SVH83bahx09C/nkvt3dCVDra00OwuYjhk80nVLFgQv/GsTIolfLZ9UEcZMwiDdu3lCnAP+Q5KDT/01aQ5hpfv1iJgnColUjrK4SlthdUio8FRnhUVvmh3h8l0isBXgOtuOH7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPdgmSsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPdgmSsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0911F1F000E9;
	Thu, 16 Jul 2026 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784244397;
	bh=HxAdPZOiAb1QKYFuvzbFaotbr1YtZWAdMAQmJwNDpqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JPdgmSsRpCM/2snuOipJvhGhnlW0RS5KLnncAabHfZlUhKdKy08Hlgie5cOTDDtHj
	 DvZrJscgje5P17O808mLZrwbpKvjU3msSB5nKoZ06FDMKjzvUzyoAlFWVawGDXPQLb
	 cLfRlBtm3Z3OrtgDsVVpFcpai5jA8qKv0Fq1FVgeCtBWNA0xAUIdnyO3uVIbuaaHvc
	 LA5cxQ3SMy+vSKcl51Xb69W7Rwj6vposAB/bCdIdRxX5g7hd0qtSoMk+3G0hgy+USH
	 79BRSUCjCGy7XTQi6p5mpzHKvbyiJ4sL0l0l3XAwCEm3OSCkF+ERgMm8HADLTfl1Hb
	 S/yXLQh1B+4WA==
Message-ID: <592b00fd-d529-4373-a733-d9f53d225540@kernel.org>
Date: Thu, 16 Jul 2026 17:26:35 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower/debug/i386: check mmap return value in main
To: longlong yan <yanlonglong@kylinos.cn>, trenn@suse.com, jwyatt@redhat.com,
 jkacur@redhat.com
Cc: skhan@linuxfoundation.org, sageofredondo@gmail.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260629031113.556-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260629031113.556-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/26 21:11, longlong yan wrote:
> The return value of mmap() is not checked. On failure mmap() returns
> MAP_FAILED, not NULL. If mmap() fails, the subsequent for-loop
> dereferences the invalid pointer (MAP_FAILED), causing a segfault.
> 
> Add a check for MAP_FAILED after mmap(), consistent with the existing
> error handling style for open() in the same function.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>   tools/power/cpupower/debug/i386/dump_psb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/i386/dump_psb.c b/tools/power/cpupower/debug/i386/dump_psb.c
> index 6fb81b42ea61..9da519200433 100644
> --- a/tools/power/cpupower/debug/i386/dump_psb.c
> +++ b/tools/power/cpupower/debug/i386/dump_psb.c
> @@ -181,6 +181,11 @@ main(int argc, char *argv[])
>   
>   	mem = mmap(mem, 0x100000 - 0xc0000, PROT_READ, MAP_SHARED, fd, 0xc0000);
>   	close(fd);
> +	
> +	if (mem == MAP_FAILED) {
> +		printf ("Couldn't mmap /dev/mem\n");
> +		exit(1);
> +	}
>   
>   	for (p = mem; p - mem < LEN; p+=16) {
>   		if (memcmp(p, "AMDK7PNOW!", 10) == 0) {

Thank you for the patch. Sorry for a late response.

Please send v2 after fixing checkpatch errors and warnings.

thanks,
-- Shuah
