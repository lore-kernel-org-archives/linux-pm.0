Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937141A5BAE;
	Sun, 19 Jul 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784473451; cv=pass; b=NzGZqKjsrwAk3mv9EuUEMqmHn3cWBYipm7uSxkJvAtozrBp5PVYrLZMHZHDOd8r9FWLsOkeuLLKBh6XnIRmDjRqcUxsCTcNSyhqoiJ59cPzFZ05349krC3FPbVgveoJ103qqzfktMPVeETZkpLihXhBmAMJBahiOAc37CvAHLK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784473451; c=relaxed/simple;
	bh=AdrSTCVSIWmAv61Z/qSbs70ZjgTLTmmTR/uI/VxgNsg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJcS6JwsGQM2w+dutrNut48X6LeKUWuRzZxw9ilpOYcZt2enlQ62AP/lvy7nPoFWJezn1MMLGcVSl7K67iPAXfrGDwiYxoJWATvGiGryWiKdBmqx2nQGUCKlyf1RkHgmDQjoNp3VwEHJOenNw9JV1ttneALKH5uWiTUnBgFh2iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=cZ6g54pb; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="cZ6g54pb"
ARC-Seal: i=1; a=rsa-sha256; t=1784473436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOc0Z61ncQwQ600nCoeMC0qOrBwmsrScR6ldvLWorRzNsbq5G+K9haG5y/mSr11T4hCzy+OHO7ez/2sJk2eLO9CTO4axxOP4l3FKpyX5JJ4EK8bH/MSFHvElIpP6KnG73Eni9HE84ZxZeWH1myfV13mmlLPRD4Q+ocWuPbwlIGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784473436; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FkUOJF6RpT+nvBdgww4MkC3MVmiJ8IGZPjc0UcX6c/k=; 
	b=VKSfcI7gpluy5/UAioNZjJDwlMar6S313upwv/nPSYZq/M7YMF2cIhDQm85iXpAsJzfJJiOavH4f/xjZvTQsSJykCWItRz2r7ZQiaVfYs5GchTHQeWS5P+7dl6RsyHNmbUfScIDrfQGqrTOsxcDypuu4l1l/w+xHU/qui5Bj+Rg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784473435;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FkUOJF6RpT+nvBdgww4MkC3MVmiJ8IGZPjc0UcX6c/k=;
	b=cZ6g54pb/z/AsRFZNBu9HYXY0eY0vYk/WUsjVJqMlxuhEnozOWnl9F3vtj9tbq01
	EM9DDTGspIAmplP3f8V6B5a8xpJ9nndquWptmAonjLD3j1FT22L9QyIBGs/QYc9zZwx
	iSkiApbOayzCWcIxEETFKuhRSONff+WqbpOFiyQ8=
Received: by mx.zohomail.com with SMTPS id 178447343331827.223596262179854;
	Sun, 19 Jul 2026 08:03:53 -0700 (PDT)
From: <mhklkml@zohomail.com>
To: "'Rong Zhang'" <i@rong.moe>,
	"'Huang Rui'" <ray.huang@amd.com>,
	"'Mario Limonciello'" <mario.limonciello@amd.com>,
	"'Perry Yuan'" <perry.yuan@amd.com>,
	"'K Prateek Nayak'" <kprateek.nayak@amd.com>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Viresh Kumar'" <viresh.kumar@linaro.org>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Jason Andryuk'" <jason.andryuk@amd.com>
Cc: "'Michael Kelley'" <mhklinux@outlook.com>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
In-Reply-To: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
Subject: RE: [PATCH v2] cpufreq/amd-pstate: Bail out early if !X86_FEATURE_HW_PSTATE
Date: Sun, 19 Jul 2026 08:03:51 -0700
Message-ID: <001601dd178f$d032df60$70989e20$@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQF8IXSsA8zpw8BQVJA2MER4Y5p/q7c22wQw
Feedback-ID: zu08011227aa56999e9983961a8503698b00005c54ac4e7f00b422b60287505bc90f568d86f0ae61f237a766:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External

From: Rong Zhang <i@rong.moe> Sent: Saturday, July 18, 2026 8:16 AM
>=20
> When booting a VM that simulates or passes-through a relatively new =
CPU
> model, these warning messages are printed to kmsg:
>=20
>     amd_pstate: The CPPC feature is supported but currently disabled =
by the BIOS.
>     Please enable it if your BIOS has the CPPC option.
>     amd_pstate: the _CPC object is not present in SBIOS or ACPI =
disabled
>=20
> Technically the check is not wrong and acts as a safetynet that =
prevents
> the driver from being registered incorrectly, but the warning messages
> are noisy and incorrect, as the CPPC feature is neither supported in a
> VM nor disabled by the VM's BIOS.
>=20
> The CPPC feature is disabled by the hypervisor as it makes no sense to
> expose them to guests. It creates a paradox that the same kernel both
> disables CPPC as a hypervisor (KVM) and warns about it being disabled
> as a guest.
>=20
> X86_FEATURE_HW_PSTATE indicates if the platform supports frequency
> scaling or not. It is disabled on virtualized platforms (namely, KVM =
and
> Hyper-V have been reported to do so) and is always set on physical
> platforms that support frequency scaling.
>=20
> Check for X86_FEATURE_HW_PSTATE as a prerequisite and bail out early =
if
> it's unsupported.
>=20
> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if =
CPPC is not supported")
> Signed-off-by: Rong Zhang <i@rong.moe>

Built a kernel with this patch against linux-next20260717. Tested
on guests in the Azure public cloud, which are running on Hyper-V.
Tested where the underlying processor is a Zen2, and also on a
Zen4. The warning messages are gone as expected.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>=20

> ---
> Changes in v2:
> - Check for X86_FEATURE_HW_PSTATE instead of X86_FEATURE_HYPERVISOR
>   (thanks K Prateek Nayak)
> - Remove the check against Xen dom0, as it doesn't need the amd-pstate
>   driver (thanks Jason Andryuk)
> - Reword comments and the commit message
> - Remove Gautham R. Shenoy from the To list due to email bounces
> - Link to v1: https://patch.msgid.link/20260716-amd-pstate-vm-v1-1-
> 2ac97d3cf6e7@rong.moe
> ---
>  drivers/cpufreq/amd-pstate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c =
b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..877b4b30ecd0 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2228,6 +2228,13 @@ static int __init amd_pstate_init(void)
>  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
>  		return -ENODEV;
>=20
> +	/*
> +	 * Do not continue on the following checks and emit bogus warning
> +	 * messages if the platform doesn't support frequency scaling at =
all.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE))
> +		return -ENODEV;
> +
>  	/* show debug message only if CPPC is not supported */
>  	if (!amd_cppc_supported())
>  		return -EOPNOTSUPP;
>=20
> ---
> base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
>=20
> Thanks,
> Rong
>=20


