Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B237D133
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532296; cv=pass; b=a7PkQj7OQyuov7vW0S8kCZvnFLqiMoI4oxk4FDJprKdjSeJJH/pgr6sJL50ce9diequiT9nyuQCY4FiMyb/bD6++g9/YVMSwTuZ4Be7khQGyb0YuqB4Fc6edMGVZvCMVJabCs7zbgluOcCJsE5qEC/K0eVzEsyuGVoglONUmFEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532296; c=relaxed/simple;
	bh=Lsx7HNxS24AkVUOKYhryh8TJ0MlTzkkNg4zqi1eTIJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAmwj2CPsNPFiog9ssJEgzS9rNG4eyWi2iAs5pJINT60R/euoq2i1LtS+5DZmSh+6zhXpzB7VvUQEGgTGb7ac9T02amD4Ru1iXYo8u9dDpAH2IUUsTliZbK3pfZQIeT0OgRi5F5aCw2A35vmdJuX+NSXqoh7CaTQbFhadAz8Vf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzKQ7LAI; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzKQ7LAI"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so53359535e9.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 13:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532292; cv=none;
        d=google.com; s=arc-20240605;
        b=frc5nxLCHV8Nkj4AxLtWrAcPl7SG0TVQMRQ84iT3YgWj+yVsn7LJ2m/F4ElkuQlw8p
         aTKHt4L7gNsqpLphbRb0XYhSM/TaaNDwDzU8HLlLof9AB2j/HCrJfSlQL2ZwWrZyv2R1
         HVWi/XfsvBUAXeB0ICruiHxqTZ7kCT6xDA3W92RXffqo0THCQUYyTfduoi81k/A006XB
         seidVOuNwa+QuQINDeh6deEFkjdB9Dt3XlUg9OcFdkeA/kKERu/YzQRVs5/kUfrJZIef
         RzVJpvP+Zpnh9gBcy4JlUFyvedWLZXnEeQUevlvLmdE5c5v1XWk6xxBgKPQMec61jcrY
         Jz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        fh=p4fUjQwrsQ3OHZbKYWt/KbkbYo81dAYtAMF4oO46pXE=;
        b=lf2B1z8UNgZ2eEuzJXW8BV86FWwa89dO1WixwHOzIsTj920xKDjcJiU7z+Ms5ohSiy
         0L4raQ13OXepV5Wh6Mi5GqE7OoYHT4/smddc0qYbePE2MJ7KaMGOJ29s2SEuRPmd/MBL
         oTy3dGFG055RJgmnJAd585oEAagJwSv3H3xZYCSGKuOEF31/mN8XoUo+YqJuWiTW3WQK
         FxdA48ofxMiJ+02XULFwbgW5r4TRDTjyyVwva+UaMP0+BizEmgF1ChN1gsj7PsrEAkzD
         WjfE/JMUrl6LY7QjFDMdSJ7vQnGt/IPqaNSjh0sR3KDfese/3cKLFMKxhSIUmPTpwKvC
         Mmmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532292; x=1779137092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        b=BzKQ7LAIwJQtT0aeOWNZqHH1f+PCFAzdkmrnO2iHVUsgy+fDoAoSYkJLQZ1QuN+8aV
         9FTD2nOJjmBZgNuRqTK3zOw/q8x/FN1lKCuljNZ1blK4IdNRGvwCGTPm9D039iPQhBdH
         AkXYxkFaFN+x+V4dEwIQHUj9MpU0WraHLbXppY5p9T/UwqSWV9Rl9vOCFVI2tws3zV+r
         6weM0j8rJdUyE45Xa40aX/+evfZ+QOEWikCFYJBt6gQQ45DrW6H3Ac2gGIrICfEOc3QD
         noRTLMVBOBY3W4vodSXyfynk6OTJs59wpxk70Ng/3noQBK88RLA1q4JXQKSSqvEW6p9L
         KVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532292; x=1779137092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxXhE1E3zIMNXAZQMW7578XkRyn0VMcl/G/klUEmemo=;
        b=cjg2PSb7aONuCG8wveVPNnrMddkbq2XX+pdAEPVcDws/2oMttg14RJPS8XHRFwArXI
         VZarwgDvPW8/PC5Co/JzsSaQxsBI9SbYUbDtyo9jVx7+HN8LckrBGLZjhlyN0f7VYdEF
         rQFl/3nQ4SQ9m03ikSfIS83XZF2CbvEEMPnddSJlm1NprkvLeFTMBgmmjKTwd7AB8wxZ
         VRzEeYLjcyTr/FVxQLGIDsGbghN90WYBYOJO1qVIwkze5aUSfpLzfGstYCM+7NLMDgfm
         Nnk6mXx8JbpqYNi+zjGL+El4qxz03csHeIxr2GhyZzPUaHFnyMSny5YOVZ06SBJShGq1
         H0ug==
X-Forwarded-Encrypted: i=1; AFNElJ8uP6z0I0kaJgHoUtzoq4H6O+qNxhg0Uf/Xayk5anN1KiQRRtOqTEmnJHhIuv567BQxsph7dA51Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbazxpKVB1F+gWsc8ObX39bKxhIAeoyrMrR1iAeAVhINGuc4Ms
	W6Hd3WSdALd7QYJTAPuD3eV6ck7L9gDMID/xhkyORHWZaVE8vgBzoS6FyJoNN+F1pUvnAev05Wi
	O0LlWcStyNRvkST5FJ556i4g/Son0t44=
X-Gm-Gg: Acq92OFc132RJK2QKUKFq4+18H9JXpj2xvmYOtpZ20twMuOgz0ADbfn1FidV99UmJtQ
	KGYZkkMtaTULm7ZK71BWSzgISHUxU+3qK0LiFOKGSCiV0FFmSJUq7jpUFGzL0PRX5gM32l5RVt5
	olNtVU7o/SCPGmay2VfVzxdEg/VkNbRElBz9tVymCHx79rtqVsAGzHwHd7mE+3/uP6CkeBgAk64
	NJxqdBEY9phX9vYYRfoDndnvp5AwWGol7p7R2C8L7uKLbbP3kIDvWbVCrYar48a3K0uAzPvvO5H
	Jj9XMshvzRtjSe2zapRCBYYycebJxycFk3Ja9dQcKqF8ZcWUr1esSxpqyEOlWrTETUNas9miJZs
	xDvYUjKVxkjUkQVrQ6xWqFNFVioyFOQXajcjzy4HyqFNSTxltyAXLBHbtxQ==
X-Received: by 2002:a05:600c:34cd:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48e706f3688mr182545995e9.13.1778532291754; Mon, 11 May 2026
 13:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com>
In-Reply-To: <20260511174559.659782-1-wusamuel@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 22:44:15 +0200
X-Gm-Features: AVHnY4LE3o2vqBaZVgI10g6eDtVh6QEf9MBs5iW-S47AwW-UDvT4urkZRxmTfSI
Message-ID: <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
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
> traverse the wakeup sources list, and a kfunc to get head of wakeup
> sources list is needed to start traversing the list.
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

This looks good to me, you can add for the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>
> [...]
