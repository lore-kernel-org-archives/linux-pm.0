Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6691DEFE8;
	Mon,  3 Aug 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778667; cv=none; b=fv1p3rqjUbCaEEAlnj+3HCRudrKoGn+ap6Cwuuu9vAXO/xvQUzECDAc8MlaQTJkpQfUaQd6kq/0VL5Ga3rOxNqnY//B2FxEHjmihZkJm0Smwl7TJDTpyyZcpXoYb4FHI/jB35etOpoOEzdDyqKvRC4hLxGxr1QHSMAUcBOWUwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778667; c=relaxed/simple;
	bh=kxfeXAsiCrPLTAz/zdy1Zlk8tT34222DddX5Jtd0Y/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhpP8dLhd+ff5yRuAb+0MeXFRtPvbn595aa2C7svHwaFcLtR26stm9VQp1sRv8r6GbNYfeCbfqmmFik2kNDGlgqZo01FaKpVmkN2Uzk8IGVu866HRTBycgAVBCOK2O6mVzwOuEMGqOJfv+SsV7XN/+n7JA9OTremXyAD7JSLYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2sibEjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2sibEjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6821F000E9;
	Mon,  3 Aug 2026 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778665;
	bh=UK6iduWxkWzM/gvKZkXCqkNXSBwnjc4WZCJfApHinIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c2sibEjQyunAbp7guVeu4isIGURe9O8thRevKmgV1ly3DvM5UuXh/lDyDjeM3aNDh
	 PjghfYgyVEij4mFGQblaejBXtPPCskTbq4UJfkiHqHNCIYJ73YyA/PThVnruvwBu81
	 MuF3tFwPKZw4RTMrAobicq+GIYHVr+hL3HOSE6qlXfZrwFsxiPLKHIqiD4xspbk812
	 05acpX2/anP23m25bnaat4t/DfHDI62ZpS21F0S0P1HDcKsIMssTZpQtgpLjHRnbp3
	 uipI8oF7s/L94nF5sULFid19ZL1uFdgtvrRbZAfKRYSHv3M/Y9ay55Z+uURG7IRYU4
	 LOr0nsXtW8pvA==
Message-ID: <12624a8c-37ba-43e9-9ab4-3dc39df3d97c@kernel.org>
Date: Mon, 3 Aug 2026 11:37:42 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>
References: <7fa98ba5-6790-48b4-b102-c1193685822f@smtp-relay.sendinblue.com>
 <c746110c-6ac4-4500-a4f0-491a06838173@kernel.org>
 <20260803163620.104223-1-ali@iusegentoo.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260803163620.104223-1-ali@iusegentoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 10:36, Ali Ahmet Memis wrote:
> On Mon, Aug 03, 2026 at 10:29:15AM -0600, Shuah wrote:
>> Sorry I am not taking this patch.
>>
>> Please note that build test just verifies that the code build which
>> fall way short of testing the changed code.
> 
> First, sorry about the duplicates. The mail provider I was using at the
> time rewrote the Message-ID and delivered the same patch several times, so
> it hit the list as a handful of separate threads. That was not me resending
> it. I have moved off that provider and everything since August 1 goes out
> with a stable Message-ID from git send-email.
> 

I noticed the duplicates. I am glad you switched to git send-email.

> The valgrind run was in the notes under the scissors, not just a build: a
> two-CPU mock where CPU1's topology reads fail, uninitialized reads in
> __compare_core_cpu_list() before the patch and none after. If there is
> testing you would want beyond that, tell me what would satisfy you and I
> will do it. Otherwise I am fine dropping this.

I missed that. There is no need to say the patch was build-tested since
you did mock testing.

This patch is doing more than replacing malloc() with calloc(). Please
split the changes into separate patches.

thanks,
-- SHuah
