Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753D23EAB2;
	Thu,  2 Apr 2026 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146189; cv=none; b=dmyEFz6FtAHdbjidIKEcIMoJlMUA3ul8M6JFPeWau7IT6Tqgm/+/5mr3x3Qz1zQzWiBZQ3ECdZbiyUZkhKNnM6I3wLoCDu7d9QkakFBry+xMO87sNy1f4nZz862Y+rgGoLNKmroLBltHKKiR5R4bBHpU3Gp9sawjRnk6Cp52LF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146189; c=relaxed/simple;
	bh=y8eZqB1rZ3yBvlJJOwwgV+2EmhjYmsdHR3Va7vTYEcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3vuaISUaXD8iRPghafRo+PfQHKWFca527z7mEp4nP3ZMuoi10lYHdOAbGFBgh4SVoOpQ54RXZpnHtxQNy4FEgkXmfenrvCyXexZkrP79IUFOEgjV578Hf0N2riouXTMvp6IKRKJ4DgGnoY7wkI4Fnbhsnd2Pu+wggHkmSLHKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXXfrSuC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXXfrSuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EB6C116C6;
	Thu,  2 Apr 2026 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775146188;
	bh=y8eZqB1rZ3yBvlJJOwwgV+2EmhjYmsdHR3Va7vTYEcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AXXfrSuCqd5w2EKia5kWbZDzaq/rdQzQvFphF9Ky38sePoDHYlzULS/qR/swGyaEa
	 moqDXzCVe80huq5HfUkwgJLJiCOHDLhtYQMXKEuyDrPAYTR159rAnJKNSszLxlSej3
	 LW+mr+ugDePNHJWEoZ7YkdSLam+HGgLYHxITftOLoWLRtJIl1QrkHBRWcaPCUstM+o
	 at0i/hapI08zJ3Txs2ateQb+bLXXmjUKZJYJbUa4KJWlBSNk6OAvXPDhaQqL6Frsjp
	 om24y5CzMgJbzeTv4gQaMxwQ5KQHZ9uSwLoErvVe8fg3TQrXKD6bgJ7HOH53U9dBBZ
	 rhDkwEDVrgWlw==
Message-ID: <eea2ce3c-5c8a-4740-b700-90b29f0ffe25@kernel.org>
Date: Thu, 2 Apr 2026 11:09:46 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: amd-pstate: Step down as maintainer, add
 Prateek as reviewer
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@gmail.com, K Prateek Nayak <kprateek.nayak@amd.com>,
 rafael@kernel.org, viresh.kumar@linaro.org, ray.huang@amd.com,
 perry.yuan@amd.com
References: <20260402102611.16519-1-gautham.shenoy@amd.com>
 <31d6da20-c0d8-4ccf-90e0-7484e6f07264@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <31d6da20-c0d8-4ccf-90e0-7484e6f07264@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/26 6:21 AM, K Prateek Nayak wrote:
> Hello Gautham,
> 
> On 4/2/2026 3:56 PM, Gautham R. Shenoy wrote:
>> Mario Limonciello has led amd-pstate maintenance in recent years and
>> has done excellent work. The amd-pstate driver is in good hands with
>> him. I am stepping down as co-maintainer as I move on to other things.
> 
> Thank you for helping build the strong foundations that amd-pstate rests
> on. What was once a house of cards is now a fortress thanks to all your
> hard work!
> 
> _I'm not crying. Just sweating from my eyes_
> 
>>
>> Add K Prateek Nayak as a reviewer. He has been actively contributing
>> to the driver including preferred-core and ITMT improvements, and has
>> been helping review amd-pstate patches for a while now.
>>
>> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 
> Acked-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

If I don't Ack, you have to stay right?

But seriously, thank you for all your contributions.

Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
