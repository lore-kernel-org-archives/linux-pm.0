Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F224BBEE
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033218; cv=none; b=TjqDdNN8sbjK1igJOULgrert6185idxsjBfZahzvPJ1oF30Dol5WycBMgEckBE0e3Jk6MDiXdNZEZ1OubLeI2Fz7OfUeFGYjoaaCmV3odu+/xc15vKuQGl+DtVarOpuQAhd8KeqeJfsmKIkHf7DuJfNzEosRqczmfk+8zQsXyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033218; c=relaxed/simple;
	bh=RgnEOymjRqQSy+bVRYKIoV4ZKOtg3bU9GAajnc/cZJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/m0Bc2M5tvlRX2q0M2E0SC6rg2p5fNRJC2m4UohWfTyUbcbCKzc+F/4uoFxM+kKJcNEMgDtPbK8vpEEb0uWlp9gCiMW7V7kOkaLubrfeDWJAY3jdEa+AzFx8rgzadfkHkKpyUloATASyDaqAi0c5PV7+Hjy5n9cpUjMTqy1WP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMzfTyQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMzfTyQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC9C2BC87
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774033218;
	bh=RgnEOymjRqQSy+bVRYKIoV4ZKOtg3bU9GAajnc/cZJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KMzfTyQ587vikkSFOGf/RWSXSSf0wHUsmyq0rvINuX2zPOUqkbZJl1oJq3Fz+XvsA
	 XRSPuWFWbxwxka0oXvmlrfD7thxXIn3+sGViMzhY1zgsiMdDf0Ol8GgpkAPc3C/diM
	 MG6awpYmSezLKdggnU6Ay8YZINbftVG1eahV5MqMSUqTQFwBpeykLqwd2gh5eY1djj
	 Y/mX1JNehl/ym8Z1LhpY2oqAssgqtqQ1ThWJGTwiv07rZhUAMfxC92W545Dw6+Bddu
	 IlghAqHTJqZnXRMWsCVUcvxjAcYfF5XjVrikRRi8AY3zDNKJhOnbiMwVLBzdTJs55D
	 YFIA8k/k29HuA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-409de4132b5so526328fac.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 12:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdWmQ8xQAMrSsFIfwKmtKnrmkRLXoW6Vm3aPYH/d3ahqHI8NZ+0tlJ5JLCX/WidK4VILhOSpTMiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtczFYrpMpGQK34kgDGqzrpRE/mVjAUAqWysqyKHKEO0Qc3NN
	dAAEKxRlwIeviaXGKSsYe2eEnBS30EE+Xdd0SEMnjZEWQ5a2Ve6oxa+X+Ymr+4fme1nzqA+t8nZ
	zurx2m+mB8cqt4reLcJ5yBpWf+QcY6uU=
X-Received: by 2002:a05:6870:249d:b0:40e:dfb7:d1a8 with SMTP id
 586e51a60fabf-41c11237c2fmr2561853fac.33.1774033217611; Fri, 20 Mar 2026
 12:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773075892.git.berto@igalia.com> <8cfda38659c623f5392f3458cb32504ffd556a74.1773075892.git.berto@igalia.com>
 <CADyq12y84YNagLTKGnRiP=UZF049uFjz4FJX5Mi9mNzG5hx-qg@mail.gmail.com>
In-Reply-To: <CADyq12y84YNagLTKGnRiP=UZF049uFjz4FJX5Mi9mNzG5hx-qg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 20:00:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jY=zqpEGmNP0-CAQSfg8Y_iWWVjtjFbrz6LsGN6YVTBw@mail.gmail.com>
X-Gm-Features: AaiRm52Wb55uMu_9PW3niWw3S6pM1BPkWRS9jIANMTcYUd74ZLteKEkzmXjhXKE
Message-ID: <CAJZ5v0jY=zqpEGmNP0-CAQSfg8Y_iWWVjtjFbrz6LsGN6YVTBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: hibernate: return -ENODATA if the snapshot
 image is not loaded
To: Brian Geffon <bgeffon@google.com>, Alberto Garcia <berto@igalia.com>
Cc: Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 6:45=E2=80=AFPM Brian Geffon <bgeffon@google.com> wr=
ote:
>
> On Mon, Mar 9, 2026 at 1:40=E2=80=AFPM Alberto Garcia <berto@igalia.com> =
wrote:
> >
> > snapshot_image_loaded() is used in both the in-kernel and the
> > userspace restore path to ensure that the snapshot image has been
> > completely loaded. However the latter path returns -EPERM in such
> > situations, which is meant for cases where the operation is neither
> > write-only nor ready.
> >
> > This patch updates the check so the returned error code is -ENODATA in
> > both cases.
> >
> > Suggested-by: Brian Geffon <bgeffon@google.com>
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Acked-by: Brian Geffon <bgeffon@google.com>

Applied as 7.1 material, thanks!

> > ---
> >  kernel/power/user.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > index 4401cfe26e5c..be77f3556bd7 100644
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -322,11 +322,14 @@ static long snapshot_ioctl(struct file *filp, uns=
igned int cmd,
> >                 error =3D snapshot_write_finalize(&data->handle);
> >                 if (error)
> >                         break;
> > -               if (data->mode !=3D O_WRONLY || !data->frozen ||
> > -                   !snapshot_image_loaded(&data->handle)) {
> > +               if (data->mode !=3D O_WRONLY || !data->frozen) {
> >                         error =3D -EPERM;
> >                         break;
> >                 }
> > +               if (!snapshot_image_loaded(&data->handle)) {
> > +                       error =3D -ENODATA;
> > +                       break;
> > +               }
> >                 error =3D hibernation_restore(data->platform_support);
> >                 break;
> >
> > --
> > 2.47.3
> >
