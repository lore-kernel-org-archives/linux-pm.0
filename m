Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368938F630
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175770; cv=none; b=mIAUYwWRXejITAwGuy7f7PilZO5rWLPLpe8/p8UxezqKtP+e2yBQfnK8UnU6uc2KC8TZTpijzpnFINS1N2n6oVFTwKCQ45/P+BAYxHUUjLIz8Dixfg2N/mz+MZn/46tZlY06yRwvze6GlbgOkyYw6pl8SaU3zo+FhcuJXuldXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175770; c=relaxed/simple;
	bh=qCzxaJJFHfprXQbh4vmH4wgYmFJYPzKzETaM7jXQlBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5KPwoqZjWGjCF5UforBDX9ZmfKyRTTJM/uItpvou6hl0eMWpfdc2gFAtp2ST0uD3jddlGfSC+oF6KcvxaVpKH2z3eS43vMghD7epQmiIj50mWYMTXgALrZwjU9groUKIUQDhg0n6Ol/79bAoWvlwoPg7IIHLjD9qgeKZqX8RQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7tQZmpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7tQZmpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE71F00898
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790175768;
	bh=qCzxaJJFHfprXQbh4vmH4wgYmFJYPzKzETaM7jXQlBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e7tQZmpc/tHQEy07WZhyEAyTFWB7a1IMF01kHmnd4maBvCD5EFe+nevyuOpjdQuxn
	 UUMxOgzmut6ghdtzyClLxICO2pXHeRyIfl67bfFRYfWOX6oV52F7ZQ5H5gzK21BjEa
	 Mwk4bP70XX9hIFDOOPe+RHQkOJsxecdKaw+0b9uK6bh7HB5dxEfrwdy6NUyurh+VAb
	 Gtbci4fKu5gxYHKXEdwzs+hzzd28ag5jZQuCbz7Q9+sq9iB/51g2z00V7v6CmC/n9+
	 PmjoS8+WF/kSJvzZDuWlXQbc9P++F6R3NLPdvAHPC5k/jaChNp5/F3T/IdSaJ332M6
	 kYfLLuEkh18pg==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a6124046f0so9634511fa.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 08:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx5TzA99/EUbuzXluP/0Icq7/byOZQfnT67iSjaiju/s0Pnz3XfBLfHLFUPHZYCYpX6cY9lzzcieg==@vger.kernel.org
X-Gm-Message-State: AFuF++lJJ5nhRFBxVOz8rpCC9tBZ4DysbKHf4dAowQY8mKHBwaCkWhHr
	//PwDj0Ud1TxcqBM7dwgxw38/EZDBqimIKJyaQlD+dNnHuEeDWUxJ+8d5/V16dz4rfsU9b8IAT9
	5eTXzm+PwsKiuzYNcBQgGzkUbwIxw+Q8=
X-Received: by 2002:a2e:b8d5:0:b0:3a4:99ed:beac with SMTP id
 38308e7fff4ca-3a630614d0cmr7434701fa.4.1790175766981; Wed, 23 Sep 2026
 08:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501165542.GA491695@bhelgaas> <561131dd-0e42-437a-9724-a036238a9bb4@gmx.net>
 <5f716613-d996-46db-96ec-6c0251219922@gmx.net> <449c834d-d115-4242-aa5a-43daa085f178@leemhuis.info>
 <81ac70ae-c51e-4960-8dd3-bed47ceafafb@gmx.net> <012b3ebc-62f0-402e-afa9-02712e67e72a@leemhuis.info>
 <86030fc1-473b-4695-a2f3-c30b5f19614c@gmx.net> <CAJZ5v0iw9Jrdv2MaCu5Dou3Ust5L-YsEMWDpZPP58-ag_pbZSg@mail.gmail.com>
 <e61e7c84-344a-44cd-ba99-53f23739a774@gmx.net> <CAJZ5v0im31nB_R5cL8QWMgjr4_cuoX482d_XY9bFCqsbXZGi6A@mail.gmail.com>
In-Reply-To: <CAJZ5v0im31nB_R5cL8QWMgjr4_cuoX482d_XY9bFCqsbXZGi6A@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 17:01:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hnDVzQoZSv9w2cd--UapwWrLr7R+hK5+gZKHUSxX=O5g@mail.gmail.com>
X-Gm-Features: AclHuK-skz_B-BkpRNH4pUyxow8wShQzSEmaWBJMxY9DW_q-o4f2W69-gNTriUY
Message-ID: <CAJZ5v0hnDVzQoZSv9w2cd--UapwWrLr7R+hK5+gZKHUSxX=O5g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add quirk for Acer Swift 3 SF314-56G (MX250)
To: Matthias Dittrich <dittrich.m@gmx.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:41=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Sep 22, 2026 at 6:06=E2=80=AFPM Matthias Dittrich <dittrich.m@gmx=
.net> wrote:
> >
> > Dear Rafael,
> >
> > i checked the patch THUNDEROBOT patch with "Signed-off-by: Zhai Can
> > <bczhc0@126.com>" I copied the format in my patch file:
> >
> > From: Matthias Dittrich <dittrich.m@gmx.net>
> > Signed-off-by: Matthias Dittrich <dittrich.m@gmx.net>
> >
> > The corrected file "acer-swift3-quirk-final2.patch" is attached.
> >
> > I hope this is ok?
>
> It's fine, thanks!

And now applied as 7.4 material, thanks!
