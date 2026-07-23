Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BD46D577
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806187; cv=none; b=SCN9bU/0ZM+HsIvFRtnrf1hM4dSd0NsclDFk/Js35ISoEHmscRrvdpuczxoZVWOlQnCzgdXOy9OfdaxvcoYAcQvZf3h9FUyqw+XvJiS6d3lNPxp0SI413xB+kiRTui5iAonSeAHxpF3vin7fr2d0GqMLj/YAcZjdsDAM6V+15bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806187; c=relaxed/simple;
	bh=du/U2XaDDncamHTpd6Y4lILTrjaZhpZ+lMxIU63QbVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsFrq2gA0EqXbDmL8G054Jw0GFtmRzOF9m7ba64+IsVberKGOgDHzRIOARXFLn2zBEY2huMNqKeYwBHMjI3o+qWyILAAUZ8lNMMAZFl1WSyATcvISmPk4gGRp9TvuLRVC0j3f5sQ8g9Rq/BIaAdY+ZGfG1Xz9XK8CvCjyZRVHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45B1F00A3D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:29:46 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39dbe684115so2659361fa.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 04:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqxW2dmv+/xdJDGg88xIeI0rDWk3gUKxG9J8NMgbQ2qmxrK+i7rPWvNyFqxkzQ6dWyeeM1h6QtM/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR24EWnvXrXMkKcti3s6EbpboctIzASrGqNv6r7c7BkQtWDiny
	h8ZVSsWKMZDcaWD2ZzwoLZkpQ13ldYqZwtdidG+SfGkwFnQoFcslkl6ESmMzeCXYLgjN6t7lRsu
	dWhkHT4Igh47g4EdjYx2bN0QsIIfSj9k=
X-Received: by 2002:a05:6512:3402:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b2b2fe18abmr524522e87.0.1784806184524; Thu, 23 Jul 2026
 04:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a58cf551-1d29-4269-9be7-2dcba48c51a0@kernel.org>
In-Reply-To: <a58cf551-1d29-4269-9be7-2dcba48c51a0@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 13:29:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hwoZzJ158Vs5kkWwKFnTnBzdGkD5tZ_2CH6CO+4JpOSQ@mail.gmail.com>
X-Gm-Features: AUfX_mxinKCw4pcWVXQXzdLdHX2foIsbx6kBKHKwr5v5-N6NI9FeoT6hHUP6864
Message-ID: <CAJZ5v0hwoZzJ158Vs5kkWwKFnTnBzdGkD5tZ_2CH6CO+4JpOSQ@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for 7.3 (7/22/26)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:20=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d398=
9f:
>
>    Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.3-2026-07-22
>
> for you to fetch changes up to 39c0cf62fc7851a17782e7efe8dfb2948739c681:
>
>    cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks
> (2026-07-22 13:45:48 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 7.3 (07/22/26)
>
> * Avoid running unit tests without amd-pstate
> * Fixes for EPP on shared memory systems
> * Fixes for dynamic EPP callbacks
> * Avoid loading on guests
> * Allow lowest nonlinear =3D=3D minimum freq
>
> ----------------------------------------------------------------
> EDAMAMEX (1):
>        cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks
>
> Marco Scardovi (3):
>        cpufreq/amd-pstate: Fix EPP return type and handle errors during
> initialization
>        cpufreq/amd-pstate: Toggle auto_sel in active mode on shared
> memory systems
>        cpufreq/amd-pstate: Cache the firmware programmed EPP value
>
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Loosen requirement on lowest nonlinear
> frequency !=3D min freq
>
> Qianheng Peng (1):
>        cpufreq: amd-pstate-ut: Skip tests when amd-pstate driver is not
> active
>
> Rong Zhang (1):
>        cpufreq/amd-pstate: Prevent the driver from loading on
> unsupported hardware
>
>   drivers/cpufreq/amd-pstate-ut.c |  5 +++++
>   drivers/cpufreq/amd-pstate.c    | 34 ++++++++++++++++++++++++++--------
>   2 files changed, 31 insertions(+), 8 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!
