Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271F1D45E8;
	Mon, 23 Mar 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272336; cv=none; b=BxfqxYX5XmcZUd3B0FZlZ9aOcaKtcjIyA6Y9pkGqrGf3MShdRzd7xw0JfzH9+pLj3XBfu3ecbMn1xOvIFTnepxnQ8aWz4tbgcZK6OT9Wp3/wnM7r+qZRVZN8KoJsd7l9YhUr8gb0LaWSG86H4hOqAZNQfYzhzq6ZT2Xa1mIHQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272336; c=relaxed/simple;
	bh=OAgKaBo3UoLOc4bO0IrcNoNBQbE/+FuBY3rnkvRLikY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Uyk5Olh9AONly1+idj5u0ooCxMpQX5idpIzI+RqxJCZEtsjZc3POTCN427efPky6BpYc4PbQMPfnJl99pbg3BCcOY58LMS1gnZ7tTS7EtoUcAu6qoHWjKYm0sUFDM5aA1ZF5NfafQyN9NghFQ4kKU/IF4xYtnzSPjffVXCxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A219E14BF;
	Mon, 23 Mar 2026 06:25:28 -0700 (PDT)
Received: from [10.57.13.16] (unknown [10.57.13.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F3183F641;
	Mon, 23 Mar 2026 06:25:31 -0700 (PDT)
Message-ID: <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
Date: Mon, 23 Mar 2026 13:25:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in
 get_load()
To: Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rui.zhang@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
 amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com,
 jeson.gao@unisoc.com, xuewen.yan94@gmail.com
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
 <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com>
 <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/26 11:06, Viresh Kumar wrote:
> On 23-03-26, 10:52, Lukasz Luba wrote:
>>> How is that okay ? What am I missing ?
> 
> I was missing !SMP :)
> 
>> Right, there is a mix of two things.
>> The 'i' left but should be removed as well, since
>> this is !SMP code with only 1 cpu and i=0.
>>
>> The whole split which has been made for getting
>> the load or utilization from CPU(s) needs to be
>> cleaned. The compiled code looks different since
>> it knows there is non-SMP config used.
> 
> Right, we are allocating that for num_cpus (which should be 1 CPU
> anyway). The entire thing must be cleaned.
> 
>> Do you want to clean that or I should do this?
> 
> It would be helpful if you can do it :)
> 

OK, I will. Thanks for your involvement Viresh!

Xuewen please wait with your v2, I will send
a redesign of this left code today.
