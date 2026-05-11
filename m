Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6B41C2FD;
	Mon, 11 May 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524064; cv=none; b=cNKraIhnUdTMMSe0Mzwj78aC9cbX9EX5pYrazcJlFngXsoQuG2V6os60Ik/ykEJgqChwc0USBt//TCsU0lOT9xuWK/2icph0iPJkKG5c7a/fhWeniU83/gfr6m1tBdVkdJ24kTAwXYYcyJOQfdFGFFBEAtE9m9x9IBle8+e8MQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524064; c=relaxed/simple;
	bh=1VhyYWMXf1MdI0oDMS6rROfcRY/h/JSnJfdAOswvOjg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ixzn/NFAVG1xLx0FxbV8yPagqvHebV1VhPS0gRWr/p4mRpdpj59e2/qruKpgrRK6ZvrpQu5+2YnUrJ4pKV/Ofn76RRQbR1JQb48plLcMsajYdHp4+wpJ/5L5LQo2Ya0o4yyiL9E8n+JF1LMsgBKGcPXYUX1fvu3uhnESbtKskyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoDqseLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoDqseLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375AEC2BCB0;
	Mon, 11 May 2026 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778524064;
	bh=1VhyYWMXf1MdI0oDMS6rROfcRY/h/JSnJfdAOswvOjg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BoDqseLl1sVgxrAY0GgPQaOKqgpv8ge5/hzVSlGv1uE9W8p2O4ZbbZjcvc2O5oRtb
	 TnGF+HTHh+CV+aMO1huEuOKigQC5/2Kn104Be/d2PAUVJaN4ctnYZNhiReaOI9KZgk
	 RowBnMGVLXTJavIFHtM1qDDo3XKySjD0eEwlLps5fNCB2veLaYnCg4Aymi60NTLzr9
	 RmZtiKLi4+76esX1Suj8BZCin+9o6q8jQbB4bHy0fKrtbddYNWZQaNGXLrZWQ0zhNf
	 F0kg6Oidj8DYSPEqyOdbttamtb7VU5M5oabouciUdy3sc4fiaZ/cpzSAiLnUjuywjc
	 EaJ82Qtjewvow==
Content-Type: multipart/mixed; boundary="===============2895428846348820657=="
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ca6f748be9913a2ced3e9f821153bfa914c206e089626e37e32d7d27c83be09@mail.kernel.org>
In-Reply-To: <20260511174559.659782-2-wusamuel@google.com>
References: <20260511174559.659782-2-wusamuel@google.com>
Subject: Re: [PATCH v4 1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,rafael@kernel.org,pavel@kernel.org,lenb@kernel.org,gregkh@linuxfoundation.org,dakr@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-pm@vger.kernel.org,driver-core@lists.linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 18:27:42 +0000 (UTC)

--===============2895428846348820657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..8823aceeac8b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h

[ ... ]

> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index b8e48a023bf0..80b497de2deb 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c

[ ... ]

> @@ -1168,11 +1168,78 @@ static const struct file_operations wakeup_sources_stats_fops = {
>  	.release = seq_release_private,
>  };
>
> +#ifdef CONFIG_BPF_SYSCALL
> +#include <linux/btf.h>
> +
> +__bpf_kfunc_start_defs();

[ ... ]

> +/**
> + * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
> + *
> + * Return: The head of the wakeup sources list.
> + */
> +__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
> +{
> +	return &wakeup_sources;
> +}

What stops a BPF program from using bpf_wakeup_sources_get_head() to get
the wakeup_sources pointer and iterating this list without taking the SRCU
lock?

The current API design requires BPF programs to manually call the lock/unlock
functions, but there's no enforcement that they must do so before accessing
the list. A program could call bpf_wakeup_sources_get_head() and directly
iterate the list without proper SRCU protection, which could lead to race
conditions or crashes.

An open-coded iterator would solve this by internalizing the lock:

  Iterator new() acquires SRCU lock
  Iterator next() returns next wakeup_source
  Iterator destroy() releases SRCU lock

This design pattern ensures that the list can never be traversed without
proper locking. Puranjay Mohan raised this concern in v2, but it was not
addressed in v3 or v4.

Reference: https://lore.kernel.org/all/m2y0jeg5sg.fsf@kernel.org/

> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(wakeup_source_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
> +BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)

Should bpf_wakeup_sources_read_lock have the KF_RET_NULL flag?

The function returns an SRCU index cast to a pointer (incremented by 1).
If wakeup_sources_read_lock() were to fail, the result would need to be
checked for null. Without KF_RET_NULL, the BPF verifier won't require
null checks on the returned pointer.

Looking at bpf_wakeup_sources_read_lock():

__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
{
    return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
}

If the underlying wakeup_sources_read_lock() could return a value that,
when incremented, equals zero, or if there's any error path, BPF programs
would need to check for NULL before using the lock pointer.

Puranjay Mohan raised this in v2, but it was not addressed in v3 or v4.

Reference: https://lore.kernel.org/all/m2y0jeg5sg.fsf@kernel.org/

> +BTF_ID_FLAGS(func, bpf_wakeup_sources_get_head)
> +BTF_KFUNCS_END(wakeup_source_kfunc_ids)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25688185901
--===============2895428846348820657==--
