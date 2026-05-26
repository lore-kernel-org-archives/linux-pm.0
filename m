Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C627AC4C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816591; cv=none; b=GtgAYOnBKsD7A66Odpm7ViZts5geuf/oKHjNafzrmt4ksb04PdJ4ffkl15KPdi7oo9e4o9W4m6AwJ+2PPhKdtqDzJ73HuRrf8bm2+ksrKUHDT5ChNLjRI6hZkCoZHpW5Kq6mS9MA/9ofJm9gwBBv8FPP3RhCs/nqp/JBn/MXcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816591; c=relaxed/simple;
	bh=Hnc5dhITQZCplqYdTY2+O8rAEn8rDoGi4OcvnDDxRPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCAXvLNv0wKBywHxMYvdNB+Q9AiJznx94WbmZF7xjhnTsx/YiMqKzdrgoihJshnOz0nXD88+hFOrF2gtp3ZST0VjdFsLVfBdhfyL5xHV6XauFPKi+zWCxARDPTiXA56M7rxQ8t2FwEiJw6r63dmLRhH/+muJ3NDUR80VWtKi3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGSaNTra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGSaNTra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9F1F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779816590;
	bh=lODcqEWOXHxQs/k2e67fqRqteS0B7WStUSx7YnHHnrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QGSaNTraV3JYWCnxXmk+B25Rv2aW5+ob/DXz/0M1ZuGcVkgWURqlDPrdY07cvmcKN
	 u3vprw6rJCmdW0ZzLHz8moNC3VKT45XuyO6BkhWkGwFpj7817NGrcT04RM4Ens2mXJ
	 //LTUUpc8v3R05JTAixKicGiJHTrcyQPODohRXpqzDpIqxUcP5fscQO9pTQVsRTwnd
	 Aa3NtiCnI/r8kWrnZuqrJsXcBdaCf/1iIOxVdgFsO7XA4PM7YVjqSU26dJAbh8jbJr
	 C3RQcx0H2BY9YzLVYiRYCY7vUuVN+xJ1fv747eys+kXXvxzJpZrON0Wib0hB8yl0EZ
	 qi1gLHRmzTMdA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so10923481e87.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+OkMfuGbukf+tQcXWw1zt+ToMcV0MJrotjhCyk3tkh8p3PTKywnNiT/NdA478smeR1Agh1hHvdrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0h13yWCu499ZlCTYZrjNm0Zzo1pQHgRkwXYHswt7uS8BD0yi
	umoxiTgZVChkNUUngxH2yE5cNL2uqzCjM6ajHwmPhBlSJcwUks4zZJTP+FA4Sw5fcczhWbUOV/l
	/duk8IZRcTWyxp/IpqIo5cRxNrvFU/G0=
X-Received: by 2002:a05:6512:66c6:20b0:5a8:72e2:db83 with SMTP id
 2adb3069b0e04-5aa32373604mr4856484e87.19.1779816588841; Tue, 26 May 2026
 10:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
In-Reply-To: <20260329070642.10721-1-aravindanilraj0702@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 19:29:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8o8jxOtCDPDgup=J_nHZq3_Ysd_XxUjTZXYB5QYAhhg@mail.gmail.com>
X-Gm-Features: AVHnY4LALewk_Bu_dhKtEzYTKQBTtbXOT2TOAZyX1hEo8TWCAERAm4dHF4PVNe8
Message-ID: <CAJZ5v0j8o8jxOtCDPDgup=J_nHZq3_Ysd_XxUjTZXYB5QYAhhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] thermal: intel: int340x platform temperature
To: aravindanilraj0702@gmail.com
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, srinivas.pandruvada@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 9:06=E2=80=AFAM <aravindanilraj0702@gmail.com> wrot=
e:
>
> From: Aravind Anilraj <aravindanilraj0702@gmail.com>
>
> This series fixes two issues in the Intel int340x platform temperature
> control driver.
>
> Patch 1 fixes a potential shift overflow where a u32 value is shifted
> into a u64 register without casting, which may lead to incorrect
> hardware configuration.
>
> Patch 2 checks the return value of ptc_create_groups() and ensures
> proper cleanup of previously created sysfs groups on error.
>
> Changes in v2:
> Patch 1: No changes.
> Patch 2: Add missing sysfs cleanup loop in error path.
>
> Aravind Anilraj (2):
>   thermal: intel: int340x: Fix potential shift overflow in
>     ptc_mmio_write
>   thermal: intel: int340x: Check return value of ptc_create_groups()
>
>  .../int340x_thermal/platform_temperature_control.c   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> --

Both patches applied as 7.2 material, thanks!
