Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515689;
	b=HWS/812jpPg6UJGT76/iY9vNxCxA+s0ccE89+oT14AeetX1IDeRLZEmoSj22yzlMQBiN
	 Mp67wJn/NRieGebXg0rRQEbHrD1hcxzqTQwI0kFQZ0o3jMlCGFH2pIOGwrudqe06tkZFl
	 zM6+BiiBkJrrE106wlGeJpCceJolVs6QJGUsoa0FSs8GjIVcx6FhjORbRseECLwM+Cxkt
	 GQrYAYzkxWW94vF5/ln019waHi36VBv2RbqdhSNhPVYa9f7VF7BQzpBYno5eF2Nq1fltN
	 V1gAVKYlxgu6sxwb9qK3rXeORx7pC6Pkjz9EjMnFDtFHfXNqWuqwlcxR/LEb4UxP5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515689;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YXBcpVbwgEfTF+d5rjbl50MgaiSh1L8ku0r5a12R+AI=;
	b=AZv9NnZ+/EsKB0jO+e0K8lihozcX82/3UE10O0EEAdgh7pIk0XrEysoUXCUpZRj9gh97
	 3R+NdPGebzV2yB8PuwSUsCrV88HbjjLUqUHqCNFiuVvTxpQTScIVDJidFMqgzBInSH3AR
	 ZMUrfz87vhr8dVH5sfM3H4Q9/RJGCpQnB+ko3bUSYG8sJmgN21c1gQRSRyirsNZ1ZwnxZ
	 eXBN/GzO5gxPyiCUgGimcBEKL6Yi4oX+dzg0rg4IM0e5Y62Osiy8vk05djcl3W6VPlfVz
	 1+J/+yrDBzSuektTnPKlivq7hfDMbZ1uLyVx0CgLHPgGye3eS6/1TBVJ53wRaPF3wbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfwzMrQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4D606A326
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfwzMrQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45761F000D0
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 10:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795515688;
	bh=YXBcpVbwgEfTF+d5rjbl50MgaiSh1L8ku0r5a12R+AI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lfwzMrQbZOx+v4VMg2IwYeyhr76KyZFENEpb/d2EgyvULzFAj7t02yslFrevPF123
	 K8W22veG2kUfBQwL8Bs0IPnPuNQuJ+tec42zsO5W6gudJ+kl8lBwY4MNgAHlnnqqzD
	 gDzKPr5roE/on9E9QSK3tbEor9heQ9pjgIzD7i1oXMElgIn9NhkxPSEPYYnyb9ivg4
	 e2LgCbuvbjON6aNY4p55b6i6+do0jemyHQF6ZtwfpNaeGcVzqnExZ4igxrNbaPqvbk
	 VxTlnxiRvv7Fnt1Luh40LRIVhUxWt0iEdzHQrUl5jXXs74R1GeGn0Iv+D8Re+SGXX7
	 XQlmLP0Tj2+9g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso2465931e87.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 02:21:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFHKb9oP92+ic78F/Qp+6ROBFSUEANCKnINJlZJPss8HDxh/7GJ5ivBiD7VzQ3u6HNjfx6n6PtHYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hbVb58hqaeVUF/jBl/BP3aoImG+7/7KqgvXqi0GHDPQT9Rvb/
	mdg9oJvHYMnqNIrhOJZBSP2aftTHcyiH/RN205nOK6f/M/cq4vPQtnm3L//+nPq+sn2AiW54qak
	RrCPSOW9ByDkIz4fm4APfAsUXaJIaDOE=
X-Received: by 2002:a05:6512:3e26:b0:5bf:dfb9:33db with SMTP id
 2adb3069b0e04-5c1bc894b28mr4488535e87.38.1795515687650; Tue, 24 Nov 2026
 02:21:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org> <CAPx+jO_w6-y82_5+DTLxb6dtiNv2KNMYLKpRJU0nLRLvy5-adg@mail.gmail.com>
In-Reply-To: <CAPx+jO_w6-y82_5+DTLxb6dtiNv2KNMYLKpRJU0nLRLvy5-adg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Nov 2026 11:21:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLnkSRSGRKN7RAkQeKrE=NxWaWa0+e8o5pHvWsM-Ng4pkQ@mail.gmail.com>
X-Gm-Features: Aa3M54pifxQBkoANT262xLGX_zP7O6MWI1krQALhFhgz9i5QcERbJXtYNJnj1FM
Message-ID: <CAD++jLnkSRSGRKN7RAkQeKrE=NxWaWa0+e8o5pHvWsM-Ng4pkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Use power domain for display power
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

just quick answers,

On Mon, Nov 23, 2026 at 5:16=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> >  #include <drm/drm_atomic_helper.h>
> > @@ -1187,16 +1187,15 @@ static void mcde_crtc_helper_atomic_enable(stru=
ct drm_crtc *crtc,
> >         int ret;
> >
> >         /* This powers up the entire MCDE block and the DSI hardware */
> > -       ret =3D regulator_enable(mcde->epod);
> > +       ret =3D pm_runtime_resume_and_get(mcde->dev);
> >         if (ret) {
> > -               dev_err(drm->dev, "can't re-enable EPOD regulator\n");
> > +               dev_err(drm->dev, "can't enable MCDE power domain\n");
> >                 return;
> >         }
>
> Neither regulator_enable() or pm_runtime_resume_and_get() (unless
> marked irq_safe) are supposed to be called from atomic context.
>
> Isn't mcde_crtc_helper_atomic_enable() called from atomic context?

Atomic mode setting is a false friend.

"atomic" is one of those things used a bit like "static" in C, the
meaning depends on context :/

DRM atomic modesetting does not imply atomic context,
it's just regular context here, so this is fine.

I applied the patch your ACK!

Yours,
Linus Walleij
