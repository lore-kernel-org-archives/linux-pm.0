Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88273DF01F;
	Mon, 27 Jul 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139389; cv=none; b=Z6juKujWSsz4ivqaw7uTVQctlCbJ+7PZzOognohvs/NmOji06k43KioiKIkUEE/6rms3zQtEK5LowlwP/FoVD3J0prhHX3KQv8Rwu7kn57qY4YiGLP78Ja7UgVBhJSSqO2MyZcRiPEv+b5PY0GWlACWK9NFSphhg9jrye6JC/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139389; c=relaxed/simple;
	bh=O+ZcGUYAWu22PKVPsRvmifPDghdJ4vKTBwPiuCdPU6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFzjpQl72EUurJqRTbC737BY8aFSDknLptWFnHCU+i2beeVbRVE5VO+78nEnqBzWHZG2IojQR1IKMHamsAvuiSx7wDxbhwDiq7nMU8FOqX2oowoEXj1k1w6XqF7ijYjDbKAQQxnxP/E8UJ1tgQfMhHJIYu9D2jxOcAikUs04Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sEGyI2Sy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sEGyI2Sy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 843671476;
	Mon, 27 Jul 2026 01:03:02 -0700 (PDT)
Received: from [10.57.0.92] (unknown [10.57.0.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278843F66F;
	Mon, 27 Jul 2026 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785139386; bh=O+ZcGUYAWu22PKVPsRvmifPDghdJ4vKTBwPiuCdPU6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sEGyI2SyOJlJmHuaUMvlBNkzjiGUIG5LCyDlok2Z9AdfiYzAh+v6XziM+BP2RK2GL
	 Gv8rAZW/SJrTjhR/Na32J+piYUrH+AiD53mLzm+oATu6vVey8ENrbzvUA8s1Q4s5G9
	 TUT2IhCAhIRJZmzXu3/u6FCXnwsrpqd4u3+8U6ZM=
Message-ID: <82e71c8f-7755-43f6-9518-209525f5acbc@arm.com>
Date: Mon, 27 Jul 2026 09:03:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
To: Christoph Hellwig <hch@infradead.org>, Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org, pavel@kernel.org,
 lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <alSVBRoPnyVHLcEJ@infradead.org>
 <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
 <amCHAZgQQkgDSQYo@infradead.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <amCHAZgQQkgDSQYo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/26 10:01, Christoph Hellwig wrote:
> On Tue, Jul 21, 2026 at 07:10:38PM +0800, Xuewen Yan wrote:
>> we use it in android vendor specific ko, and the ko is not upstream.
>> We use them with em_dev_update_perf_domain(), Just like
>> em_dev_update_perf_domain() was exported, export the
>> em_table_alloc/free.
> 
> As you've probably been told many times exporting symbols without
> in-tree users that are in the same series or at least directly
> references is a no-go, and continuing to post them is considered
> extremely offensive.  Don't do this.
> 

It's a bit more complex situation IMHO. We have been always
struggling to involve kernel folks from Android world to contribute
into the mainline Linux. The thing is they have to apply some hacks
in order to make the plumbing for the new devices. This is
an example where they struggle. They ask work vendor hooks to workaround
which complicates even more the maintenance of stable Android kernel.
I have seen those good examples where finally the drivers are pushed
upstream, since downstream maintenance complexity is too high. Something
has to break this circle.

