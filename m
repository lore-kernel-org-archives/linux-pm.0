Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CF3FF8B1
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536852; cv=pass; b=G0kCAZ0Y3WGXhvTGLyOwRXm+jVIE0xoFrCuj6ePRscGhgZpRbnhPQzoCLRpFGNzvliDSZ7EGImiWKQhqtpS1JE8mVGiVqQKTZeUF5ipkUBTg2Qou8undQNzZMtMl2S2g09kZFPCIllSV1SAREDSGRIkWGQA9GmXROSBIzBoepKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536852; c=relaxed/simple;
	bh=SEhU+8FyrhCQphBxGSGzxRvEz/UtCwkE8r71m2dkSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy1qSY4Z4070yH0NOeBF1Xd+7+ZU6Ce1o0gGjyhxogR1JuVm2fI5nWYDWh32LtqhFHykaUtTcHXwRRWXZCxhtUAevIsq7I6Bw1EXFjvl6HtKcMFjR1+IKAfp7rD4cy8vlVIx+aM23G9qcCAoxoODeHqwoz+n6XmlBvod5maeqxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANTjrajT; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANTjrajT"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439c6fc2910so697345f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 07:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774536848; cv=none;
        d=google.com; s=arc-20240605;
        b=RMnAlmpFqcLW9eGRMSh3vFZmjRXdq6TceppQwz+pRufN6Y7UbL1KpqCwkjRSfK0SHE
         w8Iv103y0uq5RfcnXv9t4Ba10tBnmi/THW2ihXtpFRc+TaIMirHRYkvbeBhFnc4jRRsS
         0uxyc1NFKDwONtZLBKVI39TiHgxABlnYuymiIyFU0I9TLsx+JbqOy90MAVZzjMCp3pwz
         g2THHImsd3na0vlgVgQ6VyUWrtMY1Bpq/0CrSuFSBDTtkomjiG0bzlW4mqTsRsi48KOv
         zu2mUGHxdpGT1NHnB1ovogw19hhlcmIvmlf2Yw8wTqIhNg7lVOikyMSalPa3xYiXo709
         tsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        fh=ksCuI5+r8wovJ3vPdxAh5XVpe4KESfjTP3Pk23VVxfA=;
        b=OqzRxyRoplef6539t+oY20Vee4sMTLyBwk4VGKqzsohirmdFdiwehalI4v0JyMSs49
         cpdFHFoUVXLqvwhF/brd9n5vaKKFc+tDzmS9GnHaPqHAm0hCKmhzGjMrVdv2LEPrItGg
         d2W8zfLuP7rGswtnoDiZLvAsKWFC8D5BMjKFn2BTQRhyWm5fiYQuhtg9Z9Fvic/5rHni
         mdphGXKth55yEnr46aK36AZRWa7t+f1p94hROkPbm8XXzjAtYIVVRxITKR8Zux77ub0+
         nHBKEDcdtzQQQ/VbA4HtGkMIaQih3m9ACQlcWdgucjPBWv2vyvJLvx0V9owQpeHp+gjm
         coKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774536848; x=1775141648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        b=ANTjrajTdtniA0nBU8OjHqIcldHr1GCIgWI/hsvwXRB5zfqpUMWfRp3nKH+PepEetO
         olB1FaXbpRAx9YtsCcA1iVOgZvwNkX9DSlf99Ob2VeQRJObDby0uo67p0w3H/oX7tWhP
         2prIYefx1ZoLBwURQht385ZSGEOEKjHH/uUQ3WAu3IIC0t5QYe11I8RiiPGzUWJsJ9D2
         PcfzGX0qxfoICT/Td/re3agibSrwoANjQPaLZwuo6XsjaX4QFeGsIfwrf3jZ7JCIWhnJ
         KoPQXwvRdo+Sqwm/8YHnh3r2o1qeTI8H4RtL/fncOZU6Orw6aE6SujmAaAZoj9mgZgb5
         ARJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536848; x=1775141648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhuoiHNS8EWtKNqoBDqtr5VoGO7JWS8fa9w/yw4hw+U=;
        b=qKng9U87q078DudGzqMGfiQ7YDmyeHysRu4rxQxUvbGuQVoUxF3rVXGEDxmN0H1RZ7
         KPJQARZpp++tNoLVOpqK1UmdDjhOhisbeTbzHuRRqoLWIVYtQVuVbWEL1OB7eheW8x++
         S3fmB7wPNCmH8derp0n11gt/IqwbcraRRkkVHx1e3rLBtdB0rkiDfWQErWQz/kHTfOzJ
         EOa71DMV6rsFG41KogSmwH668QSD5axyM04fhKuUAcce39iotaOUs9XHDSpfVAYLGJYN
         pp3CUDtscnRUT5SHCA54PyaFqPKnFolFguvAWopglMxgW8eUOWdziO6vdVMqoUji/OLE
         sQng==
X-Forwarded-Encrypted: i=1; AJvYcCUKbVt7+IDkn05ucjPpA/vuRltsX+A0+0+YNr3nbgi4iyMEXVwTjDhOtTd0HPKYNyyXLnqS0aXL7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gz7uqsp6rukfJJHdMu+qbC2Ew+w9I11ZE48lDRS48a3921lW
	/rP5I+/pbPUmtSYJs/NOUcwBbOjnan80wnjP9ikFXMwdQ9GJ7Fpy5KapmtwAWW0bvv540g9azD8
	GRN5+G2Q48te8CENWHKZ9ZKlSKQa+lafVHAOnbrM=
X-Gm-Gg: ATEYQzwO98tnLJnoSDVUo9MAdstkUEKkiSsNu69wsg/9rViLUE9kI6G/XVIKHSvJWVQ
	qtHgzz84y1IsRrQ2mtW15x9ct1RikuQ82R0GKyg+HKyqukVHWHlfsx5w1Zxz0s58v/MPZr7xyiN
	EWVn92SY8ZAYL1NiQX3FLEBxYapbzR0AmXAmq4jndLV1gnSIvT+2sOw9a3Zr2ryEb0lbx57qDIw
	ealwJ0pXeDcwguvwMmRLy6uYU78v9ppZbwzYs16SCIWR+0Trp/U7xfZakRqAoOtJbWTswW19W1Z
	nXklRplkXuqEa6ds/5boyi7NOsOiAvZdovbYbGZ7HwliWmmqU2JJOvTtKkGV
X-Received: by 2002:a05:6000:310e:b0:439:ba57:5001 with SMTP id
 ffacd0b85a97d-43b88a29247mr12274420f8f.44.1774536847553; Thu, 26 Mar 2026
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
In-Reply-To: <m2v7eig4ue.fsf@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 15:53:31 +0100
X-Gm-Features: AQROBzDA_uO1pF648ctMN48d4pwbfgoV5WCFXg2YqxbpVDNoGL1Ww4jiqtlSmvg
Message-ID: <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> Samuel Wu <wusamuel@google.com> writes:
>
> > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > wakeup_sources, and puts a config flag around the sysfs interface.
> >
> > Currently, a traversal of wakeup sources require going through
> > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> > sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> > wakeup source also having multiple attributes. debugfs is unstable and
> > insecure.
> >
> > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> > traverse the wakeup sources list. The head address of wakeup_sources can
> > safely be resolved through BPF helper functions or variable attributes.
> >
> > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > speedup (sampled 75 times in table below). For a device under load, the
> > speedup is greater.
> > +-------+----+----------+----------+
> > |       | n  | AVG (ms) | STD (ms) |
> > +-------+----+----------+----------+
> > | sysfs | 75 | 44.9     | 12.6     |
> > +-------+----+----------+----------+
> > | BPF   | 75 | 1.3      | 0.7      |
> > +-------+----+----------+----------+
> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple list
> > with bpf_for(), and this current patchset has the added benefit of being
> > ~2-3x more performant than BPF iterators.
>
> I left some inline comments on patch 1, but the high level concern is
> that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> KF_RELEASE tracking is working against the verifier rather than with it.
> Nothing actually prevents a BPF program from walking the list without
> the lock, and the whole pointer encoding trick goes away if this is done
> as an open-coded iterator instead.

Which is fine, the critical section is only doing CO-RE accesses, and
the SRCU lock is just to be able to read things in a valid state while
walking the list. It is all best-effort.
Open coded iterators was already explored as an option in earlier
iterations of the series and discarded as no-go.

>
> Thanks,
> Puranjay
