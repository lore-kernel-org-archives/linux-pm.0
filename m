Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581714;
	b=O5GDp//1FMZv7FynNhusUfHb17uf3JXvk4wPybKbl1AO5E5CjXE3YEHHAQvvizdmpA1m
	 wWnFVgfLBsn6m3higRo1QHPi4QF4eTLQHH8WOEm9dLSkZ5XcRJ0BFnL7FfO3KbcC2Mj5j
	 XIFe17Gn8ynC1F/JdfZV0O3IDdVTRMsmpNdBvjeDW6Ep3GmAUCUi87atzhYv93wbkTBzD
	 Nvimt23cod0T/eak3X1J5PPpg5FfjaSQoR2t/ly+ZJ85jhcOSeMWs2Ogv3f14hfn03iPt
	 Td5Kdo2NT5TxC2jmXpJqWvccX4suX1zFijhtQmFdGTwZrH7l69bi90RxQSHNA652PFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581714;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8nxha2BknqjImD1m3gCjlKPZ0GD4hnrRTt8W76a9ZRs=;
	b=sXr1QYPbdGl7bySQhsI2fl/XD3t3CTtjMH/V+kEDvmdObV+0gHnHbY68IPGK/jHhOM7R
	 LD3QlZHgg4uMLcxcp3pxoS3+tSixoXbloawKNvsmDpA22BX9y+DBL/shHrQF/Tn1Nh5Va
	 Pb8hWUznDKjp8x7SKjmcNrN+e8PC+9907/i5oSbWSULD4zwwL8o9Qh2y5jjgTAwNL9qfs
	 DNmlFCh6hC9e6iEh/9kqWZ+yNhuEa07VGZUW/cJWHkoSg9TWZNypEmqp6IIC5YMe8MeYP
	 9yMfFYNYCKUU0eNJdZjnSZFGu4Q0b0xmBS0JEvg0j5efoHR9yYCrocifkUPNGvDxv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2gnOm9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96348606A32E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2gnOm9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457ED1F000C5
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581714;
	bh=8nxha2BknqjImD1m3gCjlKPZ0GD4hnrRTt8W76a9ZRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f2gnOm9Lr2v6ieEmflTcP/hrwQ3R/gmve616RQzut3y56AklNoa8Nepc5oieIWO0O
	 All0nPILllMFQrmuChDy5DHUuFf6Nkal25WkGBgPF8G1w+G/EgZHf3nI8ofZNRMqN0
	 uZ6Oh8wIG8zKXPpANpGwH3GE40RUBJzowIZ3jbMyo7JfJhKhjQfF1nKhylRrMqz5Wk
	 lbq+lavh04Qln0boNyefsPtIEcKZ3P1ZRfzgCGRMLd7Er6MdJkXff96EssYIw1+9q9
	 zkiGvZBE2t1dCjt95mX9NdqlmiHfhFbmkp8KVRoO1tqjFVCccFeWmXlSBa+l3Kmhph
	 io3F65lfAhsyg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3accd1ff4c3so14185801fa.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 06:55:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEcHKMa45PIBzqOlsZg91opgiIXBNnma1aKXOVGlVyk4CCvgTFu0kRIDVO48y//mU5B9KePfedY3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z82/dhx5d7VrThVkKi5gnVVrpq3rWTA8mE8tkviJemfxrqr/bwV
	UVBr3zhhyCY9PaJyd3aZq7pt1Hjc1ew61gcNPHCdgbqGQl4IerUs/NRH65uoPMRX4lfZMN+u7U4
	Ka33WbF0mQYdLifr3NKIMW5wSkgtZHOo=
X-Received: by 2002:a2e:a814:0:b0:3ac:f011:4863 with SMTP id
 38308e7fff4ca-3ae2b51f00emr10078261fa.20.1794581712678; Fri, 13 Nov 2026
 06:55:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113130411.1433174-1-christian.loehle@arm.com> <30a6c6c2-95ad-4f98-a63e-25f311967ed8@kernel.org>
In-Reply-To: <30a6c6c2-95ad-4f98-a63e-25f311967ed8@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 15:55:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hDkVA50qgMPn0H1NYUj7mK+VB9=w9Dr4GVV5ix8V0bSg@mail.gmail.com>
X-Gm-Features: AclHuK8xHLw6WuiwLQ7pOVG6xG517KuCsdiV2zbyhBwshX3MDuG4Phwds6Ak4-s
Message-ID: <CAJZ5v0hDkVA50qgMPn0H1NYUj7mK+VB9=w9Dr4GVV5ix8V0bSg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Reject EPP registers narrower than 8 bits
To: Mario Limonciello <superm1@kernel.org>, Christian Loehle <christian.loehle@arm.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumitg@nvidia.com, luoxueqin@kylinos.cn, 
	zhanjie9@hisilicon.com, zhangpengjie2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:52=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 11/13/26 07:04, Christian Loehle wrote:
> > The EPP interfaces use an 8-bit preference, but ACPI permits narrower
> > fields. With a 4- or 6-bit SystemMemory field, writing 128 succeeds but
> > stores zero, requesting maximum performance instead.
> >
> > Reject a present EPP register narrower than eight bits during _CPC prob=
e.
> > Use the existing error path to release previously acquired resources an=
d
> > leave the CPU's CPPC descriptor unpublished. Keep absent EPP entries an=
d
> > registers at least eight bits wide on their existing paths.
> >
> > Fail the whole probe instead of disabling only EPP. This also makes
> > amd-pstate's acpi_cpc_valid() check reject the platform before register=
ing
> > its MSR or shared-memory driver. No affected hardware is known or
> > expected and the specification is expected to no longer permit these
> > in the future.
> >
> > Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selecti=
on")
> > Link: https://github.com/tianocore/edk2/issues/10838
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied as 7.4-rc material, thanks!

> > ---
> >   drivers/acpi/cppc_acpi.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 11a9f9eb6b4a..4c3d5778e428 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -2094,6 +2094,15 @@ int acpi_cppc_processor_probe(struct acpi_proces=
sor *pr)
> >                       cpc_apply_platform_quirks(gas_t, i - 2,
> >                                                 platform_quirks);
> >
> > +                     /* EPP interfaces require the full 0-255 preferen=
ce range. */
> > +                     if (i - 2 =3D=3D ENERGY_PERF && gas_t->bit_width =
< 8 &&
> > +                         !IS_NULL_REG(gas_t)) {
> > +                             pr_debug("CPU%d: EPP register width %u is=
 not supported\n",
> > +                                      pr->id, gas_t->bit_width);
> > +                             ret =3D -EOPNOTSUPP;
> > +                             goto out_free;
> > +                     }
> > +
> >                       /*
> >                        * The PCC Subspace index is encoded inside
> >                        * the CPC table entries. The same PCC index
>
