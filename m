Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E1EED8;
	Sat, 24 Jan 2026 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219437; cv=none; b=HofX+1QVE67mmvX8AC9BU32rL7NVCWR/Geo3k1YIV/WDtLJQ/HWDwjrTd1iAdDjJkpYJkWfoWHR05Ddcsity8KQc2zeKiPIZusGoVue/GunI7TYGg9MbNuBBH1ugd3CmevePA49l6h6lWQRD59ENmdu4ZTj8TsvXTS8MT8p8qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219437; c=relaxed/simple;
	bh=eozKruL9fbsG0p3yVy8ta33PYEA/bftuPUZejDK+DGM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qeoEDuD6agDon/9B9u3C8nuT852WmIUcSu2L7EJsb1+wEPXzTahGF+OA1Z2YBppIchlV+amG30i/CRZBjKWoZiJsU61oshvHIKTSQxaRl/pUdOa5cYzG7tHWvy8xU8NNlEXdX2PnqwouOggIZfcsndV1Fe4sF69FO0v+qJ380nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu7G809R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu7G809R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C53EC4CEF1;
	Sat, 24 Jan 2026 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769219436;
	bh=eozKruL9fbsG0p3yVy8ta33PYEA/bftuPUZejDK+DGM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iu7G809RMoOyMsfpbw3eYEl75cGLsL2sxaMS0BgGTOys+3eEGjt5MrCDe++sivDdG
	 q9UfiJ9ld63RA98FEngzaiIQAjRCfJW09T+mMjHtDON2AHF+SQeuKDJy3KPXJmvdqU
	 CcGJvbqcWnzUnYlKtS6vOfdqwFYr1iQhEMFMym9Z8+BVNL833D+rSz/ovrDIY89nci
	 z4uIE+tf2VCUiZtbYcLVOBwQrCms7/2emeuGniAAdydhLzx98m+K6p8Bt83NbSwsr2
	 67cPn3OCFqFkiShC8e8qENK9z1U+v7mOBVYGttkjF6MuJqoDQipz6/T9KPu52V5kJ3
	 MVZTtseKSsoRw==
Content-Type: multipart/mixed; boundary="===============9131490889446742245=="
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f904e57ca365036b12263b0d0a06b915e6090631df159d17f4e8a9651c1f5ff@mail.kernel.org>
In-Reply-To: <20260124012133.2451708-4-wusamuel@google.com>
References: <20260124012133.2451708-4-wusamuel@google.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for wakeup_sources
From: bot+bpf-ci@kernel.org
To: wusamuel@google.com,rafael@kernel.org,lenb@kernel.org,pavel@kernel.org,gregkh@linuxfoundation.org,dakr@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: wusamuel@google.com,kernel-team@android.com,linux-kernel@vger.kernel.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 24 Jan 2026 01:50:36 +0000 (UTC)

--===============9131490889446742245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
> new file mode 100644
> index 000000000000..c8a38717e284
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c

[ ... ]

> +static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *iter_fd,
> +			      FILE **iter_file)
> +{
> +	*iter_fd = bpf_iter_create(
> +			bpf_link__fd(skel->links.wakeup_source_collector));
> +	if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
> +		return -1;
> +
> +	*iter_file = fdopen(*iter_fd, "r");
> +	if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
> +		return -1;
> +
> +	return 0;
> +}

If bpf_iter_create() fails above, get_ws_iter_stream() returns -1 without
writing to *iter_file.

> +static void subtest_ws_iter_check_active_count(struct wakeup_source_iter *skel)
> +{

[ ... ]

> +	char *line = NULL;
> +	bool found_ws = false;
> +	FILE *iter_file = NULL;
> +	int iter_fd = -1;

This function correctly initializes iter_file and iter_fd before calling
get_ws_iter_stream().

[ ... ]

> +}
> +
> +static void subtest_ws_iter_check_sleep_times(struct wakeup_source_iter *skel)
> +{
> +	bool found_test_ws = false;
> +	struct WakeupSourceInfo ws_info;
> +	char *line = NULL;
> +	FILE *iter_file;
> +	int iter_fd;

In contrast to subtest_ws_iter_check_active_count(), iter_file and iter_fd
are not initialized here.

> +
> +	if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
> +		goto cleanup;

[ ... ]

> +cleanup:
> +	if (iter_file)
> +		fclose(iter_file);
> +	else if (iter_fd >= 0)
> +		close(iter_fd);
> +}

If get_ws_iter_stream() fails at bpf_iter_create(), can this access
uninitialized iter_file and iter_fd? The cleanup code would then evaluate
garbage values, potentially calling fclose() with an invalid pointer.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21306880863

--===============9131490889446742245==--
