Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8210834EF0D;
	Fri, 28 Aug 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932149; cv=none; b=DTYrqhUfHKd3UwmRL6tdgYem8Xuj1WJt9Q2bw6L/Lz1AlKbb2y1VHwnN9BCPz90e8f9AkPIHnw+SBQXoJAReJ+u/z5/T0psWQW8M9OMl0JJ3rhzF09gf0pCbndOUAD8wYx11i71OHXsF+Aj3cMjmiTXgbh0ZE+bgs9LTLC8VqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932149; c=relaxed/simple;
	bh=sHZOVGU6R6/vFFhYggjN+yCXZKs9BrwYs90kWOF1fQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1YBGCwm3n60B6BNYudyrIgnQJ+VMJD/jmsN8Zlxj8wzodxiDXVhjCw+NC/F7T/vlHsMTF9GEmHaS6avT+xLxXLOYUoGa2S8FeM3dRWsTa6Kn57tU9k5S+tPaHKMP4f0mDEQ0K2IWZAeGSq+aF0FNy5e4H1wLWjnh1ZJKPrCvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wewfgwfe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wewfgwfe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774C81570;
	Fri, 28 Aug 2026 08:49:01 -0700 (PDT)
Received: from [10.57.5.212] (unknown [10.57.5.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE903F7D8;
	Fri, 28 Aug 2026 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787932145; bh=sHZOVGU6R6/vFFhYggjN+yCXZKs9BrwYs90kWOF1fQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WewfgwfeSwyJd+CYEr3ZCa6Tk7A752y4K1FS7+SBfR6cFCYVmygGOw1g+1Fmb8dsQ
	 riACJlR3qbViM5mhTQSpOMeoMVpo3HE+D8eyWyjo9S1kxKJJolqh7o1am0ChSEdtuz
	 D/JUBbNehtgqsx/WjudNxOjWMnAAFB9qAUDFe+uQ=
Message-ID: <d5f96d83-b5c4-4795-9675-7779f35be78f@arm.com>
Date: Fri, 28 Aug 2026 16:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: teo: Do not return a disabled idle state
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
 daniel.lezcano@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828032457.2317326-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260828032457.2317326-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 04:24, Xueqin Luo wrote:
> If idle state 0 is disabled and none of the enabled idle states satisfies
> the PM QoS latency constraint, constraint_idx in teo_select() stays at its
> initial value of 0, because the loop that updates it starts at state 1,
> and so the candidate state index is capped at state 0, which is disabled,
> and that state is returned to the caller.
> 
> The cpuidle core does not validate the returned state index against the
> per-state disable flags, so the CPU ends up entering the disabled state 0.
> 
> To address this, ensure that constraint_idx is at least equal to the index
> of the first enabled idle state (idx0), so that the candidate state is
> never capped to a disabled one.
> 
> Fixes: c410a9a142f1 ("cpuidle: teo: Change the main idle state selection logic")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> v1 -> v2:
>     - Instead of falling back to idx0 after the candidate index has been
>       capped to a disabled state, ensure that constraint_idx is at least
>       equal to idx0 before the capping check (suggested by Rafael J. Wysocki).
> 
>  drivers/cpuidle/governors/teo.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index ac43b9b013b3..906f4f89e365 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -426,6 +426,17 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		}
>  	}
>  
> +	/*
> +	 * If the latency constraint does not allow any of the enabled idle
> +	 * states to be used, the candidate state index will be capped to 0
> +	 * by the check below, but state 0 may be disabled.  To prevent the
> +	 * selection of a disabled state in that case, ensure that
> +	 * constraint_idx is at least equal to the index of the first
> +	 * enabled idle state.
> +	 */
> +	if (constraint_idx < idx0)
> +		constraint_idx = idx0;
> +
>  	/*
>  	 * If there is a latency constraint, it may be necessary to select an
>  	 * idle state shallower than the current candidate one.

