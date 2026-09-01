Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8B481238
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280529; cv=none; b=aYXfPgXUW1S+XcWk6q4Maa1+eXfoQNL644DiKLdhZY+3r77gdYDppDU7XEnXOZrpvjJ6FKb+asFY6b43RcldkBc4zEHSjk83p5xqtT7ZwX3IyMyOh3D1oPbj7mpeXe38KadYzyZiTxQk9waBcPEkMYN9pixY4ogItzoBcA5eYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280529; c=relaxed/simple;
	bh=N8JM3AGLYH7uWa9CDWzRiEpqBo+EGY0M+jTXIhBNq+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efLQ+obv5Zyah56xBpiGRBVUNJGhHlj8ArYFr+LYQ5MBgsl9qmmatlJ9WSJk+FsaenLVW0IcLU5xmRmLEySgvvES7v0Yw44s6Chq5Zea+rYSaBIuxxDcNQr3w1xvOumk0CA8Ff5vjoRKc14nLFSzlB5J5jCjihvfq6QJr/vkm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTpemz1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTpemz1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C521F00ADB
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280527;
	bh=ohW7UY6jRF8/wS6/l3RdRhBBpTsafPMYyJNXCMz+GIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JTpemz1JdI1TYNNCQS3gvhcbKXgfipNBY6U3U5aK6wnOY8rDW4mbwui7wXglFmqtX
	 9M0zVjx5NckXQAE6xiMc3rSmAXwE3E1DVjf2hhWAzRVilhTkqbeZDw6fVYK0plXVAn
	 FMkiP4TSPYAij0Mw/iAltpNblsr3hneehsTONm9YifC3V1sSECIu1oozxTC3df9W3Z
	 zFGNLqyNI/NC6rnxTquiw49Qa9ztDfX3YUPUm96X10DhUw+PxfmjkBs2ttUYYOJseK
	 OVBck7zwj5KcMOr2E1Juh74P1eahIc56OiDATKiO/jx8pmtgX4QulqHt+o6pKLqSbL
	 PCo9WL4HY8Qfw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b4ab40d839so4870724e87.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 09:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwA57ExoA+r45zDs3bQR1E6+nDLEoNFUr1f/mFbIibER2fAH78Q2KOLzchrHCA6X/vfAbIcrfyVsQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nFwd0Ih/CKZP5fXG1oalZt8I//jemuUohKb1ghwu+n/AprBdea
	JpTR6Ib3+74IjY92sFbUfZ4cYz6rEVZag0QmzSixrXk+RoTsQ1Yz2uzk57Wq/7TR3L0OTF1Svq7
	pgcFNH7j6J3sUEyyAHaUDUizuDFb+a8s=
X-Received: by 2002:a05:6512:2384:b0:5b4:a9e6:aa9b with SMTP id
 2adb3069b0e04-5b5fe0d82bcmr4339765e87.13.1788280526139; Tue, 01 Sep 2026
 09:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831194428.2287055-1-mario.limonciello@amd.com>
 <20260831194428.2287055-2-mario.limonciello@amd.com> <f18fafe4-f873-4080-8ddf-72fb6abec557@amd.com>
 <fc724887-fbad-4433-85b2-27dca6da28dd@amd.com>
In-Reply-To: <fc724887-fbad-4433-85b2-27dca6da28dd@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 1 Sep 2026 18:34:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipHi6DFbd=kCnJvxQ4qzsdANHou6uAPXbhFxUrLpdmuw@mail.gmail.com>
X-Gm-Features: AcwNN1VbtB8tSvW4djDqQk6HmLj6pWKgELFaMSxC7WUTfQB8XFHS9f8A7fYlhoA
Message-ID: <CAJZ5v0ipHi6DFbd=kCnJvxQ4qzsdANHou6uAPXbhFxUrLpdmuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor boost ratio handling
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, x86@kernel.org, 
	Vishal Badole <Vishal.Badole@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:28=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/1/26 04:31, K Prateek Nayak wrote:
> > On 9/1/2026 1:14 AM, Mario Limonciello wrote:
> >> +int amd_get_max_frequency(unsigned int cpu)
> >> +{
> >> +    enum x86_topology_cpu_type type =3D cpu_data(cpu).topo.cpu_type;
> >> +    const struct x86_cpu_id *id =3D x86_match_cpu(amd_zen6_client_ids=
);
> >> +    const struct amd_max_freq *max_freq;
> >> +
> >> +    if (!id)
> >> +            return -ENODEV;
> >> +
> >> +    max_freq =3D (const struct amd_max_freq *)id->driver_data;
> >> +
> >> +    switch (type) {
> >> +    case TOPO_CPU_TYPE_PERFORMANCE:
> >> +            return max_freq->performance;
> >> +    case TOPO_CPU_TYPE_EFFICIENCY:
> >> +            return max_freq->efficiency;
> >> +    case TOPO_CPU_TYPE_LOW_POWER:
> >> +            return max_freq->low_power;
> >> +    default:
> >> +            break;
> >> +    }
> >> +
> >> +    return -EINVAL;
> >
> > nit. Since we don't really propagate the error codes returned
> > by amd_get_max_frequency(), maybe we can return 0 instead of
> > -ENODEV, -EINVAL and the callers can simply do:
> >
> >      max_freq =3D amd_get_max_frequency(cpu);
> >      if (!max_freq)
> >           max_freq =3D /* Fallback */;
> >
> > similar to get_max_boost_ratio() pattern. No strong feelings
> > either way.
> >
>
> OK.  Will adjust for next version.
>
> >> +}
> >> +EXPORT_SYMBOL_GPL(amd_get_max_frequency);

Please note though that all CPPC-related material is gated on this patch se=
ries:

https://lore.kernel.org/linux-acpi/20260830115644.2056983-1-christian.loehl=
e@arm.com/

and there are other multiple series already waiting.

That queue needs to be flushed I'm afraid.
