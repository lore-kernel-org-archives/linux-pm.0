Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E932B10D;
	Fri,  3 Jul 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073877; cv=none; b=E5qE1hBnsYjpdm44yZ5n8FY4DeSHt1RoqnXGf89kpKcTgcRieQ8RA1So8A5CQHznc8nx8BmeBETv6aLMxlLr3gGbLci+0a4A/1hOcUYx9Ka4902sC3Gid8r1Wbckc4w9nIGExPiyXR2zXaSQyEdNtHE48xogR/8KhuGqVLE/qAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073877; c=relaxed/simple;
	bh=j/tTouAGxmCX0MA8tqDKc87dytBVViRRvnYJeSMMS90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRp5MFeojgSkpKu1mrBtIdR+2vUAmyYbqWrLcERI4ULRnACxVq92skqSriuJICFYcd4ohR1XbyXE+TVzcLt8+uDNX20pM5EjAc2Zp3fxsDnDMFyQxMPBN7o8AzJJjr2jN6RyzloO6hCd6PHKtGl+j5xshdrBIPWfGN5Gztm2Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IToxGn+B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IToxGn+B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17AA51F91;
	Fri,  3 Jul 2026 03:17:51 -0700 (PDT)
Received: from [10.57.31.140] (unknown [10.57.31.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D37DF3F905;
	Fri,  3 Jul 2026 03:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783073875; bh=j/tTouAGxmCX0MA8tqDKc87dytBVViRRvnYJeSMMS90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IToxGn+BCO2Iw/dAB7xsa2H9tasXfNqc5rzVV8FbNlcgqfggVJK+czN1EXrN22dRf
	 1fOkcwgeMRHarFds/QWc2XAjeNvZRtaj8Vo0isoimMV+JFZpERFh5ymbJH2qnHE93W
	 fJEn8w+V9Luv3RIMeCymJigJva6GDMsxgug+hE1o=
Message-ID: <483bf544-a033-4f43-870e-2a49790ccbbb@arm.com>
Date: Fri, 3 Jul 2026 11:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: schedutil: Fix self-contradictory comment in
 sugov_iowait_apply()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com
Cc: joel@joelfernandes.org, patrick.bellasi@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260703092433.4080165-1-zhongqiu.han@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260703092433.4080165-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 10:24, Zhongqiu Han wrote:
> The kerneldoc of sugov_iowait_apply() says the IO boost value is increased
> in sugov_iowait_apply() and, in the same sentence, that it is decreased by
> the same function. That is self-contradictory, and the first part is wrong:
> sugov_iowait_apply() only decreases the boost.
> 
> The boost is actually increased in sugov_iowait_boost(). Fix the comment to
> name sugov_iowait_boost() as the place where the boost is increased, so it
> matches the code.
> 
> No functional change.
> 
> Fixes: fd7d5287fd65 ("cpufreq: schedutil: Cleanup and document iowait boost")
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a4e689eefdfb..f7aa26d62700 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -314,7 +314,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * A CPU running a task which woken up after an IO operation can have its
>   * utilization boosted to speed up the completion of those IO operations.
>   * The IO boost value is increased each time a task wakes up from IO, in
> - * sugov_iowait_apply(), and it's instead decreased by this function,
> + * sugov_iowait_boost(), and it's instead decreased by this function,
>   * each time an increase has not been requested (!iowait_boost_pending).
>   *
>   * A CPU which also appears to have been idle for at least one tick has also


