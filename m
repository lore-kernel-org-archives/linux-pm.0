Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793302555;
	b=4toN8KK6hiSAkfVTVuAv8RWComMl4MzaFvyqMiOHKci49PYg+hWtsrq3D/20wpdAOhsf
	 utG/VjhCsgviwiSIMzOIBu7xhx7DEIoeb8kLQq5VvRFQuHgv8gbMInUWPbwP//nDHR4My
	 VPIJUipYTf9m7CTdHa82VkI5WETAbLs4cQHK18/PEMmPoSVn2LnlJj9OudfC/JFtBivoY
	 olwgVZdOy/w770rUADOx7kpi14je+hvmWteGmat03vl2zb4mpZaWVV+99MCACUbIWQgq1
	 rbgvYMToSDbjojCJzrBD2tIUDf5JqtxfENH1ktRPa2/AusgnHShINA7cmajLZri8d2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302555;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VLoQjKnzZ2TBfGpznbO3XlkHhErxwhsxP3XI3XUarJc=;
	b=PFSBByp53QE+MEtU7DleVrGzX4WZfS7gf5h/J6tclLVy15ZIHliFJyW2DxHkrwlVCiZD
	 HhngM5sv7Qq4fkCe75mXWqV//MUd+38AxMuPG0LqVnbwD4oupkf8nesPLZ56C0D3S1aij
	 PXa4GFUz+p16x5a2RzOFDKCDQluGLmWPiq7nqO/BTOyvvekLpcPMjLAVldArs+J6AOHCq
	 +CeND1SJVNdC42KVvOh7MBwftY6JzOeAM/TvnAq/JWcRcrRVDLuRIxngym2ir+g0UbIfa
	 PB0pc75+5bhZ04LbH8D2L/q9ifxpJ6oYRBndicpbljfP2ToEBsj0Tme08Mp28Hcr5iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpL0NIoR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7D606A31E;
	Thu, 29 Oct 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpL0NIoR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F06A1F01816;
	Thu, 29 Oct 2026 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793302554;
	bh=VLoQjKnzZ2TBfGpznbO3XlkHhErxwhsxP3XI3XUarJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PpL0NIoRMsBAtrylw0YhjzO/mLkXwSdJayin57LzhD6VZttZ7nekYHk30VYbNlD9A
	 +nSYnbcfuOEcqUkLMcQ7ePkPK+18AquQS7yQnIoiK2sfWHRTiV/RkWPULaLo86iISy
	 9ovUvbRGKdGi4fZO/m3QUfHJZQBJcacHDQF5cyD5bf3oOLrRB8q8rt9+70Qwj3YiUE
	 bnIctlu7NAKGQ3Jx499zUYOfeDxZIU3M7hHz8SZ0idsCsY0FR1njezjmBhEcJyoea+
	 c4SjEuL8LW2mGILTn9ql+AtM4TvgXZARFynBrpNd+xVBWzlrG4TTSSjJLAGKO8otbp
	 rnGIyPLf0rx0w==
Message-ID: <e8490d6f-f445-42b1-b5fc-f07e988ad6ec@kernel.org>
Date: Thu, 29 Oct 2026 14:35:50 -0500
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
Subject: Re: [PATCH 0/2] cpufreq/amd-pstate register write fixes
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261029121945.854675-1-christian.loehle@arm.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261029121945.854675-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/26 07:19, Christian Loehle wrote:
> Two issues that popped up when trying to integrate an AMD machine into
> my testing for acpi-cppc, in particular for this (otherwise
> unrelated) patch:
> https://lore.kernel.org/lkml/20261020121846.691218-2-sumitg@nvidia.com/
> 
> The first is rather straightforward, I think the case was just not
> considered during the refactor of the Fixes commit.
> The second is part of the resume handling and was introduced when
> that restored the register values (DESIRED derived from policy->cur).
> My platform seems to handle it well, but it's still strange
> behaviour, so why not fix it.
> (Also of course the resume value will generally be overwritten and
> therefore 'fixed' anyway.)
> 
> Christian Loehle (2):
>    cpufreq/amd-pstate: Keep minimum requests within policy limits
>    cpufreq/amd-pstate: Clamp desired perf on resume
> 
>   drivers/cpufreq/amd-pstate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8

Thanks for the fixes.  I'll pick them up for 7.4-rc2.

Acked-by: Mario Limociello (AMD) <superm1@kernel.org>
