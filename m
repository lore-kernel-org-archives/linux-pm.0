Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5535CED2;
	Fri,  5 Sep 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080461; cv=none; b=s0TKKnsRK3oCrOERzRmNwmxtfVLtiiDF4AZwr5G19fYNvveiABVlX8u96sFfIWXutpazsl6TVtOuyvr6njMNLxSI0iOGQuu+CR3X5BuG5zC96Dt7YKyslN3rpKe7wJpQBuTdmm9TtvK2xTMeQaIdt0EUrJqp8KKRRy6k0x3TCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080461; c=relaxed/simple;
	bh=/UIL3+WZ7W7nXE8WmYcAAMrqnGI16yhjDphQT5v2ZUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn5+mvTjFKhGE4ieHOTnEJqyyxj3488YS+mRLS2rCF+B1Kf4w/WrwfVDBkTmDcQSx5Y0ZFbNwwUakqGyy0LLTaxwHy9TvFM9Ac23SakBMNcNi8/dNwn+5cZwO1Qj5nlJX8+6rYj6GFJ1/Kfy9tWTK8IBTZHxXbuU7rK8jlORx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fc1kqRMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fc1kqRMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8B4C4CEF5;
	Fri,  5 Sep 2025 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080459;
	bh=/UIL3+WZ7W7nXE8WmYcAAMrqnGI16yhjDphQT5v2ZUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc1kqRMbUuMMUQw4YBHwYNhK89erJwY2h9fP496hLCXNqNa9KBrNa4mXv/2SCcrLn
	 /u80c294kFE9OlCaylkXg0seaDXVFwbDi7puW0bfRT9wBUQ81rD5T0ZN0QS7if49u4
	 jyNn8EqkFsyKQGDfSqTjOHcDCwCjpKUYGPLtwiDklit1PNQEUsanpdRVT/JwfYi0Oc
	 vL33w/vi1upNbogSdLva7ZXuzClbOyThYXHy6svgGg2N5XSvbhhastxEEUOaRrwWCt
	 DyivHbo8+Ht0W/flYiXyr+To/Uv32WshuMji6K9GcTZndWDt4mPal3oF6oR83USxQ+
	 hzAAY0qf5/ChA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject:
 [PATCH v1 1/3] cpufreq: intel_pstate: Fix object lifecycle issue in
 update_qos_request()
Date: Fri, 05 Sep 2025 15:52:03 +0200
Message-ID: <2255671.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5028967.GXAFRqVoOG@rafael.j.wysocki>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cpufreq_cpu_put() call in update_qos_request() takes place too early
because the latter subsequently calls freq_qos_update_request() that
indirectly accesses the policy object in question through the QoS request
object passed to it.

Fortunately, update_qos_request() is called under intel_pstate_driver_lock,
so this issue does not matter for changing the intel_pstate operation
mode, but it theoretically can cause a crash to occur on CPU device hot
removal (which currently can only happen in virt, but it is formally
supported nevertheless).

Address this issue by modifying update_qos_request() to drop the
reference to the policy later.

Fixes: da5c504c7aae ("cpufreq: intel_pstate: Implement QoS supported freq constraints")
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1708,10 +1708,10 @@ static void update_qos_request(enum freq
 			continue;
 
 		req = policy->driver_data;
-		cpufreq_cpu_put(policy);
-
-		if (!req)
+		if (!req) {
+			cpufreq_cpu_put(policy);
 			continue;
+		}
 
 		if (hwp_active)
 			intel_pstate_get_hwp_cap(cpu);
@@ -1727,6 +1727,8 @@ static void update_qos_request(enum freq
 
 		if (freq_qos_update_request(req, freq) < 0)
 			pr_warn("Failed to update freq constraint: CPU%d\n", i);
+
+		cpufreq_cpu_put(policy);
 	}
 }
 



