Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733940F8ED
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462899; cv=none; b=LeIH5oYD1NvKAHQwXlGlwL96AHuUoblHU5wDSqrm9WdWogqc7iFKRGe//zIqjX4bqyYTuYNyYRf0qFmbWeJo02iehtG1w0cMTXkfO3CKO1vMxJlT+NsKW8qwogvUZtjeVlfcByrsvW/CJs1DiAONDgl0trLsbn9gyB3iRCHh6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462899; c=relaxed/simple;
	bh=qypv+ArwVDjHx8b9Yx/6cz3STnV+TC1ZPM4pDaFzb7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQS10Qnaimx1JIBVpuQcJIi5O2NJJovfeY84jInf8Q67kuL20H3dtWEKltnn0sSeJXWuGWgcr6RNtHvMeMLyD3tzurlYwrvFmg35fVpiJnQ0lXmJ7R57VxOdPRml5TUGMh3uldDxw8GgXqH0I1iWX4iGGnubcIT8a9Jvc9mUHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp7MfEbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp7MfEbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797DD1F00A3D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462893;
	bh=DSyW7daoJNoAcxU7IA1vLlkQaF/7sZcH6ZpBtBe3V7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mp7MfEbmS8x5JzExqB+lh1du8PPXcboz/N209hgeuKb1Ojh+ElWcfv0Zm+A+MJe8S
	 /IRZq8OSTSPNbQT02GrieKPD5PRjFo4Tpi/ia7YtY0B55k5/qCviTCnz25o2B65/yz
	 Hne49fZrg88L/4pU95rBYMHPsiFKpO8d9ejpaBVd1OIV95JfUfcocRz9csg86SMA0J
	 fsSvbFl/ykZpZCHpfI/h6FHa4g0qw0kvscApm3qeA3/ktLpp5aCQWx3jB5hHuOcw0p
	 7pIB+E3qRcCOTiAa5zu+1e7i/sxMI9EKpakBW9YXNYCVWrFWFRvqXyYLP0hsd3s5IF
	 GIbsn5HH1saZw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so8017671e87.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ831NZzdygClQU1zmJ4XFTGCbmMJwgsGJ17QGJbviaMfgrnLOuW0Z2AuwcqkoNFcVUNdH24Jw3kXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bOPjNgi+Ci6VYCBa08ALNlcVStuPlSa2Dq81xwKXkOxPviQB
	FkJN5Zn8lKgUGGkd6q8wH7qauDQ1k3s6wUdaK520s5pDm2gMYMQ9ldmwIMCM1L4fxwAyG1JQ3rn
	nMmDxHOb7VtnsbJ/YaewIDGE5iJWx3FA=
X-Received: by 2002:a05:6512:108d:b0:5aa:123d:b755 with SMTP id
 2adb3069b0e04-5aa32373255mr1278754e87.28.1779462891971; Fri, 22 May 2026
 08:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 17:14:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_KhPRkh-p2pCKgV+UKO5bnTJF0TVbQNsjpY4iBO3w+g@mail.gmail.com>
X-Gm-Features: AVHnY4JsPhLN-gaTPwFmxvc147FmtJum2Enkt5AI338iSS3_dNjlqH2fSShXIIQ
Message-ID: <CAJZ5v0i_KhPRkh-p2pCKgV+UKO5bnTJF0TVbQNsjpY4iBO3w+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] governor: Fix races and stale baseline on prev_cpu_nice
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, venkatesh.pallipadi@intel.com, 
	davej@redhat.com, trenn@suse.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 3:27=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> Patch 1 fixes two baseline-consistency issues in the DBS governor
> framework.
>
> gov_update_cpu_data() writes prev_cpu_idle and prev_cpu_nice while
> holding only attr_set->update_lock, whereas dbs_update() reads and
> writes the same fields while holding only policy_dbs->update_mutex.
> Because these are independent locks, the two paths are not mutually
> exclusive.  The fix acquires policy_dbs->update_mutex inside
> gov_update_cpu_data() for each policy.
>
> Additionally, cpufreq_dbs_governor_start() reads io_is_busy before
> acquiring policy_dbs->update_mutex.  A concurrent io_is_busy_store()
> can update io_is_busy and call gov_update_cpu_data(), which writes
> prev_cpu_idle with the new value under the mutex.
> cpufreq_dbs_governor_start() then overwrites prev_cpu_idle with the
> stale value.  The fix reads io_is_busy inside the mutex.
>
> Patch 2 fixes a stale-baseline race on prev_cpu_nice when
> ignore_nice_load is enabled via sysfs.  There is a race window
> between setting ignore_nice_load and gov_update_cpu_data() acquiring
> update_mutex: a concurrent dbs_update() can see the new ignore_nice_load
> value but read a stale prev_cpu_nice, producing an inflated idle_time
> for that sample.
>
> The fix unconditionally advances prev_cpu_nice on every dbs_update()
> call.  With prev_cpu_nice always reflecting the most recent sample,
> enabling ignore_nice_load can never produce a stale-baseline spike.
> To keep prev_cpu_nice handling consistent, gov_update_cpu_data()
> resets prev_cpu_nice unconditionally alongside prev_cpu_idle, and
> cpufreq_dbs_governor_start() initializes prev_cpu_nice unconditionally.
>
> v3:
> - Update linux-next base
> - Fix two additional issues found during sashiko.dev review:
>     - Patch 1: move io_busy read inside policy_dbs->update_mutex in
>       cpufreq_dbs_governor_start() to close a TOCTOU window against
>       concurrent io_is_busy_store().
>     - Patch 2: restore unconditional prev_cpu_nice reset in
>       gov_update_cpu_data() to keep both baselines consistent when
>       io_is_busy changes with ignore_nice_load enabled; update comment.
>     - Patch 2: keep gov_update_cpu_data() in ignore_nice_load_store() to
>       prevent a stale-baseline spike in the governor-start window (when
>       ignore_nice_load is set before the first dbs_update() call); only
>       cpufreq_governor.c is modified.  Update commit message and add one
>       more fixes tag '326c86deaed54a ("[CPUFREQ] Remove unneeded locks").=
'
>     - Update the commit messages.
> - Link to v2: https://lore.kernel.org/all/20260409111407.9775-1-zhongqiu.=
han@oss.qualcomm.com/
> - Sashiko v2 comments: https://sashiko.dev/#/patchset/20260409111407.9775=
-1-zhongqiu.han%40oss.qualcomm.com

So sashiko.dev still has some comments on the first patch in v3:

https://sashiko.dev/#/patchset/20260419132655.3800673-1-zhongqiu.han%40oss.=
qualcomm.com

Can you please have a look at that and let me know what you think?

> v2:
> - Update linux-next base
> - Based on v1 review, patch 1 is updated to add the missing
>   protection around cpufreq_dbs_governor_start(), and patch 2/2 is added.
> - Link to v1: https://lore.kernel.org/all/20260406110113.3475920-1-zhongq=
iu.han@oss.qualcomm.com/
>
> Zhongqiu Han (2):
>   cpufreq: governor: Fix data races on per-CPU idle/nice baselines
>   cpufreq: governor: Fix stale prev_cpu_nice spike when enabling
>     ignore_nice_load
>
>  drivers/cpufreq/cpufreq_governor.c | 42 ++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
>
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> --
> 2.43.0
>
>
