Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A046AF32
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512585; cv=none; b=pSeXsID/NgvWq4lhZNF/mtRmkrOTaz+N5rSXwAXkTjs5pYdsG6Z2BK/gdieYHFSZTNj7FCND9JZu56y5qkJZ5UrMGwZ9/McrNMsONx7hk7q6/DVyDmeaNFFQ6xhnXMJ9lKEpYH6O0n2M6CWpZqgQxGOHoildTs4jX1EX5Q50mS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512585; c=relaxed/simple;
	bh=22gleD+aJpXcLSVm6y1j6Leb4wwoPXwU6PI3NAufnYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Syx55mVJ3jpUnZu45HwLk48FMvPNx5Cea5wVwl5WP+svGZU1NhUHlLD1hZhVIFczUQfUh+eljOcNQPpKdQW0GjWiAMUq7gTCxXy1KwmSWU4dA1VFv/hgWw+woeUblgfCX7lOl/rcPlNJqQ+bdGHWjjIE2+RY7karRhZEIjCDk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8b5kXCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8b5kXCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318551F00893
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 18:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512584;
	bh=N6xKImpD+isVJZEefu8EL3c3BUJN5OpM+C9gjgM5cC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q8b5kXCPyxTXZBQSs6yJ7+fcoYXW17gg3MgRhYwiF5NwCYFVo8cy54msCpbE+tO2I
	 ugoFEhPUn73S2IwJWVB1j4d5gXPpbc2aWstjGW6F1toqRNJ2e7Z3ljrBnxLMjiIgxh
	 w/KumT+uyJxNLXCIJBXikWBYgT9avtxgyjKyUMwxxgC+NrI1SG+vFLTbI5OgS45Y/H
	 5up+SbZi9B43YjqTBiqlB22+elIafwQUzHV0XBq8iq+3EAn+FtZfNfCn1lHiWBxK5X
	 Rg/ab86F8fPMjFOMPVVT9nqaDjoXbyPVQqXi0PpllTyQovCV20B3GVZVPbtaob4FKK
	 BWxjupIeSZR8Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so3701098e87.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:49:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dXU6bTJqJN99zLH99/3hXLE5snFtbUrjUbfCKDLu+C1990jeUwVQ7ArYLtXsQwwJ0rIL5qv1uRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+B2sGHhH5geyGic3Ik5eNbkTCDMfhjkEu9iX8OokKLPkTX8Sa
	4UwIDyWWweCrQtyvXIhzmIvcZpbVILqtkEEsVcNxsUCWgPaDcxK9Bhtt/kPAvdDDK5NHk01BNKf
	HWFxvvJnEqV0e2uVRJFW4/3zwmwP61vM=
X-Received: by 2002:a05:6512:1247:b0:5aa:63c2:2cbb with SMTP id
 2adb3069b0e04-5aa7c074a8dmr1539958e87.9.1780512582678; Wed, 03 Jun 2026
 11:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2167c764-6159-4a51-b3f0-f0fbf6c147ce@kernel.org>
In-Reply-To: <2167c764-6159-4a51-b3f0-f0fbf6c147ce@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jun 2026 20:49:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ghALXyU8tf0gcT+qirhde7ah8_rQ9+FryuArfbLTe01A@mail.gmail.com>
X-Gm-Features: AVHnY4L9GWcrgznPrRoYqeary6cNYAx93L2cmOBoUZzvDk3KITDzraRN0Exfla4
Message-ID: <CAJZ5v0ghALXyU8tf0gcT+qirhde7ah8_rQ9+FryuArfbLTe01A@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for 7.1 (2026/06/02)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:36=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf37351=
7d:
>
>    Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.1-2026-06-02
>
> for you to fetch changes up to 5629eec1a2829871d496f3042884cdc267612f6a:
>
>    cpufreq/amd-pstate: Fix setting EPP in performance mode (2026-06-02
> 12:32:06 -0500)
>
> ----------------------------------------------------------------
> amd-pstate fixes for 7.1 (2026-06-02)
>
> * Fix a kdoc issue
> * Fix an issue setting performance state in EPP mode introduced earlier i=
n
>    the cycle from new 7.1 content
>
> ----------------------------------------------------------------
> Mario Limonciello (AMD) (1):
>        cpufreq/amd-pstate: Fix setting EPP in performance mode
>
> Zhan Xusheng (1):
>        cpufreq/amd-pstate: drop stale @epp_cached kdoc
>
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   drivers/cpufreq/amd-pstate.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)

I won't be able to pull it this week, so it will become post-rc7 material.
