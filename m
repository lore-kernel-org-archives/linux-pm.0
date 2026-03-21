Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0444317171
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115548; cv=pass; b=jUdDVe34kg7PC+OUhE+SVJR7+F9z3MB1lnH+Dq2pojW7sv42q/5CCgC70bPRMav2LqYg6Cej8cUJmGwSQJ84tp9eol3xYKJEyvsWWnLRbDkuUgcEDcI3AO6QyjiTVTO/ayBiZAetpRagWsagrlLxnayNm7wDTvwJgzX7/GB3LyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115548; c=relaxed/simple;
	bh=xOtivuzC1u7qs0tccX4nAuXpb2S4sLdDIsBXc16+/kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcVYLVD3PQ1Reyl3VGRiNdlD0bDUslOry4wuRPT5jdlrDE9ydrS8B1y8bd+UlP/ErvVh3JBq5y1h6LEcOACgYI7zZrn50d3Cxs1dbe9MST4DAErsrXzOqFdeTy3TdOaDdh/Vi0MD9j0wy5cT1ldhsS8RMpdmkfi28FRKVe+BPV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdKFXyc3; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdKFXyc3"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48704db565eso4834095e9.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 10:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774115545; cv=none;
        d=google.com; s=arc-20240605;
        b=aeHqWy7Wu5erB8Abz5twz54sO29t/wXC1F9e9H4zqOo8qafjRvPAszOcOo5y5PP5HQ
         +fFO45Rp9gu107etf4b5znVV7FgM//E8mVRVhc0TiG/lfcLY9J6tfCwEHgw2oeSNYfQ7
         CrWnLOWOIr4k5eyJLlvA6r9/vYqckF1IAXCMvkd7QZ3DsYzy69O6rzCZvxOi61qkSVhu
         6KTIoQWAMXkx3vDjH3CaTg+f2lBI62iVBrDdAZeC6agmo4/0vlGS2nG5KV2rbE4YLkZ0
         MGu7jT5e3iu9UryrNbDQ8YgV2wOueAXV+OM6osa3GpzK7BkHC0tb29QZJ865jOvSKETN
         DKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        fh=E0OfqaWWarREJ4mJrcBoVWXpErnBZC63D+9L1Z0mOLI=;
        b=YnxQ+h4cdumK7Ac1VC21lS6v/zNiceQjPEsZES3RKD0RVi5t9vb8vjoSgO7Z0vc0O4
         VfFNRQbQWvPYdL66t92XDsYEssWeStR8CQNLG5cl/pMuBdnIRIdr3OZYQEsdoyiHhjD9
         JHxAqjO72SEKrSEnnxicQcQ07Doo7tXoW1A7rO4eeF/a/Pi6Fd0DFCrv62j8OsGu/yG7
         kp8UIu0FiLt8KPHvU9H32Pgie+4UrQUOz37TzJPSxxVV4BHQ12djgoNcBrC4e3HQvnnt
         rkARUsvefGx9gwTxXX53anribbfi9gSprBn9Q+601AKih6ODJI5Nw1XErwGOyEl3vt1z
         3Vyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774115545; x=1774720345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        b=SdKFXyc3QQYFe6tSK8qFbcrZuwUxPRnpmaYHH7aTvJ5wHCa2UoUM77uvUPHMNjlw6o
         02W4ju7nV+RwIMmVqUE/AFYnYSiJKjmMdfMuURdV9SEg/Vjm6dkNgTL4bb02uzB8BNzC
         LcNS/mkYH9eBIOrFMmp4V1R7y61yn+jgwkdnoPZ6761nd0PBAxk0/W35tNsuuVOCFnxZ
         e/mJtkeFvS/XpR12SrGSAHxynIgxuDErASbtOqzzFRAk/dV8ZfAwPxiTvp3wzx0/zWTT
         pyuQQnkYJ/9Cb0iyEd6hh2NLQuTQtZxR4FlF6bKWADI1Vleo8RstJCt3OvTLuQgrMgla
         c7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115545; x=1774720345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        b=g48EidDnDiBxkpUCEzcoYdLtww+l0BQfc7MSSRVdv7PRuErGCPW2p3dA++ym9AmIyg
         e1wWXwp/KuNT0a6Fayykp+OEJF4bTa+bsFHGvYRhd8z1tHvkBQTAgmDisAhQQxP9tox7
         5OmcwmuADHN1W4ehUYaiI10vpqGca7xHp8xcXpfJTuPLOT8jenRp0OOI7S2Eac3DZKtP
         4NfhMrI7+zQ4pfeZMOxN9JTFcYWNicssSiEwCXNxw0GG4mRT/MjZ9/abBwczoLdZMMDv
         AeaTcWgAK8oAq6ITO45a0fpVZS91u/1UHr/k4Dfcl53v+SDIbHsXcXIMEuybho3tjvyC
         2biA==
X-Forwarded-Encrypted: i=1; AJvYcCX2XEjHLMw3xeMU63dQeMCysLWX2rHOG6YaGVTzI/w29rtUZJ59zyr176YUlupvWbFNYgZLDYc/mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsetDF9SDfxvUWqaaUxioo/YfQLNI0aZH4JW5MR6aj/Jwyc5A
	CSzuuIst7KRk0HaMDrpuIskrhi44dPD3f1w+zu+n5aCkg3IhMJR9L/SPDtgvMKmxuJDvvZm7ly+
	GCaR4mMRg+xZLYFlfL9Yds+7nLxCWX4w=
X-Gm-Gg: ATEYQzyDSvtIxvRrgG+l6WkH2ORWyFEeguJ1LtEWlhBIZxz/toQ58uSKCnntb0oo/bh
	THLQ1nwbuV6YgQbg2kbCCPSSau8wn7Up3quDha3Mn54kyR9LngmmLGt8x/rykChGCjcpSm/OvPT
	5w0H372yJEKmJhTwkCJWo3PQYaZwm44JIOVkYO47BxReYRZEVkI/OlHuzW+LvERcp8tShGgh7SV
	AFh1wDEvl71shgbLzd9/XFdIdibtJ3EgXQzY55ZrIoV+YgMz6bvSm9QxhPDzmfTLc7PRlv4iKTX
	ZN4THUCT1or8tSU8knZED8JitY1LMK9HaXFDTIvkKDWCVMf3cqokxQ2epUU=
X-Received: by 2002:a05:600c:8483:b0:485:531d:28b9 with SMTP id
 5b1f17b1804b1-486fedc0070mr99667325e9.14.1774115544902; Sat, 21 Mar 2026
 10:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com>
In-Reply-To: <20260320160055.4114055-1-wusamuel@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 18:51:48 +0100
X-Gm-Features: AaiRm53hX-S7iTWxzgANdr9Lu-L4x_TBCFGlJa3VypmZ-mBcKZAol4lCVpxhFIo
Message-ID: <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	bpf@vger.kernel.org, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 17:01, Samuel Wu <wusamuel@google.com> wrote:
>
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
> On the memory side, between kernfs, dentry, and kmalloc, each wakeup source
> removed from sysfs saves at least 10kB.
>
> The initial attempts for BPF traversal of wakeup_sources was with BPF
> iterators [1]. However, BPF already allows for traversing of a simple list
> with bpf_for(), and this current patchset has the added benefit of being
> ~2-3x more performant than BPF iterators.

See, it ended up being faster ;-).

That said, I didn't understand why you dropped the test. We still need
unit tests that ensure the verifier causes the bpf_ws_lock to be
released before exit, and an example program (like the one you
benchmarked with) to demonstrate usage. Both are mandatory. See
various *_fail.c files in progs/ and RUN_TESTS() macro for running
negative tests easily. I doubt we will have any wakeup_sources in the
CI environment, but the example has value nonetheless.

pw-bot: cr

>
> [1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/
>
> Samuel Wu (2):
>   PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
>   PM: Add config flag to gate sysfs wakeup_sources
>
>  drivers/base/power/Makefile |  3 +-
>  drivers/base/power/power.h  | 14 +++++++++
>  drivers/base/power/wakeup.c | 63 +++++++++++++++++++++++++++++++++++--
>  kernel/power/Kconfig        | 13 ++++++++
>  4 files changed, 90 insertions(+), 3 deletions(-)
>
> --
> 2.53.0.959.g497ff81fa9-goog
>
