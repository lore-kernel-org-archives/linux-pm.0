Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196610;
	b=oOLM/Z00Bw/v/3uZ2W7RyLS8ss/O3GqMYinNZU3oCm6H0P09SbFAsL7z0qSJaYpL+SCi
	 BfBzJIgfp7RxYlVWqByD0eWceW9hTz8OipyHdWWU/+j2YTWRUAM7Br/E/e/j9rtB6NT3v
	 QtY7tKZJQa1BiIB4EJfjuIkC9F9bW0jaBSKWS98IQN4fojIm/mEQfFbe5XR4TUDLZDCCi
	 g2utttQOJsww+sUK+OK7fQGP9MUvZrIe1Rl24SlNHxMrHyUpeD2UezfVjmH+qEv8w4Rfp
	 EhLiR85ASDOI3PHlnw1aj1F4ThOvXC6B6A+ngTybxX7QWD9taTss228iGNNbwafQbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196610;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lgTaAi4dtYVsiHebSL4/05iwTJaTp7a5EN84CAsUBiA=;
	b=No69u5M6IoZ/6IFLdl6mYFa2qbhPmeII9Er8czo3bJU+JlncTqYiszGaajyRqLFP4xez
	 egbgi7zFhOpAyF2TiLWNr066F1iCLOSg1Q6bw/aWw1QJkTja4lqMLMWve9Y11zKVE17c7
	 Aq461ch1xJ8glAtA6aB4cTL6jNfqe/2XJa7MPL6sAM93h93Jf9QU7m4swzjcrWXT+dY1t
	 ABHl6M0K7R+mdqkGPD4uFVmc88r4PRvta/vZhslV8cSw/z3HtM8a7M1rb4UB/5+zmz4Ii
	 dbVc9gJ/nMe1re98vaN/2DWnMeT88Na9QFLeJLGZbWg02L47qaaru39pmVlBxOi191g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooWYIkIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D4606A333
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooWYIkIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBA91F000D2
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196609;
	bh=lgTaAi4dtYVsiHebSL4/05iwTJaTp7a5EN84CAsUBiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ooWYIkIR3Te36Z456tZG71Gc9vOxO/97WMHlsjHRXVCoWcxtlMWBxjp1j8ZY43o3O
	 XTvfLj+vSxHzplxPwFUkIdGsDCfSZOn7LoYdKFNySgB0cLexM5oG2AiFBN1J1tcTis
	 PmMUaglseXM749zL+CzWnVl5BRWWcP0pBEcbVRSOT5mKplQUbKm/tb2/Ly5gH0zsFV
	 z3KalL6gdyXMaIc1jvGu31FgQXckwRwslIfpcxp75nbqjQf5j7C8nRT4fJls0CTWf8
	 dgTyM6TwIWXu9B74ludypeKgwUeUCPCpnaLRHrQ+crt4Ph2/fmHmMBRottzqi5JuB3
	 p4qnXAtvFa7Sg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c1a3374400so890054e87.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:43:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE+VWX+BpzoOsPIhCtEv9amO2V0kPxGmBe4AYdNwRitDSa2Ymio/41wGjsWs2Dw7e6cjnGbdelVEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8JfztvEAcM5lzDe8oaEfNjOPBJUVBXarAFktxj4SlS6ZEPRPoG
	tvAxLnuEE21HyS3jg9rbcHnZXUdRUGi7ZGSIAF1Pv5DlbiGyFy3+0qv/gl835HH/y4iTcHL8P3c
	LRxlLvmanu370f2kqonJ/D4hcP0ffhgw=
X-Received: by 2002:a05:6512:2342:b0:5bf:f39f:cfc1 with SMTP id
 2adb3069b0e04-5c1bc800ad8mr1160498e87.31.1795196608109; Fri, 20 Nov 2026
 09:43:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116034619.36218-1-xiongxin@kylinos.cn>
In-Reply-To: <20261116034619.36218-1-xiongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:43:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0isU4bT14fUTXDhAb13G8pwoJvW+b5dqXzxCs+bT=1J_w@mail.gmail.com>
X-Gm-Features: Aa3M54qScF5JLG2T6_O11bFxZzF4WTe7PhuPZq7_HV45-TLpTUBNXRP08WqoYDM
Message-ID: <CAJZ5v0isU4bT14fUTXDhAb13G8pwoJvW+b5dqXzxCs+bT=1J_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] PM: hibernate: flush icache for restored pages
 from task context
To: Xiong Xin <xiongxin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, james.morse@arm.com, 
	hch@lst.de, will.deacon@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 4:46=E2=80=AFAM Xiong Xin <xiongxin@kylinos.cn> wro=
te:
>
> Hello,
>
> With `hibernate=3Dnocompress`, load_image() submits the read bios
> asynchronously and hib_end_io() completes them from hardirq/softirq
> context.  The flush_icache_range() call there, added by the
> commit f6cf0545ec69 ("PM / Hibernate: Call flush_icache_range() on pages
> restored in-place"), ends with kick_all_cpus_sync() on ARM64 and so
> triggers the WARN_ON_ONCE(!in_task()) in smp_call_function().
>
> This series fixes it by keeping the flush in task context, and first
> closes three pre-existing holes in the restore error paths that the
> rework would otherwise trip over.
>
> Patch 1 resets clean_pages_on_read when load_image() finishes, so that
> a failed nocompress resume can no longer leak the flag into a later
> compressed resume, where it made hib_end_io() call flush_icache_range()
> from interrupt context for the reused ring pages of
> load_compressed_image().  The flag is also cleared as soon as the load
> is known to have failed, so that the bios still in flight do not flush
> from interrupt context during the final drain.
>
> Patch 2 stops snapshot_write_next() from releasing all snapshot pages
> in place when one of its internal allocations fails: the read bios do
> not take page references, so freed pages could be handed out again
> while the device is still writing the image data into them.  The image
> is now released by the outer error paths, after swsusp_read() has
> drained the batch.
>
> Patch 3 makes the error exits of load_compressed_image() wait for the
> read bios that may still be in flight before the ring pages are freed,
> like save_compressed_image() and load_image() already do.
>
> Patch 4 defers the flush on the nocompress path: hib_end_io() now only
> records the restored page on a per-batch list, and load_image() flushes
> the pages once hib_wait_io() has returned, preserving the asynchronous
> batched I/O.
>
> Patches 1 to 3 are unchanged since v3.  Patch 4 now yields with
> cond_resched() in its flush loop, as the final drain may walk a
> multi-gigabyte image in one go.  Many thanks to sashiko for the
> reviews of v2 and v3.
>
> Xiong Xin (4):
>   PM: hibernate: reset clean_pages_on_read after load_image()
>   PM: hibernate: do not free the image in place while restore I/O is in
>     flight
>   PM: hibernate: drain pending reads in compressed image load errors
>   PM: hibernate: flush icache for restored pages from task context
>
>  kernel/power/snapshot.c |  9 ++-----
>  kernel/power/swap.c     | 57 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 14 deletions(-)
>
> --

Applied as 7.5 material except for patch [3/4] that is equivalent to
already existing commit 931650685e35 ("PM: hibernate: Wait for
in-flight reads before freeing the read-ahead ring")

Thanks!
