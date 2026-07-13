Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064A3D412C
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949247; cv=pass; b=cinQf1Pb1SFRQv6mXV/FtVjvPIAw3EYie0tIDO59ApfU8kRpVj5KDdK1fMgrsAlzZRMvI5lr7S3Q2cUvvNf5GeZYlB3YWS9QQcAqsudxQF0yblQu74B79Th2EnhFkXFDs0sW+MPNjLOK2LLblpSzF5ZTydvGcnd7aDaJwlzEFSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949247; c=relaxed/simple;
	bh=AHtIZL35S2CSzQsnSHMx9V16sDmq76sTMzmTe6ilFLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSIAMPmLr9nQd+5aOdGxbYLyk8/EzBv7v54YRRn5ikSLxvTD7jB98/wQd1K+S7Vql3hPDXWLcpzngpN1E+ekNBTnag9hyY/FyhWBObSXxiNSS0OjSf9WiSmOkq69ort0rAFXcwOe4SZK+Q3jesmkiDwMU9HIi3GIyXk+O9JUBi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqoDK21i; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqoDK21i"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10e86e52so416891cf.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 06:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783949245; cv=none;
        d=google.com; s=arc-20260327;
        b=eMnlqc3m5qoYFevbGayeY5OXIRuc580LF+mLbAPOHNC3jczfYoh5ZJt/QDoExcUGkz
         hztwoQ1hDqKKYvE5cJan694FFcKHQvQu9DAQKV8gX0a4cTfGcBnKLBDj3Q4mfW4IT3pP
         wsdxZQsd+lnAaccBajfw4PYcpH06sYEuxtrdHPFDIG+NSDgVNygF9SsqU6cWLZXyFXHr
         cUeQJWM8JlRQyHbZwWU6bGchANZvbVT1S94Pqvd9VVDLEpwG4AoztdLB9kNES6VmEk1b
         zjD5bYCtOeyBKTvON2pQkQK5RwdAKfwINO138NllXKMRFjJNuyFcNNyzsybpiNxmcYe7
         k9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5jhMoQ17PCSjgIZcv9FhXXxCL1tws/kUUFFBpxumlQ=;
        fh=lbjWQwR3se0r8LROulWVQnCHFvBzDOm/Qzf8zqxeiio=;
        b=ATcMpAM/iFsjtgdZ3DdJoNlT8OjH7AJxhsI9BlYT7JSJvysXiQpowl0JqIpwOjxs2o
         K/PT0XSKzJPWLDBb5fBjcuIN8LkXFlLxXGFlfi4plO9bWKyFzyDRNgqG8ytprl0SOX9e
         AGdRpQSlKQv/NK1nv2hjuA8oG/7ccSdyfrByQnTtjST6fYddS8rLZAT5M92suShz6p4R
         ivzTcD0EtarFMXYws9OHjv+BK8CLyl/i+dioHijvKzzjMR3RDEKTdCQp68p5/9dT1/Os
         jTIyprZXZ9eazBwMfEHZSXP3enXD352Tlcjgr5RRXxq+fdsglPehW/BqyL+JLB/vCy5K
         4qAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783949245; x=1784554045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q5jhMoQ17PCSjgIZcv9FhXXxCL1tws/kUUFFBpxumlQ=;
        b=oqoDK21iSmnrVLieElmrdZ0paPB+HbMZR6I31NIDqIPLbCRlmwGyyNCIMwHgRs0kHr
         JSI6lJEQq7z/FpIQ8LLKGgQcvbmsVp1t/hm+SswH02Wa2Gg5Q1wR6pVTXklDBo82KvyQ
         E8dEfNsi/Pg3TzidoX4zh0fVNaWm0zmdseTJoprVDjRI5SQkC8wY9eEZgr2FgIqjwsgF
         QzO+1UsUHro46w9ggyn1R4TAstMfAHsuzsfzkhqOg2wI1bvTEAoIn4Gv4qWshNbxyrut
         90dvY6TwOPlY6+Of+B1nW1TWz6fEGFFplqkdnKQi4GH+w9hH7UJ9BKWKON5BKTxJXDj3
         3sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949245; x=1784554045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5jhMoQ17PCSjgIZcv9FhXXxCL1tws/kUUFFBpxumlQ=;
        b=YoCXoctM8q4flskc7ku7ZDh0ypE3jZpP+xKRVb0MO54TpcBCQsnR5Iov8iHJikiDkS
         CKk3BiW8wh+dHgaC80e/8M7X3/6IYFXMC9HDtHSBovC0Y4RBsWXhV+NebvhPQS85jPLS
         Qc6Wjhorn8R8Wz3cYWG47tUpNiKeMQdEx8F8Maof7/e3swFxVeIhouTC1pZNf3OWF+y5
         xLnHRzxQIgCWQaPgoUUVz6chUOt/pFfVVg3bSzRN2idlQJCNgM5TWB8cwBE81oeRfkO9
         QRfPrEMbmcDkX1QoJMVcxccaAKRl9zXWvCYzO/diw5cz5Epl8c09VKmqxPymswRg4YKQ
         QHkw==
X-Forwarded-Encrypted: i=1; AHgh+RrFZlbfxEhQR9I5tvUAEM+HJZ/MRCe2v5dUN2MwEmOS9ihbs/F9xoLiJfracEg9ejE8m+qRQq6ONg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MFBiSJfIlHmNOdcP4R1CCh5rDB4rmGUOL/vSc9CZLbRwl6qo
	721I1OWjGGvPdypwUuE49B9INwlpAyL8EJkjSySEMmtbuGJnO72cmwZ7LFxPaLGzRifEtuHQLut
	cejhkr572hkm0DtLRFrC4Lk3wzATAmL59a8z+cu2u
X-Gm-Gg: AfdE7ckrpcTmOvrcPBqnTQ4v2iWy8tn1BLOdUS1f/DnFLmvELjZkfBg6JgL24DMImWT
	3oMTnIsV7TeNn1PYFDJQLs3bTAmK5DCvyYuT1fzDRSYmAZFaf679ezD84w0djN770K4fo/Kk3Q5
	4v6hvr23CSBanae9xuSxtinQBC6vXzE2Uf5UQIGlMnFDvc7iJfaUTs3gN1wxxyPsnMAg47cnofV
	Efiu1zlZxY4yHffXVQVMgp+6v7/5wNyw/nt5Le3bRJWu0xHbB5HJtQDMsArsjECba0dr9yemx7E
	7HmRgJwzBLZqKLBhgrm3Oe6e9rVEmrH8L7KpTZr7Y9HXvxxyj6Cyq/ptw1qSk4ZvaWpw99JSSFU
	Gqprll16Ie6x3BQ==
X-Received: by 2002:ac8:588f:0:b0:51c:d16:b48e with SMTP id
 d75a77b69052e-51d8373f2b1mr2466271cf.22.1783949244136; Mon, 13 Jul 2026
 06:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711145246.8625-1-malayarout91@gmail.com>
In-Reply-To: <20260711145246.8625-1-malayarout91@gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 13 Jul 2026 09:26:48 -0400
X-Gm-Features: AVVi8CeOk-7rcDeUKlSLI0EE2jL-cDUSf0E2oVGaxULyixSDSJVdlEHPLnxfVAI
Message-ID: <CADyq12wf2eyRndf5M01-SCE6a0NGOD12EBWpftLi4k2x8eOiEg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix memory leak in snapshot_write_next()
 error path
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, mrout@redhat.com, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 10:53=E2=80=AFAM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> When memory_bm_create() succeeds for copy_bm but fails for zero_bm,
> the function returns without freeing the resources allocated for
> copy_bm. This results in a memory leak that includes radix tree nodes,
> zone structures, and page lists.
>
> Fix this by calling memory_bm_free() to release copy_bm's resources
> before returning the error code when zero_bm allocation fails.
>
> Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image =
file")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>

Acked-by: Brian Geffon <bgeffon@google.com>

>
> ---
>  kernel/power/snapshot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index d933b5b2c05d..4a73927cc55b 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2797,9 +2797,10 @@ int snapshot_write_next(struct snapshot_handle *ha=
ndle)
>                         return error;
>
>                 error =3D memory_bm_create(&zero_bm, GFP_ATOMIC, PG_ANY);
> -               if (error)
> +               if (error) {
> +                       memory_bm_free(&copy_bm, PG_UNSAFE_CLEAR);
>                         return error;
> -
> +               }
>                 nr_zero_pages =3D 0;
>
>                 hibernate_restore_protection_begin();
> --
> 2.54.0
>
