Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172236C9ED;
	Mon, 11 May 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498121; cv=none; b=oj3xCGb24HLLEi7Bl4c7l+rHyM6YFu0PJRZJdLY/mBhrKXPOJeyKddhIC21BYW2CAdveYmegawdWMz3G9kd7SG2yDstVb1em9vjXQTEM+BjtRXAheV0RvRly33o0nKQ9DOtb6ECorPyFRsBquqUW3vCjzIxekvR+TsPQr3vcfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498121; c=relaxed/simple;
	bh=nebdvHRe0Xno2MYFS6FbnaWCHdRznwP+CbwbW4VighI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zod6dlco1Dhv3FtCR2u7xr79yMvHuCbz+oHAKoU9zWo2pDgLT4KHW7vcfGnANnOFw9HIDA65mlRQuqchexeCOGDv1WKoVDyQsW2MYqvN+9oq1Lj1ng78IOsf73504z396eKF3W/hgod5sjBE4DvofbTly1vZvWSg5CXsSq3+zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Oe/GOBhaTJixU0W2yUdQLg==
X-CSE-MsgGUID: W9nTfaO+Qy+XDEwo5cigkQ==
X-IronPort-AV: E=Sophos;i="6.23,228,1770566400"; 
   d="scan'208";a="175409463"
From: Tianxiang Chen <nanmu@xiaomi.com>
To: <zhongqiu.han@oss.qualcomm.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lingyue@xiaomi.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: Fix hotplug-suspend race during reboot
Date: Mon, 11 May 2026 19:14:07 +0800
Message-ID: <20260511111407.455-1-nanmu@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b3cabf3d-7672-4816-91f0-e6fafd9db4d0@oss.qualcomm.com>
References: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com> <20260408141914.35281-1-nanmu@xiaomi.com> <b3cabf3d-7672-4816-91f0-e6fafd9db4d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX19.mioffice.cn (10.237.8.139) To YZ-MBX05.mioffice.cn
 (10.237.88.125)

On 4/14/2026 10:44 PM, Zhongqiu Han wrote:
> May I know did you test this with lockdep enabled? Specifically, does
> the new cpus_read_lock() -> policy->rwsem ordering in cpufreq_suspend()
> trigger any lockdep warnings? Thanks

Hi Zhongqiu,

Thanks for the review.

I did test v2 with lockdep enabled and was NOT able to reproduce any
warning. 

No circular-locking splat or "possible deadlock" report was observed
in dmesg across multiple runs.

My reasoning for why the new order should be safe:

  * The patch establishes  cpus_read_lock() -> policy->rwsem.
  * The hotplug path already holds cpu_hotplug_lock (write side,
    via the hotplug core) before taking policy->rwsem inside
    cpufreq_offline()/cpufreq_online(), i.e. the same direction.
  * I grep'd cpufreq and did not find an existing path that takes
    policy->rwsem first and then acquires cpus_read_lock()
    underneath. If I missed one, please point me at it.
  * cpus_read_lock() is a percpu-rwsem read side and is re-entrant,
    so even if an outer caller already holds it (e.g. via a pm
    notifier running inside a hotplug callback) this is safe.

May I ask whether you have actually observed a lockdep splat on this
change on any downstream tree, or is this a precautionary question?
If you have a specific call chain in mind, I would like to add
targeted coverage before v3 so we can nail it down definitively.

Thanks,
Tianxiang
