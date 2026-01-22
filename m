Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED8243387;
	Thu, 22 Jan 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071768; cv=none; b=GqhhgM/QnV3wbkf8I66i+WqnM5zcG8wTTm5lLOxtwjXNxUnyCP/pNtKw/w1x3YX2aTm9qXUP/ZLn7wxCMRCLC7C2KANeLGi2LAjDI3xeV4jjTXU3UIgjQbU6vL8VxEiAEYQbZVs/a6S28rq1qaPBMaIpsAUZCq+Y3sk+GaZICUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071768; c=relaxed/simple;
	bh=WSa4SDMIALxyZNfISxDqrJHHAzL3UWkUPCsEk9Br3VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SB2N8KDaaaaw93stZYBTmwhXyeWzlALYao6Nlqbv8Csgrk+RIBYjIIYv/T/eltBLKMT/8mce6xzx2HTGx+OjN3D/ajICMr7sxL6BtHU0UhkYWT1hw9JNeE2Xsf1GodCCL0h3mwLMXvggbQitZLrAVwyWieBPEVOxGrrt1HWflTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E9B91476;
	Thu, 22 Jan 2026 00:49:18 -0800 (PST)
Received: from [10.57.95.182] (unknown [10.57.95.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EDCE3F740;
	Thu, 22 Jan 2026 00:49:23 -0800 (PST)
Message-ID: <54478318-cbee-46f2-9ff1-9c0ae15a89ab@arm.com>
Date: Thu, 22 Jan 2026 08:49:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] cpuidle: menu: Fix high wakeup latency on modern
 platforms
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
 rafael@kernel.org
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, yumpusamongus@gmail.com,
 Ionut Nechita <ionut_n2001@yahoo.com>
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260122080937.22347-2-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/26 08:09, Ionut Nechita (Sunlight Linux) wrote:
> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Hi,
> 
> This v2 patch addresses high wakeup latency in the menu cpuidle governor
> on modern platforms with high C-state exit latencies.
> 
> Changes in v2:
> ==============
> 
> Based on Christian Loehle's feedback, I've simplified the approach to use
> min(predicted_ns, data->next_timer_ns) instead of the 25% safety margin
> from v1.
> 
> The simpler approach is cleaner and achieves the same goal: preventing the
> governor from selecting excessively deep C-states when the prediction
> suggests a short idle period but next_timer_ns is large (e.g., 10ms).
> 
> I will test both approaches (simple min vs 25% margin) and provide
> detailed comparison data including:
> - C-state residency tables
> - Usage statistics
> - Idle miss counts (above/below)
> - Actual latency measurements
> 
> Thank you Christian for the valuable feedback and for pointing out that
> the simpler approach may be sufficient.
> 
It was more of a question than a suggestion outright... And I still have
more of them, quoting v1:
+	 * Add a 25% safety margin to the prediction to reduce the risk of
+	 * selecting too shallow state, but clamp to next_timer to avoid
+	 * selecting unnecessarily deep states.

but the safety margin was ontop of the prediction, i.e. it skewed towards
deeper states (not shallower ones).

You also measured 150us wakeup latency, does this match the reported exit
latency for your platform (roughly)?
What do the platform states look like for you?

A trace or cpuidle sysfs dump pre and post workload would really help to
understand the situation.
Also regarding NOHZ_FULL, does that make a difference for your workload?
That would sort of imply very few idle wakeups (otherwise that bit of tick
overhead probably wouldn't matter. Is the NOHZ_FULL gain only in latency?
Frankly, if there's relatively strict latency requirements on the system
you need to let cpuidle know via pm qos or dma_latency....
