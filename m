Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51A3B7B70;
	Wed, 15 Jul 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143644; cv=pass; b=ug9yUibLGLVXyKMTJmO2uOsRX5V085SXUNUOafwQRpdMS4xpG4itACjIlTXC5ebLVm59MHdtcgUX4JGE93azetl7n58xf6oaKYYV9xh8d+TvqAsUJBWGvNAxgPJCGEJHQhvMTJIMxmnVamM+fYfz7qeJAoVwdcItpBpo47mLH38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143644; c=relaxed/simple;
	bh=bTsqYDzQgtkF/z4hNMXPk1wCq8qWLLytSbhjZsb9hZk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VWnuzAud73MbylQF7EOwa8z1i/QLO81OcCak2x2YqELYKoKMZXph3CMQ/fl6HcyYo17/AuYYTyrszMWbZu2C+PB2CA3Fw2nfh3zLdSJLNGdvTxlmsMMtpDOKc4l0/nap6DaYoKegwiEjBhDqr1NxAoOafa7DWoVUYzwZuxKNVOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=qCkGST95; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="qCkGST95"
ARC-Seal: i=1; a=rsa-sha256; t=1784143627; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CW7PQo7cvqupW3d0auFJ+bIQY8mMPBDzQwc0QzxZ9pYtl3gw91+D8mcs05Q3vhc22NWdFOXvJHgtnZIWVl6DegdeH170//y3RuKHfLlr5UD+hZ6jEPpJRMVBl3tiMBzjfAGYsMf5KpCTCmY+GuliC41kdeGyPTcRdySAjBDmRzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784143627; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=plqiQnoODWjUbWxlkt4OaYFSMc/f7rSpBgthnPncz+U=; 
	b=hynysP0fRTiyy6UuVYwQVHzGjx38+uWhdJn22srS2SRo83rDaPi+LHOcg0u0gpWpVhcFHXjxn+IEv+LCHeHDbXhLqX3r4Xqw2OJdVAoX41tPyiGWe7/VB7y4m2vN5/YnQoFjKTrTFJqM9JtSKqlM1E5vc2eknzwR37J/HcD19I4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784143627;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=plqiQnoODWjUbWxlkt4OaYFSMc/f7rSpBgthnPncz+U=;
	b=qCkGST955CGfRszBX5lNuUjXK607F9wMvjAWnfgBK5PCO3Q2rnO4PR3Ut6ne6Slu
	ghKcMK48vsTy9B1g2Lpm9Q0k6jH54zu52O/X8zWJaTBH0l2HNMWdRaeGxAwhmcKbYlE
	XXluo5gN7mi3+jnKuEm+SNUTxoE5iQe/KDJlgTkB2kXy3lV/n9KW/fsUdc/vxpvTPoN
	yLNSecbjEjGsRhuNk41JhlUaky4t1AskPFah9JMNeKSRSkjYCaz+mPQT2eWGfYiR9uC
	b0f4Uik6/9JOznUUDi9n1oSh3ao0oPKeYJkr8/1Xt8/UYoq1rSa/FpLXa/nHOBP+QdF
	xnaHtRzBOw==
Received: by mx.zohomail.com with SMTPS id 17841436255141.2271290739388405;
	Wed, 15 Jul 2026 12:27:05 -0700 (PDT)
Message-ID: <ecc292377a145741f47ff2422b72fa95e57a725b.camel@rong.moe>
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
From: Rong Zhang <i@rong.moe>
To: Borislav Petkov <bp@alien8.de>, Mario Limonciello
	 <mario.limonciello@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, "Andryuk, Jason"
 <Jason.Andryuk@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
			 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
			 <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi Borislav,

Thanks for reviewing the patch.

On Wed, 2026-07-15 at 11:04 -0700, Borislav Petkov wrote:
> On Wed, Jul 15, 2026 at 12:46:24PM -0500, Mario Limonciello wrote:
> > Conceptually this makes sense to me, but I would like some comments fro=
m
> > others if this is the right way forward.
> >=20
> > Jason, Boris,
> >=20
> > comments please?
>=20
> We don't care if someone "passes-through a relatively new CPUID" - I am n=
ot
> sure what that means -=C2=A0
>=20

Sorry, typo here. I meant CPU model.

I usually boot a KVM with `qemu-system-x86_64 -accel kvm -cpu host
<other_args...>' to test various patches. These messages is a bit
disturbing to me as they are KERN_WARNING messages.

FYI, my device is Zen 5 based and always triggers both messages.

I can also reproduce both messages with `-cpu EPYC-Genoa' and `-cpu
EPYC-Turin'. It's just due to how amd_cppc_supported() is implemented.

> but we won't patch the upstream kernel just because it
> dumped an error message in the guest.

Well, the reason why I decided to send this is not only about how noisy
it is, but also about the correctness.

The first messages says:

   The CPPC feature is supported but currently disabled by the BIOS.
   Please enable it if your BIOS has the CPPC option.

The CPPC feature is neither supported in a KVM nor disabled by the VM's
BIOS.

IIUC, it's disabled by kvm_cpu_cap_init(CPUID_8000_0008_EBX, ...), so
the upstream kernel both disables it as a hypervisor and warns about it
as a guest. What a paradox!

At least the first message is nonsense in this case and the paradox
should really be fixed. If you prefer preserving the second message
("the _CPC object is not present in SBIOS or ACPI disabled") as an
informative hint anyway, how about moving the virtualization check into
amd_cppc_supported() to only mute the first one? ;-)

Thanks,
Rong
