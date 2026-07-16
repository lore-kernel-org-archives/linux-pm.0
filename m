Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4283F99F5;
	Thu, 16 Jul 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226946; cv=pass; b=a1FeXVT+lIrJDd4X6ThzUQKi9Q3m1kkpuPoRmC62M0jEPeZtVV7PEwehj0fCstHP1zENOn4vB6QscB9KTsWbbelI3Isn4qVVQbd/Z9WSrtyV5Xuf9WvgKqfuAHggF8s7GUILufuDPjGuu8ux5iw/BwE5inLHKRBIu7NRoJuPqCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226946; c=relaxed/simple;
	bh=aFR2fj8cGlCZnfDtLcn6gmJyp56XdEV5QnzVE3csLmg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=O9ABwvAL+N4Rcu+iXAXud3sDXApG4GYjrZoEmIOQTFzPIxrKR+fSufcD34lS52p39yiQ4yKLkVfyKMTD8KCowdbLdyd28DJUAB88cWCbw4/mpDNqZ21UV/N+DXmMBZj3XGGRuK8yol6IiqloXr0HrxrLZHhPu1eNfFyC5KXSRh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=gOCFUyTv; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="gOCFUyTv"
ARC-Seal: i=1; a=rsa-sha256; t=1784226923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mH6LhODXWcymwV0+S9uUD4KmY3AzYnKFcEY6xUKcPbTpM/JjFSreczYkaHr/ns9SVuWFW/DweJA+9SY2pFCEM95CdHky4rvf0dnlpr9PHvejJbROnMKDIWxJE7jI9f9+Z9GjbSNPvtDXZj50gxVjTHh5LCua92BKa/nx+z88xmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784226923; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kQnzTCHW51hk4iBIi9fCk9tro0QsMRMEPE8aG0iuuKc=; 
	b=gzLFn//SGrNucEDySDEcErDocDERuSg+i2bbdRuzXUCpeX0tIAexgJGB8csbsQmMC1/vLN7AOycvz6WEXCGpmLqUQfCRExjBOITVjJuSzhpN3ZuDbNZmo5yJJyz7pv7ogtJrNqvGXAWARIJieWHMe1csJ3X1gxoQ9NnYZuPiSqk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784226923;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=kQnzTCHW51hk4iBIi9fCk9tro0QsMRMEPE8aG0iuuKc=;
	b=gOCFUyTvWI1qbkOI8pk8MnxsoNpxTayZbGg7gGNKqFXGFp4hQR6oh43SiGS9e67y
	1M0PNGOBp49ehCjJyM6x6NPvpqez1kcwJT/fmp/JRN6NQf15pyCX5bgVG6IDv5Pp9SY
	pGhFHlv0kY3Z07n4IwifRm2mDTWX0QB4kRZ+91M9tezfU30LZ6uc0KH2jAikf/XKWbq
	xl9jH+MNPlvoAlt4o7Mal7CF4kDfRnxkspMBZjbBaLoDAtRVM/GncBAK7+NwnKoV1bN
	xIdNjWFlBXPuiZ/PB9rgSYjjLQaAedn0Yh9D8JGU1MSMacRhEbKsMYFRd+SzEMcb+gW
	j8ndRjH9Ug==
Received: by mx.zohomail.com with SMTPS id 1784226920257175.99958034276267;
	Thu, 16 Jul 2026 11:35:20 -0700 (PDT)
Message-ID: <e23f42a9e57220c49ced41d22d50618cf24948cf.camel@rong.moe>
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
From: Rong Zhang <i@rong.moe>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Jason Andryuk
	 <jason.andryuk@amd.com>, Michael Kelley <mhklinux@outlook.com>
Cc: Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>,  Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar	 <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,  Borislav Petkov	
 <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Kelley <mhklinux@outlook.com>
In-Reply-To: <7caa23a0-bcf0-41a5-a600-99b33f418020@amd.com>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
	 <7caa23a0-bcf0-41a5-a600-99b33f418020@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 02:29:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi K Prateek,

Thanks for reviewing this.

On Thu, 2026-07-16 at 23:30 +0530, K Prateek Nayak wrote:
> Hello Rong,
>=20
> On 7/15/2026 11:11 PM, Rong Zhang wrote:
> > When booting a virtual machine that simulates or passes-through a
> > relatively new CPUID, one or two warning messages are printed to kmsg:
> >=20
> >     amd_pstate: The CPPC feature is supported but currently disabled by=
 the BIOS.
> >     Please enable it if your BIOS has the CPPC option.
> >     amd_pstate: the _CPC object is not present in SBIOS or ACPI disable=
d
> >=20
> > Technically the check is not wrong and acts as a safetynet that prevent=
s
> > the driver from being registered incorrectly, but the warning messages
> > are noisy and not really helpful, as virtual machines cannot adjust the
> > CPU frequency from the very beginning. Moreover, mentioning BIOS here
> > makes the messages even more confusing.
> >=20
> > Fix it by bailing out early when running in virtual machines (excluding
> > Xen Dom0).
> >=20
> > Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if C=
PPC is not supported")
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index a74a4cf99d22..f2115f935318 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -2228,6 +2228,9 @@ static int __init amd_pstate_init(void)
> >  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> >  		return -ENODEV;
> > =20
> > +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domai=
n())
> > +		return -ENODEV;
> > +
>=20
> I think, instead of this, you can just check for X86_FEATURE_HW_PSTATE.
>=20
> Using check_amd_hwpstate_cpu() from drivers/cpufreq/acpi-cpufreq.c
> here should be sufficient to know if the platform supports frequency
> scaling or not.
>=20
> If it does and _CPC object is missing, there is a good chance CPPC is
> disabled in BIOS.

Thanks a lot for your suggestion! It makes a lot of sense to me and
sounds promising. I will try the approach in v2.

>=20
> KVM doesn't expose X86_FEATURE_HW_PSTATE to guest. I'm not sure if
> Xen does.

As Jason said:

   With Xen, the Xen hypervisor itself controls CPPC.  dom0
   (xen_initial_domain()) doesn't need the amd-pstate driver.

I think we don't need to worry about Xen.

@Michael, if you have the time, could you test if Hyper-V exposes
X86_FEATURE_HW_PSTATE (i.e., 0x80000007/edx bit 7)?

Thanks,
Rong

>=20
> >  	/* show debug message only if CPPC is not supported */
> >  	if (!amd_cppc_supported())
> >  		return -EOPNOTSUPP;
