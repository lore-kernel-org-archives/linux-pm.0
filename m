Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7C307AF4;
	Fri, 20 Feb 2026 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613545; cv=none; b=XrtDqVExSyPNIZEPJOUJEFpXMc6jHHKINGmNMo8nT9q09Kukn9OaZo+GKiQePp1YmeqdNtHmOghJqqE95fG3NdEq/UuQmc4RYYrHR60lTTOB79EuL7CC2uru2Jt9UetsOdBgPLftF9kBngU7Wf7NzqkCKxUZ2fk8VzK6SxdS3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613545; c=relaxed/simple;
	bh=0j5B9u1TqAi1MV6AR+HHiY0JD5Wr72J6ItB5OtJnuwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7PWCwkTFuCKnYy2soQERud4w94mQ7qMmqgvfdNPlZkzG9gQeoabUDvfegPcxTANhATzfMKycwEccAsgzR03RtU50pAtc8skp3yxXwNA8xXlMX33YKsagff7du+QubAUniyzcE3fz+8xd8AaR/m+gF9Vh0s6o7YcnI6aSBxCx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHigHaPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHigHaPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8380BC116C6;
	Fri, 20 Feb 2026 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771613544;
	bh=0j5B9u1TqAi1MV6AR+HHiY0JD5Wr72J6ItB5OtJnuwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHigHaPYnPtQ+lgebW1Dqw7mfoMWy2DkBEbQ8wgMcO4bEA2G+Z1LaXbgURMGIKKv+
	 2dVND6ewHHIfVzvXnZdER22tJWUAYJUSv8vUk7iZccgtjnKCEkS2Q96wbzu6/KRoxD
	 pCtPrvhAjxUVynXwfPnV5l8sBRMFZjVTqkiyjB2MkOOdPvJTO7IBucleCn/e0VTLy2
	 r37VQ9CudsGxJgy7sGbiuZN4qBJevJM8sRFhlt4iz8SfCn0I06vPkDx9HBDcxgSn1p
	 6Wk+l32ykqA4q8x5mFiv32t/JzNSJZRaWgeSJjWTcH9kBZWv/zpUahjHl5mnDeVC10
	 PFXqWk/w0eTwA==
Message-ID: <95cdfedd-3eeb-4de8-a8de-78e0ca5292c5@kernel.org>
Date: Fri, 20 Feb 2026 11:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Add support for setting EPP via systemd service
To: Jan Kiszka <jan.kiszka@siemens.com>, Shuah <shuah@kernel.org>,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <aa240c08-9dc9-4e2f-a890-57ba9731fbb8@siemens.com>
 <3cf87836-1fb7-4706-86ff-267383a8d914@kernel.org>
 <5a50f8d7-d06b-479b-8b39-71817facd523@siemens.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <5a50f8d7-d06b-479b-8b39-71817facd523@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 11:27, Jan Kiszka wrote:
> On 20.02.26 17:19, Shuah wrote:
>> On 2/14/26 04:12, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Extend the systemd service so that it can be used for tuning the Energy
>>> Performance Preference (EPP) as well.
>>
>> How would users use this support? Add a few lines to help them.
>>
> 
> Just like the rest of this service: Install it, tune the conf file
> according to local preferences. I just followed the preexisting patterns.
> 
> What would you like to see on top? And where? Copy what is inline
> documented below into the commit message?
> 

Yes. Copying what is inline into the commit message works well.

thanks,
-- Shuah
