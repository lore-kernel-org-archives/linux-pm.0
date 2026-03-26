Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134173F166E;
	Thu, 26 Mar 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527614; cv=none; b=LYii4tHxDS0Xf6DE10AcaJpe7cJQBKpnaLN2JQQbLuLBrAfMJnUlK2E20pjfTyencUXek0WWX/VqGk+FplKMv6LwLxnj9gw45RIlAew7iGxDJWQiZRA2HKfX/is23V03jwcuCYMMvC/CGq+cXkaLNQNUST0ClHn1HPoeB0fsi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527614; c=relaxed/simple;
	bh=e8GopF1nznycnapiDnfw1kUxZGNIkN50/ljlNsz3RCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onn9cy2mkG9x9fAMlgkh9+LhtfSzUhIlxfVWZkOKHBqRwnSrFJY0pEH5fvzVaR02/ahKjxIAGEOXYIfMQOO4DFdfMDIwfBfAbdkgz+0zHe0usaXHXDk0t9bXqYtlXPb8CakJfcD9un8JYH/gvkaxu8a9amyjYfoWAuJ+xtr+XGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp0y8D2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp0y8D2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219FEC116C6;
	Thu, 26 Mar 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527613;
	bh=e8GopF1nznycnapiDnfw1kUxZGNIkN50/ljlNsz3RCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Tp0y8D2zFHDjVsLvLR2NDCcKH9kzWtCEcFxGLwJxVQReZWmxBqzrcuDGpSreUWhil
	 wUGY13DRJxqFVmYIKwC5tL3GkNSj3aVbOLeJo8jnQOgM77WsxK3YBoz9tkhQz8Dq3A
	 s1SWzqoZIN+545vCZUseoFcYY9k7nTRz2YartMpdJAdJYOpz1Ba/VSMHFKKlw03D0r
	 ADLfJbhDUrCqmIfxHYY9HkagWOJjjub4bxuGaKRONuEcdvy5ebPgveN8cZywHztK+Y
	 DtS79zlFepVrN8cpKB64KExqXWWWH3wetd5z+yEclqym/JLdCKFooxtzlEvqnwHTHm
	 xPiaDssq1WkiA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek
 <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: memxor@gmail.com, Samuel Wu <wusamuel@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
In-Reply-To: <20260326112521.2827500-1-wusamuel@google.com>
References: <20260326112521.2827500-1-wusamuel@google.com>
Date: Thu, 26 Mar 2026 12:20:09 +0000
Message-ID: <m2v7eig4ue.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Wu <wusamuel@google.com> writes:

> This patchset adds requisite kfuncs for BPF programs to safely traverse
> wakeup_sources, and puts a config flag around the sysfs interface.
>
> Currently, a traversal of wakeup sources require going through
> /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> wakeup source also having multiple attributes. debugfs is unstable and
> insecure.
>
> Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> traverse the wakeup sources list. The head address of wakeup_sources can
> safely be resolved through BPF helper functions or variable attributes.
>
> On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> speedup (sampled 75 times in table below). For a device under load, the
> speedup is greater.
> +-------+----+----------+----------+
> |       | n  | AVG (ms) | STD (ms) |
> +-------+----+----------+----------+
> | sysfs | 75 | 44.9     | 12.6     |
> +-------+----+----------+----------+
> | BPF   | 75 | 1.3      | 0.7      |
> +-------+----+----------+----------+
>
> The initial attempts for BPF traversal of wakeup_sources was with BPF
> iterators [1]. However, BPF already allows for traversing of a simple list
> with bpf_for(), and this current patchset has the added benefit of being
> ~2-3x more performant than BPF iterators.

I left some inline comments on patch 1, but the high level concern is
that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
KF_RELEASE tracking is working against the verifier rather than with it.
Nothing actually prevents a BPF program from walking the list without
the lock, and the whole pointer encoding trick goes away if this is done
as an open-coded iterator instead.

Thanks,
Puranjay
