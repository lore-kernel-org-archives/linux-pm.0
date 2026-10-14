Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0421395AF8
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996274; cv=pass; b=XpROQ8z6TkYPCAn0GsutYkgjTwpOE2CpX5aAvWV7zOjD30EwEaWj1GESnjRyRQdiCj7JoSh7fz1/u6j6QGQee0JjTw8+l9+UEjRZZSVhkMczHuBuJdCpQFt1E85ruWXx9BsE7wxkSAmbV3bu/YB4SI1M77siZKImrEpG5hYKd9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996274; c=relaxed/simple;
	bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDomy56JEj/XYTvkoab6gapc5MTyaHl2+H8UD3EJi86JVzxmOxNMAUYGAqrBlhaj30CNaDYcwv2RTJXSJE0j/11xITf9XmsZsVBOMZF1hmkMXXe2gK+rBg7mZFjGrFZ5uOnb0ZICl+iJIdITfWrG8xtxYaLB3vwPEmisJSk0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5LMeCX; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5LMeCX"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33e623bd651so514489eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996272; cv=none;
        d=google.com; s=arc-20260327;
        b=MkqLuEuTouvnvHflgEI12Er8EEreimv8H9ComZlBi60zZF2ejEzLhBYzpo42QAxyvF
         kLxnkn806Nc/X9DuhpZa2GLCG2r6AGP72C417OxvhtdfWmq8zmmy+2tKjZNMgk1g4bUa
         h7DhIQfkaR/VDULOq83Q9Iht0roKHSnqHUTV908DnoJgBmRjgXenuDWnRbrlNHiFlIb5
         /06PvevGPBiOLK1kxod0c7/V65DQMqYmK1d9824kj2kSMe4/p6jAJzB8AvU5zUAr8VnW
         cZ0+FxklXZfJ9mt80XyZ6KgOk2Chdh+T4VGUihXPuH0YW6UvNIaRJoZidnLH2h4N5jx9
         Om7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        fh=SvmMwIR36Bacer24eTql1AvoEWHs25a39kmCf0t+e/g=;
        b=E70QLWyx9GSs6hfps0NtCtxbjWIKip4sQuTr+YddLNhWkkFeVVIv2N0SrCoUSexqEI
         ZwTO7ICDfy7rR0Rl1j4FhbgCb4DHkqDhRqksq66jvLo7+O9uwW2fJM6nBHyFuvynmepz
         z5OJXIaf57/3t7uhT9U72wDU9/olwjDsJssjrLtcb+rAu0Ic+9q9RXclZ4vW7rF4llwb
         6tkVcbEGwEzQ0rQpGYCymQS2whVjnevkIWLMG8efC8H8P+4BZh4OFiXJuVFEbea5xjQ4
         7qKpYI4kXcUPA8xIRqhkXqWL7x658Bx+tRSvcRpjLshtet8GZmBwK3wcGVHuvhP6iApM
         PgMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791996272; x=1792601072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=dG5LMeCXSiSbpubk/BTMkvWJ2dvIK7jFfkGhSVKuiPvEccVQI9eRP/pY4aiG8kSDk8
         sybScDEKYa9pUjoob3fVfnbNdFtdkBXsSjpfjP+bPyBK5Chd00x6HJJ7X+HteLAY7JfU
         o4429zXiiE7e1UOccLBxgzcZh+G/nI2B8bjb9YKWi7iAEGL16Iblz9B6MpdkbUl3G+Fk
         3lPFokI++jDRZ0Cwvj1/64bOOygK5BR8VGYFxRHD7siF53FrkARVocKqUOcShcj0hkn2
         gYiKlI7ykCQvFk94TVoBL/XLbOsKN6gefpMbeBOS/eufSnZP21bV5ckiClL1WUdGnm6v
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996272; x=1792601072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG5fR4/c9rTkKwB+dH11HXxHn5DhiwcqDirk4k17QlI=;
        b=GIXZ+3hZwcRZTcZHdmhEhHuECqFbnvBbYWofKHQ5HtRNs0kqhPkLA9a8GKLeXaFUZ7
         TMNMmBY5gZG6LqxUnEll3Q0skgMwrveNs9LjSIkH2ScDrjp8r1Ns1/7P6yvECwjRWWwt
         MNpsolG03sEp3S7n5kj/cPpqw7PJfUFcmoL+IlDjqcZLOA/Uwpfw2gh/IS7b6dWin1ag
         Ip+XTcyX7f0CbW8TN0ThV++L05zVfg5+CGEu8wQ6y+AA+PBFMNv5+HoZsykraEs5fGAs
         Lh9meXPPjgcGrjHf4ReYB4QMnr4vBNPy5q6x0T3gOM7JZZtX3X2aM2twBQ7ZW2ZpkT/w
         JvOw==
X-Forwarded-Encrypted: i=1; AKwUvByokEl7RHYQ8e7Y56alBXqWa4HaHr8EaUB8SgX2Pmb9dQJ6rW5XueLAaqMBqZlqb9Xau7ffyBVksg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwBJyUMyyxsDeVbNHCnHQqPHDYrElxgp48XJtCEe4DjV/pOZCH
	btvVnNyns8kPoDb/IY/uOrg8WNMbujNOXPjpkmsYOus4m42WZ2LjEjHx5e9EJpRl9UPd1eU5AFM
	taGlYKnOCioni6iYhU1ujZ3LJQXnGeng=
X-Gm-Gg: AYBFou0hVaJXU35+JGT/eSzyek1xAaGfhfLRlisK9UCSNrqwhmfzdzLeCczhgF65PIg
	vk9jtTsrG61HMla1DiBnGjFUuVhOfRFozMVfIG0AJ3MV9GOrp2qfEapumVOlGUkrNJxZu1JOHw0
	E4gNlnEmInhwBrA93sLYNp26pTY1ZxmhjBoNClVaQ4V+dLmwmtYmq7hJaiO1Vbhe7eATSXlxf+J
	o46ZytIusR96XZNQTqranikxpyftqCRQb6vPFFGCKBE5Glj04HVUbSl8FnLcH2AY1BCzd5bmQlI
	Rd1SaP2a/QetbJrhaGOp2gw1UecXGGcHmAvOp5W24tfKoVyvEj6Hj2WYX4UsDR0VzNgM32mX+s5
	JiCnFlLtFhfQGwAC84JLb3tcmeEULcG1SqzpvulxObrCZa1qhOY5MlLFNDz/jmXFuRFq4qeDBVo
	TdCKYzoXNrJsmEqJ5ruMUwQYvm3FHqONQxfyKblcJ+chp9VcVDqcM=
X-Received: by 2002:a05:7301:5413:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-358c9f3b260mr28158500eec.1.1791996271702; Wed, 14 Oct 2026
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 18:44:18 +0200
X-Gm-Features: AclHuK_d31yoge0njHjovdIQh7JfJY6W-PLjzMLBq14NjY-schAqigzEJUAQwG8
Message-ID: <CANiq72=4WQ1B1oCSW=69u_Z=FFLE56hYCqDwWr+poQdzSTS31A@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Rogers <irogers@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

Of course, please feel free to pick it up (with the small tweak I
requested) if you have a user.

And if you don't pick the user, I could still pick the first patch up
through the compiler attributes tree if you and other folks want to
use it after -rc1.

Greg: adding the attribute itself should be safe and would unblock
others that may want to "protect" themselves, without having to wait
for every potential user to get fixed (but of course I agree they
should get fixed -- we should not forget about them, if that is your
concern).

Cheers,
Miguel
