Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864397;
	b=RoEJEfC64ugu3wGVTgb2O8fjRtvZv7WTLbCuSR4/uSHNrNNX4ySE0/ERwpY2Kzp7AjG0
	 jbT436OmasoTZXMlg97yKC/yCMwRYvqbQNgu5u3KnyYv4+QWVSX0Fz+gBcjPmfJV3MDjF
	 LIOOqXkWb2zBzV/8w8z78aXxRVi2IFwr8rEudfPk+cxQhK6vQGu3d2a4fEsFKX48heEE8
	 psrG7E/ezGN4cORJ7vDacxPKjNG29SQBR3l+A9York87fpsZqbfv8hA5x1nP9VoNrIXFw
	 7nZvN0dnEZIwIncL/awHa1i/0hQh+7Bm19D+f6HLRW3Iqtxv6xI6TyzgGAgXTJDaFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864397;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RhM5xmdDWSdbgUw2M/aTisY/uYz2IOi/8m8nH+ZYFrQ=;
	b=uqPdQZ+EWTV84HhLTlEY15w/EBQsp8tEf4k/A7kB9Rj0TlX0zJlozUhn49OvuEkFrzL2
	 i++KUAPNf/VuWj+pvfVNlb6B4aB4Lq+zbCFLWAXZVO4LOmzOvv6LNyXd2ESzbX98j9t8+
	 IDbqsPIzGpXTKwV8hznRnG2bNMKMVfFX8p15tXoB9IEmrOSOXb47bdwiABBpJwlA2zyg5
	 J0ZJau/v9qQwg57jcsYcIDb4ThplQWqc60j25gBvHMYyTi/VBGLUMCJ6pD+BUVVF96M+z
	 TktSyQuGXLRsuCZSOrP9OGyqjXTrHKSGm0avFyydLYbcU87Mg2B8aHBqlMb5LJSpTqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGBX7D6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE248606A31A
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGBX7D6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB131F01828
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792864396;
	bh=RhM5xmdDWSdbgUw2M/aTisY/uYz2IOi/8m8nH+ZYFrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fGBX7D6gqBe4l81pBzUmByr8A1mOkHQEa/wej6h20RhTJlUy3phX5s4wyrWiFyEdh
	 DBQTXPp8AwBTzKE4ZbtjMHuf9l+wrsFIzzQVYNNyiCFGEGk5PGzxFgJuGb0v3AuhdF
	 E9EAtq+VVCyzAjbZ5yJ3CLlp8vgWdnG9JdyPyMdD83/vPwNS4pO3Vu5Ao1zXp0+VOP
	 TfDPMHpfSUvMdVM0O5f6L6ul8fD6B0EyyyU3yA2k1kNMhlQIbVF9c40lCsX4Yv6ILa
	 ITYdq1DbqM3aHmKgowiQWa6AUJcwg7P7JHaINTw9dnYxpCm9etJxxYr1imB8tfzx1M
	 HX9hNSPAIcf4A==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso3005749a12.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 10:53:16 -0700 (PDT)
X-Gm-Message-State: AFq9FYIpAV9qsEzyFJPVEP3fgwJ4qwi+brmnx91dyKg+Lc6P0YTo96Fl
	746Yd2AjC9Sfse8wxx8oCasIuKX8bLObGMTyA1dNIl2i6z5xuB/kA0vBFLpky+K9k3Nv58HVfkr
	3l0e5UCmAPUqE4mvdQbFLmNiwImo0BCk=
X-Received: by 2002:a05:6402:1651:b0:6a9:a3df:e4f1 with SMTP id
 4fb4d7f45d1cf-6b442fe5b46mr2383703a12.25.1792864395449; Sat, 24 Oct 2026
 10:53:15 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
 <4a9e2fb9f00e2ead8dc9af9e285c19eb21b5f9a4.1792428130.git.len.brown@intel.com> <atjgkFBFwBgCZJH3@ashevche-desk.local>
In-Reply-To: <atjgkFBFwBgCZJH3@ashevche-desk.local>
From: Len Brown <lenb@kernel.org>
Date: Sat, 24 Oct 2026 13:53:00 -0400
X-Gmail-Original-Message-ID: <CAJvTdKnYCAAKquPZ_aa16htpQoS3BR-MAbZ8c+YXj23eZ4QLMw@mail.gmail.com>
X-Gm-Features: AclHuK-IX4OZ8P99Rl7UJy4ir_7sBnDYQnnidxmqbNrhjRdGa7FzWQ1VAoBV9pE
Message-ID: <CAJvTdKnYCAAKquPZ_aa16htpQoS3BR-MAbZ8c+YXj23eZ4QLMw@mail.gmail.com>
Subject: Re: [PATCH 04/18] x86_energy_perf_policy: Cleanup: Harden with strtol()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > +     if (endptr =3D=3D s || errno =3D=3D ERANGE || i < 0 || i > 256) {
>
> Do I read it wrongly or should it be i > 255 (as checked below)?

yes, 255, thx.


>
> > void cmdline(int argc, char **argv)
>
> >               case 'u':
> >                       update_hwp_use_pkg++;
> > -                     if (atoi(optarg) =3D=3D 0)
> > +                     char *endp;
> > +                     long val;
>
> Doesn't this require {} scope in the switch-case?

added. thx.

(C99 lets you get away with this, but braces clarify scope.)

Len Brown, Intel Open Source Technology Center
