Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243867;
	b=dmK36FnW+ykkGvFyK8oAAWLUAhh3nE01Y92alqrgx/LqOQ2bLJXqkACt7PKupWcJR7Tt
	 dtU6tgVI4OIuksNletOCT1e2mXLHETo2itSA3KhBP0Uo5PQqGNBQX0PtbsYmLtcSATqi3
	 bnI1/FD4u7bg5Qr9r8OhgCeeM54/QYmRX2COQHDhMvt6uirL3I/UWYsuOkinrd1LXdgxZ
	 wO7Du0F412mDdrDlPdV2kUGKaqzX7tGeU8nOj0jsuj7L3tekMO2Jzpj9IKYuErNqVngvD
	 vHX6Jn49AzXeIyDl5Aj0Na6XthkhPkqwVVLpwDzOXeKXbg1bGFoOopDI5ITMCN9JIAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243867;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98uplep4b6LqU0B6PhASQmtAA3ME48ucaufzOGjIC4Q=;
	b=o5Z1erdmaSzfzrIoxQmvH/GoGyVXh02FGN+oPRcps034gOClVMna3uYoSHmt0kVMOyUi
	 CBUQ+MrD5/ZSh4fwCuXDj2P4nd4XNnmfjRLqiD5nd8y4k7wvIO3IVMs9RjVtBTipI2zzy
	 sbfZ0jPI0RSvevfTibf5C60GVt8tw6iS/UDmNvjPPegSrQ3gY92UQWlE1K1FXIpLwXyMY
	 f0Tfhp8Z55I7Esa+o6ZOl1Cqj4uIGAcdKvryQAoR4FWyExl8InwRd92qvl+YeoQnE3S8t
	 S9EClsxLcKeL1cESiQND3voEwofiW6yQCSiwcqwRpzD+iaL9atIbacsm+N6uvFzbQjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CEDKgZl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F08606A335
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CEDKgZl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A41F1F00936
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243866;
	bh=98uplep4b6LqU0B6PhASQmtAA3ME48ucaufzOGjIC4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CEDKgZl/xaRZRuAjx30DASO6mcydIyq7HmjVgvLZ1L8dCf4QWBZZN7euKRRNsAOa5
	 nkQtEKBpUpxeJU6nUYWsnuswTvMSka3+Xr7i7cK1Hvg0899mUFcTZkfxjyC+VM1oVQ
	 0eUoybmqMCmEhluWN/c81AjhMvyXZ6NKExjIKcx+05kIIpRXM35gguJrd59CQ2QgQY
	 c3bVlXmI1+bvf9gkp09+8XBQKSixMHE1/MVQYz9+9LqRrn0G6Eo+Q1JW020tT2lZOE
	 kNoRTBZYfuXJ6ofKK8hzwahkQ8xDDQiacEPWDsVigBjd4AkSJn2w2czvHNKDD+72PP
	 qVbEDVDSgoYDQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be47aa555cso985873e87.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 09:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE2CCzEC8pGZ8ODnDPue9UArDYQlZH7ARYBy1+9CsbvWxsaydT6URd/YujKZG5aDkmnl52nh0ZfgQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+okHKqhS7mKmiioBBwGhKQeK5YKsYxQLwsJZG6iCLNNSMMWT+E
	SHVid7Is/6vaJlY351RGEH1YOPKSvUB/+cQVUzKdIEvIcfySf6o+nu3qaocUynuiDfPJEPZloEO
	3QPQs+R6HBcQ0lcCWQ4YUtb7rLKKjDhE=
X-Received: by 2002:a05:6512:3e04:b0:5c0:cba:7d30 with SMTP id
 2adb3069b0e04-5c14bfff517mr1529840e87.14.1794243864765; Mon, 09 Nov 2026
 09:04:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106193304.3347374-1-sumitg@nvidia.com> <20261106193304.3347374-7-sumitg@nvidia.com>
 <CAJZ5v0h=iH01rZeXARa3F3rE61qgp0K6U4Fm9wRp+LYq_zD94w@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=iH01rZeXARa3F3rE61qgp0K6U4Fm9wRp+LYq_zD94w@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 18:04:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
X-Gm-Features: AclHuK-WBxJsK7zT3GOZHOAjjrXQX2TasxeJszPwN6pPO8DsKH9AdlJccVyZZeM
Message-ID: <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/8] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com, 
	ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:01=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Fri, Nov 6, 2026 at 8:35=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wr=
ote:
> >
> > Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> > 8.4.6.1.2.6), which conveys the nominal performance level at which the
> > platform may run. Unlike the read-only Nominal Performance register, it
> > is writable, so OSPM can ask for a nominal level below the
> > platform-reported one, which then becomes the boundary between boosted
> > and throttled operation.
> >
> > Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
> > the value must lie in [Lowest Performance, Nominal Performance], which
> > the caller is responsible for validating.
> >
> > Add cppc_ospm_nominal_perf_supported() to report whether the platform
> > implements the register as writable, since a write-only register cannot
> > be probed by reading it. It uses the same cpc_is_writable() test as the
> > setter, so support is never reported for a register that a write would
> > reject, and takes cpc_desc_lock while looking the descriptor up.
> >
> > The register also joins the writable set that the SystemMemory overlap
> > validation uses, as the driver now writes it and can compete with
> > another control sharing an access unit.
> >
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/cppc_acpi.h | 10 +++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 5a1f84fddb7f..3a0ecdd1ab11 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_id=
x)
> >         case AUTO_SEL_ENABLE:
> >         case AUTO_ACT_WINDOW:
> >         case ENERGY_PERF:
> > +       case OSPM_NOMINAL_PERF:
>
> Sashiko is unhappy about this change:
>
> https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg%40nvidia.c=
om

So I've queued up patches [1-5/8] for 7.5 and I'll wait for a
clarification here.
