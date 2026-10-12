Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE03932CD;
	Mon, 12 Oct 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803054; cv=none; b=mpA8mDKA0EyUQGYBmtKrn1JW3Zh7/YAkFcTxM1wPxr8T5DTUMb7Lxfv36z7vAEGZ3C2Hk1yfYFQ393arKbvJoqIKDpzeSxCmKlqeP+smfRBRjYpCgds4dZxCAPHpnOGwrc8I6N9pEE/gW36znQYRIXOehx7yC+kRWlQ78aEMaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803054; c=relaxed/simple;
	bh=Uoger/6i+U9R/3R8Mxjg0FsI30PjlNy00uruFl2bnhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT5yO9qFdY7aiOxFpvsSOqwCPv+jOhks359YztLP4UEaUqvwfkcTt5+sq97yO6fWlwrqmabpfI27FXhy0fXQG9+KgIoHumKTRz7QfHq9Hu4O5f0+eyI3eQHsGPtsIEtjG4EER9WW37WNafkk/Z7g7ZBMHyojLA/Vg6+FYCthjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oG9FLrOL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oG9FLrOL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5BF1655;
	Mon, 12 Oct 2026 04:04:08 -0700 (PDT)
Received: from [10.57.12.163] (unknown [10.57.12.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECCF3F882;
	Mon, 12 Oct 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791803051; bh=Uoger/6i+U9R/3R8Mxjg0FsI30PjlNy00uruFl2bnhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oG9FLrOLY8KTiQ9oAF6jOpwHmMrnhcwd59ravjOZFd2iijqO6S2wzS8qd7dVww1p5
	 oRQfMSvT/00lzftmGojNbzpu4nOZtHb27cBs3PHntwCrs4RTfXrcD3eEA44sNMsSLd
	 REYGoD+8Qqm2n0Wuh0h8UtKv6BGHaFFI91oixOQs=
Message-ID: <34106881-8ca0-4c9f-a4d2-0ff0b35460dc@arm.com>
Date: Mon, 12 Oct 2026 12:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: QoS: Add a sysfs CPU latency request with a
 boot-time value
To: Roman Kagan <rkagan@amazon.de>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Christian Loehle <christian.loehle@arm.com>,
 Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 nh-open-source@amazon.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Len Brown <lenb@kernel.org>
References: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/26 14:29, Roman Kagan wrote:
> The idle states offered by a platform trade wakeup latency for energy
> savings, and there are situations where the trade is not worth making:
> while a latency-sensitive workload is running, or during a live update
> via kexec, where everything from the outgoing kernel stopping the
> workload to the incoming kernel resuming it is downtime, and deep idle
> states may lengthen it.
> 
[snip]

For your scenario, when doing kexec to the new kernel, the normal
disable procedure for idle states for each CPU doesn't work?
You would like to keep this information also in the booting
system (via bootcmd) so the CPUs are still not allowed to go deeper
idle during boot, is that right?
Isn't it FW responsibility?

BTW, I'm not a fun of one global knob for all CPUs. I would
favor extending the usage of the new sysfs and make it per-CPU.
That would allow more scenarios used by user-space daemons at
runtime and not to create yet another sysfs interface.

Regards,
Lukasz
