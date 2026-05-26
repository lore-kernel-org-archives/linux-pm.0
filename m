Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57943290C8
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804432; cv=none; b=aKJ+AEroA0L+NvmcC9Li2oP7SMXON9dvVUXs3UujHqy0nfIp4tau+Vh8Icn/cOiWCb7/X4cttrXGUSn+Hn8H9W2BCQkRZZsHdeviy2Jie1PuatQpR2oM/dJ52uq7bCuJWCIWbV+KGGJ35OBRjnA5voKjJ62tXNVLa4jmmTqIoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804432; c=relaxed/simple;
	bh=M1Uuiiof40oQoWGK7awnoDjUa4WYEeVHpoe01/hpnmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0KIqYTGREa6q9D7XqD93jTnM+XRi3SARKMC3856cMkcqAYNJCH4J/CusJu//iPpj2NWkKn9XzJZFlYjHGl8P/BV+QcJnda2HB2/x3FgePHEBK0D2pR4I0UyRILYNQPznWnwYgA94fYxk864C4o9BzeBxVPyJm20uv1RLqA5MKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPqOce8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPqOce8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0701F00A3A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804431;
	bh=Yba0i48MmIBX/juqovKcI6XS3y0COE0MxSjLuMOav+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JPqOce8qMC5hY4KPCZ7PzIYwE/dq789w2FoZW5/PbmrtUPcz78/19QCJgn/SrE++5
	 Fo/L6btfd7QVG029E4hYZ6krYUN8g1BMeiTlzTp45saD+ilsps1lqlvglmqtJdeHnH
	 rzqlGsJcDMDo32Xu4BNK0oNdhKImnLhnWxLIDvsW9+9SYoEPx3t3ysH5SedrwSj6Ta
	 HaveQ9GgVV/61kei6vZCYOinDKi5wxW54iyBM/iODZ9YZRnf1l8G3DG8F5oyEPYdmO
	 qRvKV+4tQoh2N2Yj63yamB1xh6ypJ6aKREQEi+1osKJwa7QOwsOhEI1a7j8hjbJMEJ
	 fPF3/TJsvsg9w==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-57516bb40b9so7479243e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vtK+N1KUfdiqybp6WNFFjif9wSwrb6mPy9Ifsce72XmUVpBjfECF4Yq4VzWYf+8FEQg3mLoPl9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8kELYFFE9iKrQJr/lhmPU/sLRUtgMxltBTuc/Gts3SOKUrgS
	lctfNbsdImJ2jf8asquJZHBPgSp0DVTHhuy43Sdm3bUeoRLNqMo5Zf5f420xhVLxqh1F+xVxJnj
	uJ1eQbJNA9KW+F/om1JXKSqEwUubfdaE=
X-Received: by 2002:a05:6122:d19:b0:56f:a329:6859 with SMTP id
 71dfb90a1353d-586606b9fddmr10731774e0c.7.1779804431019; Tue, 26 May 2026
 07:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427205024.254677-1-superm1@kernel.org> <20260427205024.254677-5-superm1@kernel.org>
In-Reply-To: <20260427205024.254677-5-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 16:06:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhp4dHvB2ThFPO_AbmSRooBWy-v5WJ3Oc0s8Q0ZoA8Gw@mail.gmail.com>
X-Gm-Features: AVHnY4IaVZe7x7i1VvdYMQ4m79d2Ez12WV8G_5r5HmjNGwXgCAABseXz4GeOIZU
Message-ID: <CAJZ5v0hhp4dHvB2ThFPO_AbmSRooBWy-v5WJ3Oc0s8Q0ZoA8Gw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] PCI/PM: Run bridge power up actions as part of
 restore phase
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Suspend resume actions will check the state of the device and whether
> bus PM should be skipped.  These same actions make sense during hibernati=
on
> image restore.  Apply them there as well.

Doing things because they can be done may not be a good idea.

Please say why you need them to happen here.

> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index bfb521eb0eed7..793af4af2971b 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1273,10 +1273,15 @@ static int pci_pm_restore_noirq(struct device *de=
v)
>  {
>         struct pci_dev *pci_dev =3D to_pci_dev(dev);
>         const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : N=
ULL;
> +       pci_power_t prev_state =3D pci_dev->current_state;
> +       bool skip_bus_pm =3D pci_dev->skip_bus_pm;
>
>         pci_pm_default_resume_early(pci_dev);
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>
> +       if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
> +               pci_pm_bridge_power_up_actions(pci_dev);
> +
>         if (pci_has_legacy_pm_support(pci_dev))
>                 return 0;
>
> --
> 2.53.0
>
