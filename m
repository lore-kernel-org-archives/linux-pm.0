Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6FD46AF0D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806157; cv=none; b=iO3ssuGOl/DnvS+kznyMZQmZ7V4eY7JvBTtKtOA+FH7jJxfdVYigUiLiabXhZHZZwXy/vsMgYisH7vAIc0/7kG8IIEwplTWPIrF6ZJNBBR5eNjEjfPq/tiy5DPygVGwf/XWvSEE38o+B9dNRwLEGLPiuCVetoMoOwYf/WyFKjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806157; c=relaxed/simple;
	bh=0gnWq7J6UsKYRgQGTWIpbvuMmmM/gFO0L62LC0Ygx8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8qhCBIY6MCKGDfOSHCAxoLQmQqTWEIqBlKwfkfjlXN1Ya3GfNmnEIjQAMlQSQTarcV1aAN5hHkkZukfrwdjwAM9G4XnrwKshk8G35O0QcPSknWkfHyuGlbH+FQ7p76plL7je9D2+G0OYjJa1HC+ONEkakQFY592GN8xOhclqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev5TxP6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev5TxP6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AB91F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806155;
	bh=ccpaQUdsnyNVfm2zZMgeL3KgOrK4gYIP856PhacjGY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ev5TxP6dQAQ1i/pXTKQ3hPzLCArypD41JQucTipyX0S7UOIUoWH94ipn8xFTOCQiM
	 HG/Wc0yAbDUIlnL9j9d3fh8+W4nztg4rtMdrUXMVTosnKEqcjcnmxwRUrvDm6msiH2
	 oB7VAlaiKJmcJk4WDUNLbYKRnGEkRt7lgmF522vUX7ip3clhow9EqQPqQOxdZL4pXA
	 fPjYYZtKb+OMxKAia3KgDWrcJOLseGEFCY88rRe8YHJQHlvy/TTjhMl9TvlT5n7HOP
	 Ik/2yLvamvgMO+L7f+HlMqvHVPt1W6tLBqL6y6/QfudpTr5qDhYShxUBPYOidN3IeR
	 hyb7sp2D+Q17A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b29599b81cso551554e87.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 04:29:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqsd3hx5vji+OZkk53rgip1t2wWQwxL2bKaEybTE5uppcvRBM+wZoGhATi8WcjjZCXp/3+BLkAj9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8KlmAA+SEJiXxDeQpQFQphMUbtBgTcoPhEuQNNYEZKgsTkzL
	xVB55aepoXu7jcfwFkQds38roawxlLBpCjlSyfJH2aTG/ievMgjQOgWCBdKQnBSwj73942poHiv
	3P6elPm9L0m98srl/djdvg5+ZiXG1LF0=
X-Received: by 2002:a05:6512:3750:b0:5b1:5bb6:d620 with SMTP id
 2adb3069b0e04-5b2b2f7325amr327351e87.55.1784806153978; Thu, 23 Jul 2026
 04:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <52cc1241-639d-4946-bd61-9618ac53f053@kernel.org>
In-Reply-To: <52cc1241-639d-4946-bd61-9618ac53f053@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 13:28:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jh1ArJgPTQevwk205BWfqMyuuyZ4y1mROujQ-g-YaASQ@mail.gmail.com>
X-Gm-Features: AUfX_mzeeJVyqVRt1nIc2mjZdaQHscVMP8YAkyFmqN5i0JYI0U5PYRi5Kd7xlLw
Message-ID: <CAJZ5v0jh1ArJgPTQevwk205BWfqMyuuyZ4y1mROujQ-g-YaASQ@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate fixes for 7.2 (7/22/26)
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
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v7.2-2026-07-22
>
> for you to fetch changes up to 08fc1e7b31f8832e356ede8afae1ad1ff0d5a1fc:
>
>    cpufreq/amd-pstate: Prevent the driver from loading on unsupported
> hardware (2026-07-22 13:45:32 -0500)
>
> ----------------------------------------------------------------
> amd-pstate fixes for 7.2 (7/22/26)
>
> * Fix a case blocking amd-pstate from binding
>    when lowest nonlinear freq =3D=3D minimum freq
> * Stop trying to bind in guests
>
> ----------------------------------------------------------------
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Loosen requirement on lowest nonlinear
> frequency !=3D min freq
>
> Rong Zhang (1):
>        cpufreq/amd-pstate: Prevent the driver from loading on
> unsupported hardware
>
>   drivers/cpufreq/amd-pstate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Pulled and added to linux-pm.git/fixes, thanks!
