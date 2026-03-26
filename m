Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260E40F8E5
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542673; cv=pass; b=pef6Ag99nWssEh2zRRC+yXgjUzbRQhpSZnswL3V9do61nT3XjngzhdDg7cT8YhknaPpeQQPAGtG0himycXUgAYPLerZ49jiFrw1dl1Q/v+1RDfc8Girrem1uTWlA60l0IV3jw1oSllogF0hETZE02yqiL/iUMaPzZOj8Cz4X2wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542673; c=relaxed/simple;
	bh=BZbMBwHrp8whhIaCRPg1ZjbDngDwiMRAEfXI7t9rAFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO0J56CQrVancW+qrJsq23VYQiTLgojEcNuLLt0tR3Ub4OLcgOcpAiX/hTWeI5IisHZUsaMDy3rfqiHTNHXnUYVXzWdjWMz378SSABVUIcUTjo65dRnol53Bl6cZlQbk+gZ/mrFVRoBoZv/aw1RWfe4DBsXrUqpJNPIwGZWj7xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEcoCK16; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEcoCK16"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43b4d734678so1034478f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542668; cv=none;
        d=google.com; s=arc-20240605;
        b=B1qmD0xz0FhPENyODQTTDUzQE+LOcHt7YT5VePqehgS5EuOWjK8wS6VRGiEwNbVaya
         Yh0eHyNFUdQAHPmHgQJZPEBSof1CulOalrz9l3jW9FSZkheTFLqislgkdD7EeYLhadw4
         +9Zg/UjEBTrwQ+HoZ2IFKQTnDGKFkG5adzWw7PAHTWVkw3k13TztMoQSsh2E2RBwjBW0
         JJ3YPwJDWizEN4XUYTZKt9tpOn9oP1CDnqriZK4fjUMS4I8P6jDpaLK1r59gnpLguF8m
         APgnFP4Elq0axiV0JTZliyp4up9YjBf8Tw6vfQKiJ8nIp7IjYGi+1Ibrkh5VBmSbFnu0
         T1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        fh=vtrIG0V/Y76W7oRrVaDlBgeywKMXv4mibyl0QI6GSI8=;
        b=jnbydau2/i5iigsND7/z9ssA/qBvGA0G0z3A0aVMpo/T2OIeaM9UqvFn5900rhil+i
         Fww8XCyIZiZKiXPui/WPltaZc0SEREe+x61Pbp+dVa9OXHcPvc7Iwc3YUgY1gJ+Bv7Xu
         9fcdw8e94nEkbuC+Zj24lvroGLIoQPJ5OJoYpZOUeLK5Hn81Gt1aU4tfoRNLXEglswfj
         YvJ/4UfriwjTnOFGpcbMYb/4VPBN6oEpCduLTTdEgquypZHywVLYVFDNUHJAxEvv0aSu
         4zIKSITOKBrmgvBqwUTVm8Lq12SUP61WDen7PZu/ZKZj5B9z7fZtsxEG9HRfOVUFF7lw
         o8VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542668; x=1775147468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        b=UEcoCK16VvEhwgTWUb7DEymNbHkAuR2Bvi2cRcfRLUatm9fDCEXXSn8Q1V5742uhGA
         R6gnsW/rzrdfHepwh8x8bUDEfG1PwsO4eZIKmsKf0R37H2z1qr1yJT+XpjIWxxmZe3Q4
         aO0jysZgUPMJoJTOdUCI513mPtjQQ8wCW8tquZI8m0A2npiIMVJ/2ES7daPpw5KGm4pO
         vp0/yopINYEQMkxzRODW5jy546/II9ylviTu32nBNRUJ/CXC3Homjh449HkD8nAOs4Yu
         syrK23a6PHKQONTsYTfmjEeOFgKwFu9frvL44O5HCjxeUW74xyozGobyRbOPXfPUjYMG
         CG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542668; x=1775147468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        b=lCITX0XC/Rmlf5uaVVys3uTxWHhyXbgtgBIu59tbfiCICMZH7rgE1hcELZIm4rJ3Cp
         R84eex3e9oMcqGOZ9CZUTLe/mui/GGH8Vy3Z+Z9ImOva4zYVRiuYli+F/kipGL/7aEgh
         AZcqnGKo2Qk/Jot+ruJv0sdlDFKKLyKp4JElbnWGPARK0fBYWiS9g/72a9PwAc77S/pW
         GeWPmIR4PdcyEa1iP1H11E8aI7CMIXrYLPTYOcnkvHbfaRy5q3+JD2K/keagQovk5w95
         z52RXUno02AvRUFB96jxrfmToP6PW9D8R4veiCJIgJesrW+29oqlcH7vIlNGR5Etq+ZJ
         cC3g==
X-Forwarded-Encrypted: i=1; AJvYcCWQoYlTT9N9KvZKfBX+8+7idi0v45eUZvZRIP3/5gFrleLpRKdgY2rA9BN+/EGBBxFxsAD5PnSmjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nrRQdYcr5A3fvmwyuIcTPZriigOASFdbrIenXS843QVvUCy1
	CzafZ4qURFqmxhUXBiWeYt+5xcRDn/0EAmKa8ojiIe+s2/9PkZhz6Q7bYF3U3EwXn0BtgAoxO8T
	2bkkQ2A4jz1Lyd0YuIyIqsdtEOWkweCI=
X-Gm-Gg: ATEYQzyIWid8VdiSXS2G+uLkwd/sQsLUOUso2ccIDAjtSf1McwszTi97jqh+cv49g3v
	7+xPdYHPIbeV2cTB8DHFiErxgnWYAvvFcseWLLVjqINdb8vBp2m55gEwQZ50gSolnPZ3MpxDsiR
	ziEySkzXnnvQmGA5COkwYNPNqMrFdV7/8Djg5IJNO6zcPXgfokAxZVMmp4wWqVT+XXHXTFwZOMk
	vewhKaF+78/Q9GZlcSj65HliNoy5/mczKgaYZmcesM9mAiTNd1mgu/5+I6IGCnQeLkR/4/8zpsO
	ZunuIqkMwdZlLwSvgP0IPm8l5/rhTVGYC13DjD/L6ubKQ76shfjF7+WDxy0h
X-Received: by 2002:a05:6000:2481:b0:43b:801e:488e with SMTP id
 ffacd0b85a97d-43b889a8389mr12816871f8f.15.1774542665963; Thu, 26 Mar 2026
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
 <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
 <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com> <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
In-Reply-To: <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:30:29 +0100
X-Gm-Features: AQROBzDVtUgfqATd7rCHJdNRaOBCw4LGtIxgfT_E050yYf4i43poQlTnNZclS14
Message-ID: <CAP01T76nRgXf9XW+6SGaJ-N2iZSFj6E8--p5mtBB__czwvDUag@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Samuel Wu <wusamuel@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 at 17:26, Samuel Wu <wusamuel@google.com> wrote:
>
> On Thu, Mar 26, 2026 at 8:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 7:54=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wr=
ote:
> > > >
> > > > Samuel Wu <wusamuel@google.com> writes:
> > > >
> > > > > This patchset adds requisite kfuncs for BPF programs to safely tr=
averse
> > > > > wakeup_sources, and puts a config flag around the sysfs interface=
.
> > > > >
> > > > > Currently, a traversal of wakeup sources require going through
> > > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls=
 to query
> > > > > sysfs is inefficient, as there can be hundreds of wakeup_sources,=
 with each
> > > > > wakeup source also having multiple attributes. debugfs is unstabl=
e and
> > > > > insecure.
> > > > >
> > > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to=
 safely
> > > > > traverse the wakeup sources list. The head address of wakeup_sour=
ces can
> > > > > safely be resolved through BPF helper functions or variable attri=
butes.
> > > > >
> > > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing=
 ~34x
> > > > > speedup (sampled 75 times in table below). For a device under loa=
d, the
> > > > > speedup is greater.
> > > > > +-------+----+----------+----------+
> > > > > |       | n  | AVG (ms) | STD (ms) |
> > > > > +-------+----+----------+----------+
> > > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > > +-------+----+----------+----------+
> > > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > > +-------+----+----------+----------+
> > > > >
> > > > > The initial attempts for BPF traversal of wakeup_sources was with=
 BPF
> > > > > iterators [1]. However, BPF already allows for traversing of a si=
mple list
> > > > > with bpf_for(), and this current patchset has the added benefit o=
f being
> > > > > ~2-3x more performant than BPF iterators.
> > > >
> > > > I left some inline comments on patch 1, but the high level concern =
is
> > > > that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> > > > KF_RELEASE tracking is working against the verifier rather than wit=
h it.
> > > > Nothing actually prevents a BPF program from walking the list witho=
ut
> > > > the lock, and the whole pointer encoding trick goes away if this is=
 done
> > > > as an open-coded iterator instead.
> > >
> > > Which is fine, the critical section is only doing CO-RE accesses, and
> > > the SRCU lock is just to be able to read things in a valid state whil=
e
> > > walking the list. It is all best-effort.
> > > Open coded iterators was already explored as an option in earlier
> > > iterations of the series and discarded as no-go.
> >
> > kinda best-effort...
> > the way it's written bpf_wakeup_sources_get_head() returns
> > trusted list_head. It's then core-read-ed anyway.
> > Ideally it should be trusted only within that srcu CS
> > and invalidated by the verifier similar to KF_RCU_PROTECTED,
> > but that's bigger task.
> > Instead let's make bpf_wakeup_sources_get_head() return 'void *',
> > so it's clearly untrusted.
>
> Thanks all for the fruitful discussion; this is more rigorous. I'll
> update v3 so that `bpf_wakeup_sources_get_head()`'s return type is
> `void *` and I can add a corresponding selftest that directly
> dereferences the head and expects a verifier failure.

You could also use bpf_core_cast() instead of using macros to read
every field, should be equivalent. You may still need the macros for
bitfields but it should work otherwise.
