Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608724;
	b=dsncu+mTx71szv73WTQStzv/HwVn+sNLJwjlUM8PHzDSva3DGcO8kGPLTxv0wbO4dqP3
	 xzcGTFSVtWPo8CoQ/4uAMjezA532QddjHnb5chvyfHk7TeBVTlSGPs/jZ8DeSl+Ycjw8t
	 KqMEzN2i8czhx3eDQ8uak42uvkflrEyJPZ+/Bm+3XuGeprYtzQT4el2GF9b+Ofy8bhvfC
	 DE5Ba3wyy2Wnfh1gU9aRuHKYqkHJ7caE6gaLWld+7oDS/IYtSyJG0fUjKFVGBs7wM4dsd
	 y7za1cuS318/BiyVrSNNLjKm/gm5BIZY+Nc8z61N6c+pd4VLoPQRdjgL+3BTJR00Dng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ALAVVcLX8MYIjdcNV1urspiVK2AVDCX+KdL/tArgC58=;
	b=RUVUS2IdpAGMT3YJyDLxQpkwEJaJ0ryvN40vJWD5DmEhsLHL2zYHNMYL9Y9dwBmPzmdN
	 lB3KvovHrjqHtIcL0JseNjtXHa8eyNOt6v077N5/sAs6fhmYnA3lgU9bVOHZUck2e1737
	 8pQ8Ih++IYsdJmngo2daIFkDE2/oH4/AEtdnTMCP5U/CP2nmKOZEuLF8XmldzLznBMhtH
	 /Cpofx7+xFyrTinkpWSaiLVgO9oijsy8KHcS/hwiFW9zSD5nPM6yyHweIolbLOPuQl/WI
	 daSEY+Erc+znDFlj2ttkWusZAhGFOlfcvjsnK0DRtRQmI2A0pWflqSOPuJUYjmXQtxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SHebu6ho;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC87606A339
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 08:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC87606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SHebu6ho
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so4128487eec.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793608723; x=1794213523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ALAVVcLX8MYIjdcNV1urspiVK2AVDCX+KdL/tArgC58=;
        b=SHebu6hoU+l6S24ourZc1qdv7upLIrnVe/F/sF7kE+UblHKNd8Dm/yvtFnW1hxuHTi
         gkw12/YBHBBewxvMXAWAh5T57tcX2TfCCYzWue2IQlOPBJe0Aj7QuQHN2XE3ee6zQRN3
         nyoh52cV9jS7cPnJ/v1lhuG9mUEzcFDkAnXcvylHwFk6RdHaQZsISxX1WL3BznoFlSKg
         7uCk+RyfT7QJPp4Obj4rRpgXZBnT1AuPHcSzJQ54vhYuMbyX839IxZ3FIeHhUDzgaAgh
         aAiHgxRZNonuaeqyPKPsG+MH8rmjWm8UepvCNfch2WZMzK4OofLaDFis8D4k4cwJWvoo
         7DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793608723; x=1794213523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALAVVcLX8MYIjdcNV1urspiVK2AVDCX+KdL/tArgC58=;
        b=yjc7amFItRnkFy9vl/RYclMsvioUdAn+o3fi2xh0ASD30xAX4P3l4qA6re1zI6tbkW
         7M0ztjyRouoF/0ICVMTjx1yxP56dzEwTt2t8qWJKOhvPD5Kll2NzSQHAigZsJ871pwBO
         8kjSso9Rz0p9h3c0R1dAiUAgCYBVx5156vNGe12HiQjelbXpvQzbGg6dEjsqZIJyO5cE
         wpqiYrw3G4CXZd6NnQeietc1hsza9POh1xRN6LwNAxfCiCkNUFB8wvoZsFrPH4mpbUWs
         mg4SB7z4jVQ8hRmdLjNi/aSpwrCWQcLWx8V2Rxy6ycZP4IW3vFWttukWfeo4A+obvh2g
         DLlA==
X-Forwarded-Encrypted: i=1; AKwUvBxVPFErt/3vlNc2j5uvWR3dfSSBbKKFuSND5n0vvr8e4B28O1qhJWH0+/zzZXKzON3JUUTV47gGxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z82ZlLZ+yFQZxB73utjazd7lQVHapqIwNrFBYVdmDULjfQ5Ttzs
	ktSNz5sn8uRO9qqlxCG9WZNmnZN7oUlYTzJ4KS1xBGNVQGGsFGPgr9yVq8UqK7iWXig=
X-Gm-Gg: AYBFou1/lGCAc4t/RE2ZJRP7XLNqLY9Go0vhN1k1LUdnDSvi8FkhRnaUFB2lFqgMPBp
	eLy+dwryIG2lMcM2zZxo0eCm6MDPYxn+qGogxyIGpGRq7YRx36SXO2oOyXvlpd/dFx+qiqDqNsT
	mCXF9aTmeqYOxt0SpZwPtuMR+s12XcO8JSejgNKrWXQpLSJkvf2JG7wyyzggCiG6Wz2mjBj6pru
	gR/7f78h2kpuLp5/ZCTfv7fUdrUrRJTAfc+cmaj2X21u2r/0xp9FbFGMIwxYYv6SWURoQH+Vthp
	z/9zcP4YBNmSUQh2xcVgu32COsmidvhj5cS3S9jw5YHZHjFy2jNCSisVZhgpUCqV4WPBNveEb/2
	n884P9GFD2vCBtE/+Ww33wnZ0wRs6OVF9CMDEh0O1t3FU1AbVnlgHQdBTG95LEJLEB6olt+Ph9O
	8QOk4mPvYIszsJNL0Cgw1NGysK5BCxWk7Aq8+VVLi90+P4Qmy+UlE5ZzPm37TAr0nyyPctV4Dfd
	oT1xqPf5hcYiZFZvrO5k3efJ7AfYezOGXo8ebEpqrGEmvCqGjNIYgcO+HLmPvl4QgNOXOpPZDzL
	RLAJygG5gIRUkR5+qVvNiU5XR3eGi0M=
X-Received: by 2002:a05:7300:e9c5:10b0:367:3d68:8480 with SMTP id 5a478bee46e88-36a4206d82emr15498311eec.0.1793608722988;
        Mon, 02 Nov 2026 00:38:42 -0800 (PST)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm37714488eec.3.2026.11.02.00.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:38:42 -0800 (PST)
Date: Mon, 2 Nov 2026 14:08:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 2/2] cpufreq: fix policy max not returning to
 non-boost freq on boost disable
Message-ID: <auhMD2-5FD4BqImG@vireshk-B250M-D3H>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-schedutil-boost-frequency-handling-v3-2-68de169498c7@oss.qualcomm.com>

Hi,

On 29-09-26, 17:08, Ananthu C V wrote:
> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
> max boost is known") introduced a guard for cpuinfo max updates to only
> increase, to preserve driver-set values above the freq table maximum.
> Later commit db80ad776cd2 ("cpufreq: Remove driver default policy->min/max
> init") dropped the 'policy->max = max_freq' assignment from
> cpufreq_frequency_table_cpuinfo, leaving that one-way-guard to be the only
> path for cpuinfo max and consequently policy max to be updated, causing
> both values to be stuck at boost frequency even when boost is disabled.
> 
> Unconditionally track the highest non-boost frequency (max_base_freq)
> in the freq table. If boost frequencies are available, use the highest
> frequency from the table/max_base_freq instead of cpuinfo->max_freq to
> control boost values, so the value can decrease again when boost is
> disabled.

If this is a fix, it should be submitted separately so we can get this merged
independently.

> Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max init")

I am not able to understand the current problem though. I see from the sequence
of events mentioned in your cover-letter that scaling_max_freq doesn't return
back, but why ?

And does a simple revert of the above commit (just freq_table.c) fixes it ?

> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq.c    | 16 +++++++++++++++-
>  drivers/cpufreq/freq_table.c |  9 ++++++++-
>  include/linux/cpufreq.h      |  3 +++
>  3 files changed, 26 insertions(+), 2 deletions(-)

-- 
viresh
