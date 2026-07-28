Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D263D6CD8;
	Tue, 28 Jul 2026 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226075; cv=none; b=ec/bo5lhnOoLeLpD3AnlDJu2YzWU3/FdnUk0faP7+zmSMulhypV20C94z3vOqk3O6A0U56ox6jekgX4O4t8Cyzau0re2Rck/jOBuCCRLqJBwnlA8HiwO1SSr3tgDjfrxC1dH9V4az2TrASnyhriYdlewtvgli6aH0HSJnHBWP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226075; c=relaxed/simple;
	bh=gyN6trmo/xmWiedf9L+OefEj+CrZxWDQvALg0jEa944=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKQ02vv8CNaOA33UEzpVkj9ckIctiR034PmW+IVIAojAkIWXyIjAqTIbt392GcAsGkBt8VcsGGqWfbMuMlCHp3CQw74copGzn7QaEtFo5ppY/r2YfFvcvUu2Kd9/ovbLHzjsYRjH1ZhL545GVsixEksPrQNL/Z+g+0NQ+wYeyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O34Ypi3b; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O34Ypi3b"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 000EE1A9A;
	Tue, 28 Jul 2026 01:07:41 -0700 (PDT)
Received: from [10.57.4.140] (unknown [10.57.4.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E96B3F86F;
	Tue, 28 Jul 2026 01:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785226066; bh=gyN6trmo/xmWiedf9L+OefEj+CrZxWDQvALg0jEa944=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O34Ypi3b88wmzNeiRyJNfvbUfcygHh/LCUp0SSFXSjH5ITNTmQiJvZaq8b8LX3TLO
	 d1tQSPMfOYTGxYprcsT2REh+PqHtQNiM/zR4m008gMfTV6Ifx2d8jaVmkRd7o6bxFl
	 1Z5THvJRT2oMEE5WVYH0lazpkEG1KC4xTX1rg0qc=
Message-ID: <ca94527a-e807-4ea5-a577-707e7ea9736e@arm.com>
Date: Tue, 28 Jul 2026 09:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
 rafael@kernel.org, pavel@kernel.org, lenb@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com
References: <20260710082447.5160-1-xuewen.yan@unisoc.com>
 <alSVBRoPnyVHLcEJ@infradead.org>
 <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
 <amCHAZgQQkgDSQYo@infradead.org>
 <82e71c8f-7755-43f6-9518-209525f5acbc@arm.com>
 <amgjsFwIQB01NhQZ@infradead.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <amgjsFwIQB01NhQZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/28/26 04:36, Christoph Hellwig wrote:
> On Mon, Jul 27, 2026 at 09:03:04AM +0100, Lukasz Luba wrote:
>> It's a bit more complex situation IMHO.
> 
> It's not.  And if you think stupid Android decisions that are 100%
> contrary to upstream policies should in any way relevant, you should
> spend your time on RTOS BSPs and not argue on Linux mailing lists.
> 

We will make a driver using that and the export would be attached to
the series. I won't recommend you to spend your time on RTOS BSPs
but I would to spend on your sub-system. It would benefit more from
your experience than this EAS+EM complex world.

