Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460429B78D
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925054; cv=none; b=eNABXFktuPF4u2TCe+IouZnqyj8QK004/OwSOfx57AT1p/W2HpvnEc4KKJrVYNjfScvcOj+CXRlVk9964P6JOP/quGTKXeLdIYEGlFW0XgI5lWaCdNkTynM4TRnkgARLX6MNZ3CrNQpvvxXf1bsKavcptIL8uY57CkdFKjcs4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925054; c=relaxed/simple;
	bh=Pmqa0elLuYz9W+UzSntyHqrfU+5iQlIwIOAbFoTLyls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSTbAEPvhiQaBLwA0y2/Q392ar3xYJHhqmxGuSh2fUGgBgbEfZE6RcB2tOXz9UwbhpHohlK8tZFmxPbs8O/27LMR2wLz1d+mEbppmjtBE+QC4TM06o7qKcaR0aZqUamknuNQmEMJgDP3JJhbMHOJi3jpyOu5Lk3TE9HUba6/WBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3Wp3Tak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3Wp3Tak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10D41F00899
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925052;
	bh=rbjbVA2zPcLXRqov7hk5za2E9yGoKiVl/76+ULlMh9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V3Wp3Takf8z3lDo2k/NtHA8p6mMJpliXIAZkjy+GzYYGNe0nVV3qp2nJKiCalelY2
	 siJ0MCN5XblTJdQRSfG7Agh6DxFtSmWHmlw5TgGR9BlkJ4rzRAwDAPJDhGbGxcSL+x
	 CbPmLiJ4oEIw0dfXiUS98OabWgDBr4sLmzpzGcdy6TkUTl3LQAYIjMh/NnaAfoYsp9
	 /HmS3AO2OLl6syhj1qSyI14TRhFr57IRpZmpi7acHrhkwvw1DU8xjPp8Hf0C9ofasD
	 UcIwPKukUSShMSr7+La3XKTo/b2mFdZT6sfFgAMn2Z8QVe03f51cZ+QS6GWM4tO6oQ
	 Mn/tIaM7kxJLw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so3049790e87.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:24:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+jWwAphEeH3bKFQQXfA30kzYMSqoZbRXkh2/JA6O5lxh9c4rTQJ4pt+oIKx8CIA75NxXmqGhJ3sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHNBn+N3FSuq31/qtxHUJ49Ud7s3ObJzSxcCE/nMyOA4PrRqD
	1r9698yNv9BYfbrJeAYfkaiAoD7CYT9hX8VmU2TyDIRhE6q2Kzc5Ktt+2XyKzaMW0LQM61BsYrX
	TXxmMbEqb8hXQt7iqhG0VVtptx23/UcI=
X-Received: by 2002:a05:6512:108e:b0:5aa:7a70:c014 with SMTP id
 2adb3069b0e04-5aa87be9697mr5291776e87.28.1780925051023; Mon, 08 Jun 2026
 06:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2167c764-6159-4a51-b3f0-f0fbf6c147ce@kernel.org>
 <CAJZ5v0ghALXyU8tf0gcT+qirhde7ah8_rQ9+FryuArfbLTe01A@mail.gmail.com> <57ac3334-a7c4-41f3-ac9b-99993162ae55@kernel.org>
In-Reply-To: <57ac3334-a7c4-41f3-ac9b-99993162ae55@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:23:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3OPVze4J3VRSa3TAeH1hZwffCPMD+6Df+7sf_88Eghg@mail.gmail.com>
X-Gm-Features: AVVi8CfXICkXJ06v_prADWh2_8yShbbJGHlK2ckuJjI7xRJD_DFrHQoR74CF2M0
Message-ID: <CAJZ5v0g3OPVze4J3VRSa3TAeH1hZwffCPMD+6Df+7sf_88Eghg@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for 7.1 (2026/06/02)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:57=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 6/3/26 13:49, Rafael J. Wysocki wrote:
> > On Wed, Jun 3, 2026 at 8:36=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf37=
3517d:
> >>
> >>     Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>
> >> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.g=
it
> >> tags/amd-pstate-v7.1-2026-06-02
> >>
> >> for you to fetch changes up to 5629eec1a2829871d496f3042884cdc267612f6=
a:
> >>
> >>     cpufreq/amd-pstate: Fix setting EPP in performance mode (2026-06-0=
2
> >> 12:32:06 -0500)
> >>
> >> ----------------------------------------------------------------
> >> amd-pstate fixes for 7.1 (2026-06-02)
> >>
> >> * Fix a kdoc issue
> >> * Fix an issue setting performance state in EPP mode introduced earlie=
r in
> >>     the cycle from new 7.1 content
> >>
> >> ----------------------------------------------------------------
> >> Mario Limonciello (AMD) (1):
> >>         cpufreq/amd-pstate: Fix setting EPP in performance mode
> >>
> >> Zhan Xusheng (1):
> >>         cpufreq/amd-pstate: drop stale @epp_cached kdoc
> >>
> >>    drivers/cpufreq/amd-pstate.c | 2 +-
> >>    drivers/cpufreq/amd-pstate.h | 1 -
> >>    2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > I won't be able to pull it this week, so it will become post-rc7 materi=
al.
>
> OK!  Thanks for letting me know.

Now pulled and added to linux-pm.git/testing, thanks!
