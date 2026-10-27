Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793120966;
	b=IEMmfVykOX1pXPoyk03X9VzT0bLZtdosLDwaon/8BhaSvBcwCVXSYoDqwdaFyTJblAwb
	 bGUnCS3a+xa2JHSq7a1vKxUO+93ISc8yJe7PXNwphcf10kcr1vcW9Ddi78toPO6uuS4oA
	 B0UFHFkO/UC5+gAtUjm1kMM7njpOPFerOMOeEqo8U6W8FxjsnOLr1VbQlvFvi1euSeNa5
	 ZqClsh96msu2rGxBRqdjgv4hOSD+Aj/ikZPEwDhqHK48/VRc0u4x3wAypI7t/LBmZNMGp
	 MgAfDmXW7rOdcZXJuv/U7mrsKx8aK2tF2w9cNAdu388vnAs03RTlrIpro+xnmw4DwPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=te7+uZN2QkD8nk5NHPCvRLXnUD64mzCV6/WajInfo8k=;
	b=BiGePMM3i0bJbBSrqkce/5DEIvHN1hl2f+fWrOEkQ4sdoFMSSjVLX8eYvFeZP5hkR9kW
	 Me6vvsEzWCoFfOfFscJlTsLKO14FOecvIHHIYvZY4xhdN7+Df2/52rFQlXev51aJf7UmF
	 l/dH16QEdkTwwNdiai0wdxRgxKZ7VYk1FITc4aW+ogWgPgUoZHnyO05BWnEKzCZVI6hVj
	 VPpfVEeYMuHuekmH3U7mxvmaznpEnbZMvJEkR+lizKYL0dXE00Q7jEqy3ONVYbGqsPvTo
	 +ch8+ugWDBmygGwtJ5Z9vG26OeZLVqEQlgStNGCOgrsuDKjY3XRjrwNwH7FtH0K1i5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqoKYkhP;
	arc=fail smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF450606A31B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 17:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF450606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MqoKYkhP
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a1865cfdcso6422eec.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 10:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793120965; cv=none;
        d=google.com; s=arc-20260327;
        b=LqooVEp2M2MuVtxuNxiAwRM9Bt0JVmGa6gqQ8daS+ZEYhh0blg1q+o7YJomrbtDCkv
         WR4zuBgBFySx7JC2EMns9U9bmwtnLm2MDClP2LhMRXTJ7m5Meba1HG8tNeBJMskYQKBs
         xfp1A4nZDOQyoDVQZSdMzL44obFNgE66U3HkNXY8VlFZsV0Hc1ua58q0uYpIbOf9hTxR
         ev1FUPUf+amPQ9DYrxneiBTSOTwMj76le2qOD/kn5t4PIbVmvIWQLr3/2dcBme5HNHu+
         WqDlr00sxODhm7LG2FJjifaZ5QfgfPVTyumVNEYJoZYAmUdepEtKhTLE3c16bPUXNgP9
         VUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=te7+uZN2QkD8nk5NHPCvRLXnUD64mzCV6/WajInfo8k=;
        fh=p7Xp1bz9a3PBdn+Fy3aVWMYaTWMLeN+zsmosTNBA4sY=;
        b=Zj5rO684yJmxctHrNVOsx2pf2wlkvHkr/D2CJ+/avx64jXDG82R07t9lMuKhPliAQW
         KwbMzEdhnpvxqaOAzuHtDG5NFsJR18Y9GH7DWz+V+5OGVa7euCvUgl3/fdeTTf0ZLdZP
         cwMOlA+lKKS0s3CK1CvUfj5WbJWybZqffXIYLGqo652usjlZ9grKUgYGf/glXPdMpzwW
         NyUCnqzYgkpL+uoYbCJFSaVNja26q8yn55uNTcyuTZTqlGL+9b80rF4TiCU/efI6fMe/
         cRGwaISgUftAS1Vod8oX1+AgonbCNT9Nbu3orwFK3JQyu7v3BtBPN7hL6JNXux+3IXhV
         fN3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120965; x=1793725765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=te7+uZN2QkD8nk5NHPCvRLXnUD64mzCV6/WajInfo8k=;
        b=MqoKYkhPxinnWU0rxiVQOQIW2xdnLJUYOk/ZRub1C+GHV7g3MDgeO36xzGgv7zV0pU
         b7Q5Qd4T6P4QzQDWxqMDT2E4vSB1Ta2AT4vyvV1W/SJjCa/I908j3i58wt4B7gA9owyE
         9FD0Vttj3KKr416fqs4ExXmIutqEMMvdS3FVh9CsUN01w9w2ZbUNXISwvFTGHY2NwJr8
         i/oo60Obz+7f/NV/ussWc0mzJobz4krgT1zVk8FX8wemuSyiQyuANn/afGbcNeZ1N8XD
         WWKH1SX1jfedntfB+WOQis7PzeNakgQ+G22IsTyut5xTYR0Y9WEiQfV0RFdLoac6YVHY
         D5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120965; x=1793725765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=te7+uZN2QkD8nk5NHPCvRLXnUD64mzCV6/WajInfo8k=;
        b=xshlQKMbIp1THnCtbfb29/g2VlOuEgOdrmcMzqvRi1SZ8BNAfMcoHpgQ2wAv9gHLwu
         Almn4jVGOw9LhrYSrNzMsA1BW+k40nclRtYHDBb8eEZvmhkvRQ5QL2+q18Lx3IVH+gKG
         qu6/MUnEvQrEV8QWOO+wiiATF2eQVhRymtygdxIIbK+Mw9T85WS/oekJZ5rNAojEGQUq
         6SV5gopXaQTe9AJw5QyM71Mzxsvgt2zLu/F7xhvw9Ti2pDNs/U/bXYV8ksINcQs55Opc
         AYVjuwM+9vfUmCrqZ6ZLZBZ08SufcTkLKn/AeafaMX/ef9Ctleqb64I3DhYc8Vljad8u
         iZgA==
X-Forwarded-Encrypted: i=1; AKwUvBxsHHBvQHqVSuYEcA/Xor/ThsPA+uXCRfQvRHKiXHUM2h7K0lDXZu/tyObvqfuCO4rKQ+yNEzwJzg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIN6KBQhUiZNZ75giXU4LMRFHPk5XiMCOegR46CG1bzhrKoHD8K
	t22/CyF0HaU7UUvxHvNbqL5mq7mZsIefxgsF4aKHOptub+FMrxDoc2BDNcKh2kDo4C5+0rsKCmN
	bysqJwI33kEDNX/+VhotXbY2POaP1brM=
X-Gm-Gg: AYBFou2YlsTA4ZPJFmToAHVonWyWQ7cnonlhKtrsHqoRR08T1yjDG3ytzuUStch1rzB
	kMRBSvyWAh5AThvTaeRVm7llQOBH/Cmu5kLaA6yUvPofw2W0dKIPUO0mgZSDstaapQzMV33FXVx
	Gshlc6Oh2jwojvuo0hPRfizRrIoJELB+/iMjA05UYoP9srV4lGDCfavoYK9O7sFzovzs4w5FKYq
	sZSjU9wiUMjrTO0MDNvTZ5NGpozGUTQCkurWDDocyvT8nwWhPAxoJ82FPwcU+t0f+3QE8GdenV/
	tJH40pHDhnvbSr13WjOeNYmu2r4XEf2wSyV4MRuRqqAfL1pg+wrs5gxHQlt1ju+cZHCRuGi7PZq
	Nx9RKOvvcjEZX6niy/+0WCgsb2A3AALk1RWuXjPmeV6EkGQAoiBwb+SDVMObP91fY9zDT1uuNiD
	kO++pak6JyauXDnB8J68D3xMEhPphn9593NdQM8UchXv/OPxpgJaTqlpFm7oOIX/BnFIlM5XQeS
	ZQ2YIVuzOVWPnr+kqULX6s/0S1CILRAi+2a
X-Received: by 2002:a05:693c:6392:10b0:35f:ea17:d171 with SMTP id
 5a478bee46e88-36a1ffbd5d7mr237613eec.2.1793120964600; Tue, 27 Oct 2026
 10:09:24 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018163719.81691-1-ojeda@kernel.org> <4600d9d2-9369-4d9e-afe3-b21aa5f0cb2f@oss.qualcomm.com>
 <atW5adUhMhOhjbyh@vireshk-B250M-D3H>
In-Reply-To: <atW5adUhMhOhjbyh@vireshk-B250M-D3H>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Oct 2026 18:09:11 +0100
X-Gm-Features: AclHuK_9imwtkjqF5Ms9356_ENKgDBIHYMMCKtsJ66MmiTSw1XdVs4AdT2mg6B0
Message-ID: <CANiq72m1Mn8wTCWCzRawV_OUSm5L7BH6s6gcN-gQE43jQfx5aw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: fix `undocumented_unsafe_blocks` in `PolicyCpu::from_cpu()`
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:32=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> I agree.

I think this is not in -next yet -- if it helps, I am happy to take
this into `rust-fixes` (with the two statements):

    // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
    let ptr =3D unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) };
    let ptr =3D NonNull::new(ptr).ok_or(ENODEV)?;

Cheers,
Miguel
