Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2A4A5C41
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373522; cv=none; b=F1t1DNAIpLAGYNqXEnJH0ifEmYq3XMRq5s5JrndAGVqfq90yj1/uIbtYQy+Asi3XJQFlDBHjfAyuQpsmPKZHjRyqhYBS0slcWYJEsvoNODoX8mW0nC66xjlD2xoZ0xao8wthOjNfVupSOLN48eHC+ZQPHgFSlIjrD5KxwROponE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373522; c=relaxed/simple;
	bh=nz28DfqvHtefyNegxqFh1duVUJANumKDTLI00w9IPY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFjkgTk7F79FMZiQm+EL22GG/iDI9ElqKq2iGe6qIi2kWqIWOqtqMzvQ1URoo9TslIoBeVgVEIleZF67r0V2modCDM6bryIrkS/+Zp/C75iuZoKaCCGoSFlUNBUvmB2pHe7OsU2cL9YjI57+gBAa5My95J4he0zuU6v3qzG9zHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvu055ET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvu055ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112BB1F0089F
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373510;
	bh=nz28DfqvHtefyNegxqFh1duVUJANumKDTLI00w9IPY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cvu055ETLVJ5XMoJM+CIrEuMDk3VJcs4AkkpZyeaSYjh3dki7VugPtMmqvJgXLtfU
	 9I0GaD0ZZnzMsIETGB2Og49KiQw04ltHIXVjMyQQ90yjmB0ZFoAzYBt+pGo55Mt75K
	 xRhoA1OYlIeTUWZNh/bt7VgEtsMSwM5PgDufIE6qfHnnEIpzI9aDdFBXqd0gxwb2bX
	 tFgccpiyrigskdeLjA+4WVk998CWg3r6ORsvLp1bTSvN3rnsP4AJOIQosk5VBBoxBQ
	 POgjg2Hn2xgm0eVeVlJvxvay9RBIjte8KT7XEsLhAwilfzJFAcbKcr8Uzcs59D0r/E
	 4SosWiCUJdY/A==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so45802081fa.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 04:45:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxH07aR70RLKNc8iF8XS4co3QTQMigCQPZumF6aaSHaiDQfxyTncwA49HGMUqcde2YQKVlR7pNsAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLzjMVMbI/ZFYrSrvkc6jiQwBJ7uGJxF+1cS+JOgIT5ps95PLgn
	1GmElICIW87AeTyZwbkL/1aGFlNtWnlqvqmjTDspt9/iJS442p1rDpTFOF1cESeH1gYZ62N3t29
	qKCXBg7oYxg03nL1GfrcaiCa+6Yghzlk=
X-Received: by 2002:a05:651c:b08:b0:3a6:6831:6e28 with SMTP id
 38308e7fff4ca-3a9a2c34eb6mr4880381fa.6.1791373508809; Wed, 07 Oct 2026
 04:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006231900.3230373-1-briannorris@chromium.org> <20261006161337.5.Ica4bfaf179a86c8d77f8f845826602914b81181b@changeid>
In-Reply-To: <20261006161337.5.Ica4bfaf179a86c8d77f8f845826602914b81181b@changeid>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:44:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLm0w_fs-O_BSwTVbGOwozB7yBcFAgTe=ubzFE_SxWjSUA@mail.gmail.com>
X-Gm-Features: AclHuK_tq1pfIubCAp0KCEs_RXsZkfKO4Fx3eMbI5PAcOYf2xBy3KSKKGEfBZkw
Message-ID: <CAD++jLm0w_fs-O_BSwTVbGOwozB7yBcFAgTe=ubzFE_SxWjSUA@mail.gmail.com>
Subject: Re: [PATCH 05/13] pinctrl: qcom: lpass-lpi: Discard
 pm_runtime_put_autosuspend() return values
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:19=E2=80=AFAM Brian Norris <briannorris@chromium.o=
rg> wrote:

> Passing the pm_runtime_put_autosuspend() return value to callers is not
> particularly useful.
>
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
>
> Accordingly, update the LPASS LPI pinctrl driver to simply discard the
> return value of pm_runtime_put_autosuspend() and return 0 to the
> callers.
>
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
