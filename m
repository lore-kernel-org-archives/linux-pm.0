Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF84195A7
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519657; cv=none; b=qXqzYBQrBm9VdH32QyrghkcSf56mnL+nBp1CjmeSoZw6OnQatiGQmz4OtkOu7ATRLLtsByJOjb/koq9B2T9Q+HQX+6TI/u/SGDnWmswJ2+2byaymtEhGZOWHxHnykH8j5xVbkZnBgmvnoEOCMXbUIl53eWgHniXurw+7BytVHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519657; c=relaxed/simple;
	bh=//qCBxtK/i8YoHQBVOIU3ynTE2kkKbAee0iL1qgQK1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4B/ku6boUWl+uw25z3guvg1EzbNrcgexVTRieWjEgNYhU36Y/T5COR1c+9wY51X9wgK3hXgsOtPEe8L8+drF2YUxqZs3VCmErA3iUUhixUJKjKB6TPoDc98y4GnXQZv/rK8rl9VuPuWFSGs1ddTgI67M45RXIghUwT3VOmL7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPoP6+g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPoP6+g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849431F00AC4
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 17:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785519655;
	bh=zVTEl9NEnxNcNmf4so9CGVfIPEVHwZJ2tukVfnaj5nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DPoP6+g8FVQ91N01bjv4VOjshVKzzGHb17FgbUs9SPLfP+IXuKR0hwdrPNJ9krhNn
	 7ITI2LGEJt5Umxno27yRygNS3tA2H8OfZp2mno6R9ZPLdnCLJaWlcX7Q5Ok2c02FMX
	 QxGVYWfmYb+SiT1AsftNEH74j5gMssXx4sANnP8/6m63bG1PfITALV8vgPEdiKisBf
	 0U/K8CM4rESmMIXOFswr8YLaEjOgG3an1lX8Oiac+AgiE5JwK1GHU2l3YeHTylEmYL
	 Rp0nd1D+aczItQ46H/2RHKKCrqEYbY8CsVvK+Yn+1Fkm4JZJmexdsAZRJKcjrdUX2a
	 gx0m0KxR0jSYg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso1503225e87.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpcQNNK/qNESYnmieAdNRwlm0T/cbmY0RaTc7T4ilxDqdOA6En1qFqdvtUtmvwh6mXuVYI0/lZXXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8I3gzAdtFzlpKPDULYFnSimb3mCHhujNkyNrv2kk1ft3COqK4
	P7rKPptrUS7weo6SNUZhC+L1p2ZCCoIytqsxwhyKdxXsFQd11gxhU12/tJjntI2ZFelMk/o6o1a
	6kMcc7a1RjL+M0Y3CLVrqrsSdBx/Y4G0=
X-Received: by 2002:ac2:4883:0:b0:5b2:1de0:5e7c with SMTP id
 2adb3069b0e04-5b2e4f86209mr71179e87.51.1785519654008; Fri, 31 Jul 2026
 10:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7acd9274-390a-4806-b742-90e6a4a16572@kernel.org>
In-Reply-To: <7acd9274-390a-4806-b742-90e6a4a16572@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 31 Jul 2026 19:40:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYO+qQ_jGDmg_tkp=ZE=z89KS6QXf_ngAbif_+FspHZw@mail.gmail.com>
X-Gm-Features: AUfX_myu6JFEvZOkFzKYmnIDfdteB8Ii__vBeQjjMVgCt12Bbok1K6g-Wm6eU_M
Message-ID: <CAJZ5v0iYO+qQ_jGDmg_tkp=ZE=z89KS6QXf_ngAbif_+FspHZw@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 7.3 07/30/26
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2026 at 1:16=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> Hi,
>
> This is the last pull request for amd-pstate for 7.3.
>
> Thanks!
>
> The following changes since commit 39c0cf62fc7851a17782e7efe8dfb2948739c6=
81:
>
>    cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks
> (2026-07-22 13:45:48 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.3-2026-07-30
>
> for you to fetch changes up to d06c75c22d5c95ee27e01fedcaa07231c9bd5c88:
>
>    cpufreq/amd-pstate: Document missing kernel-doc members (2026-07-28
> 11:05:23 -0500)
>
> ----------------------------------------------------------------
> amd-pstate 7.3 content (07/30/26)
>
> * Changes for dynamic EPP
> * Adjustments to the bios min perf feature
> * Fixes to kernel doc
>
> ----------------------------------------------------------------
> David Vernet (1):
>        cpufreq/amd-pstate: Document missing kernel-doc members
>
> K Prateek Nayak (9):
>        cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
>        cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
>        cpufreq/amd-pstate: Extract platform profile to EPP conversion
> into a helper
>        cpufreq/amd-pstate: Add dynamic EPP as an
> "energy_performance_preference" mode
>        cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and
> "dynamic_epp" sysfs
>        Documentation/amd-pstate: Update dynamic_epp documentation with
> new behavior
>        cpufreq/amd-pstate: Reduce the scope of exported symbols
>        cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
>        cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority
>
>   Documentation/admin-guide/pm/amd-pstate.rst |  45
> +++++++++++++++++------------------
>   drivers/cpufreq/amd-pstate-ut.c             | 131
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++------------------
>   drivers/cpufreq/amd-pstate.c                | 243
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++---------------------------------------------------------=
--------------------------------------
>   drivers/cpufreq/amd-pstate.h                |  15 ++++++++++++
>   4 files changed, 264 insertions(+), 170 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!
