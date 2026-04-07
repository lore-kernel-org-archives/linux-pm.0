Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F86369996
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592235; cv=none; b=VpidGcvM6kIUXZNAgl3vTX15DTKMwAi2szE7SB2sJ5bxttV+buC+5EPqNfy4kr31mKPSmNgCCsvTeCqrJwDYOytXLGk8UTJ85oZTZABAcWLdblF5onV47ZKlfJoB8344PKSJbDumL9RN5mfVzW8zwkCia+jwxf8P3mxeX805cxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592235; c=relaxed/simple;
	bh=K9P6a8PZZwnop53Bh8yulgItMRDU2G8VxE1BRbxCyow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB9o9ThLVcLKjNKMI8aqzNbP9OveNteVdlljftKu3jsHoXDsDiBjywuUZqioGR+2pf8oy0YZRhtFrdLSu+BYyQcW4BJebPeto0bKMV5Wbq3e25Fk4pzFx9HZ8IVWxcQYzwMhEGyxPz/1ok4FGdeJ2YmU+BQWImNWTF341nSNAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks77oAMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks77oAMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92598C2BC9E
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775592235;
	bh=K9P6a8PZZwnop53Bh8yulgItMRDU2G8VxE1BRbxCyow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ks77oAMXh+G1zs5QrfeJX8X8b10XQboWZE58lsCy9ptNfzt/mcHvbx68Ipf8pJtsv
	 pf2eLfYzTT2PmAPNWzUk2S9WBsnndKBGV/kIBwQo+WL30cSyN5rtydIraXjuCKAsju
	 LQeV2fUd+Ut4HM/pIgUmBSIglrGB54kGDwSGI0Nif2/QHqNHOjvNsJvhCPOBQ84m9S
	 2ZPXp8f87rzC7QivnNebfYmAsjE2xWpQJYJriTyOUI2+htVsBseWAy9KMtJV/846pG
	 YuKzrLFdzJ+en3xAOgvfD5mhoafjsPojf69I8VF+Hk5WLzPzzeENq5gXEN4d/WuR1Q
	 6XsFoslcR/iKA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40423dbe98bso2107294fac.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 13:03:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf4Kb2B+qHFNxIog2qFvtQmxoe7p6y2cCUhFsC1int5Ycci1khkMigYIPqfuu3e9tFq31uhjougg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2O6wP3UDB/vwgoc8N4YM8qBZJUAp6HWmF9KIIFgk6oTk0cIXU
	qE/EDwY38Si2hVkyCKMNzgSnCfhcAcw5iUPeGk9mwAf/mXnWySgZQD7zSQfY1GoDsmB+4BdXuFp
	P6qFmG3BRlNR2Q0ga8I/CKJh4vp0xqAk=
X-Received: by 2002:a05:6820:174d:b0:67e:7a6:6079 with SMTP id
 006d021491bc7-6821f486841mr9223119eaf.37.1775592234634; Tue, 07 Apr 2026
 13:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407194949.310114-1-mario.limonciello@amd.com>
In-Reply-To: <20260407194949.310114-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Apr 2026 22:03:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNqcqeQ59wFgovwwUkcyD7jZWgOS5zkuM7XPyV=P+VHQ@mail.gmail.com>
X-Gm-Features: AQROBzAA-jY2wvOzxh-gEFs0bp4uHk3sNHLc4VW1kW9Gkx-yIY4cgBLKMhb-TTs
Message-ID: <CAJZ5v0hNqcqeQ59wFgovwwUkcyD7jZWgOS5zkuM7XPyV=P+VHQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Add POWER_SUPPLY select for
 dynamic EPP
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 9:50=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The dynamic EPP feature uses power_supply_reg_notifier() and
> power_supply_unreg_notifier() but doesn't declare a dependency on
> POWER_SUPPLY, causing linker errors when POWER_SUPPLY is not enabled.
>
> Add POWER_SUPPLY to the selects.
>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance =
preference")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604040742.ySEdkuAa-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Use Prateek's suggestion
>
>  drivers/cpufreq/Kconfig.x86 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 53e2702e6f1c..7cd156b5e0fc 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -41,6 +41,7 @@ config X86_AMD_PSTATE
>         select ACPI_CPPC_LIB if X86_64
>         select CPU_FREQ_GOV_SCHEDUTIL if SMP
>         select ACPI_PLATFORM_PROFILE
> +       select POWER_SUPPLY
>         help
>           This driver adds a CPUFreq driver which utilizes a fine grain
>           processor performance frequency control range instead of legacy
> --

Applied (instead of the previous version), thanks!
