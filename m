Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6A34DB46
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468236; cv=none; b=i3xaaCUnycKHTtVtBP5P/xoJVyb+5xDa0JUOvnYF2XVSCG7JZ24TDpMjDsgnl2OnaHBILB91DAUiEbrifc9lTeUiSuQoFPi7wa6KCMtFaHJ5f8D8HLAsxHktFAecbL7Ys6OKAjByMiyIOqhXT3gSjp7v4AFZBbu0ugdMt9vOV8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468236; c=relaxed/simple;
	bh=GYcnG7X7RM8TVuCsOPC5wWTET+xJDfEQHWl/c5tsQPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFnPGCiVO78uhufeNQIPcoj/3mEVSU13ElWJPN6XawkRkyAjVxpMaLpTtE+ccH1eCi8BJO1kOXGlq1k5rEqVlOGZUg8y9ZtyvdQO8KlXjUJCDN2a8ZgGgt7F/7of/tokv578iRz9Dds1Jc1c6WrUAjHQK1zfMtoP5Lun135gsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpAmWGKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpAmWGKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6501F00A3D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468235;
	bh=HSHev4uLTYjTBHa33qA3ufgFePjdKDZhCe+dJ+LM2YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HpAmWGKp+c56Z9k480JEpZhKJcDh4foTo1BdpphKuXHkq+M8yFpH4vYFXmViMPmnA
	 ddvlJhq9Wz2rjnrII8ro7Qlw52CLrvEdsDhzSsLdRLTbdYNGH6vRXkUyP22SPqKuFk
	 waO/tarfp5yg8MjyDhqRxBhZuhh2Exq+wjpDwfkIcMTyDbwMkFeTZogQCj+CexnR5K
	 gOhtRLZe0Z6/Ep0nJcda5a090R3ymq4nBKXfdMcGqOqkKy3E321lhzcOBIyJRGVO8A
	 UQNr+nZaDzo+VUZv797pVEIgxeEpz8l4A0se8zBdnx8whKnrwKjfHdETbcF6Q7ySc9
	 pVcAfBctg5ylw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3942e9977a5so79731411fa.1
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 09:43:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+c2cT/6YLLtnojHcIKR478D+kD25cVUnQD1eV180vN7bmlnGzeeXOeoo3/jrhnvNSXOH5qYV+QwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjnaU99D0SXmbimjdBI+tQU/etssBrlhzSXxA1t5YavmiOEqc
	KSpvyG3le7RMb4DHW2BGy/eBBSAb+t14bnTp75VSy8U76pFD6PROQ6KAKm5+0hoWF2LISEYHa6e
	Mq1mdYl8uPeGRDJctyc2vnGj64aMKf/8=
X-Received: by 2002:a05:6512:1587:b0:5a8:7029:c5f9 with SMTP id
 2adb3069b0e04-5aa322bfa90mr1392759e87.6.1779468233735; Fri, 22 May 2026
 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779423281.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1779423281.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 18:43:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h0TmT651oHFs068gxBAsqE=Y4sEY+rPC3OPkdFijndYg@mail.gmail.com>
X-Gm-Features: AVHnY4JoNJg3jEXEPZ8tjNBqjxCVD3amGdvwX0cYvh8W9Pi-J-XFJ5sEAa5ZecQ
Message-ID: <CAJZ5v0h0TmT651oHFs068gxBAsqE=Y4sEY+rPC3OPkdFijndYg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] cpufreq: Simplify freq limit handling
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2026 at 6:19=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hello,
>
> Here is the second version of this patchset.
>
> V2:
> - Add tags from reviewers.
> - Drop intel-pstate change.
>
> Lifeng Zheng (1):
>   cpufreq: conservative: Simplify frequency limit handling
>
> Viresh Kumar (2):
>   cpufreq: Fix typo in comment
>   cpufreq: Avoid redundant target() calls for unchanged limits
>
>  drivers/cpufreq/cpufreq.c              | 31 ++++++++++++++++++--------
>  drivers/cpufreq/cpufreq_conservative.c | 12 +---------
>  include/linux/cpufreq.h                |  5 ++++-
>  3 files changed, 27 insertions(+), 21 deletions(-)
>
> --

All applied as 7.1-rc material, thanks!
