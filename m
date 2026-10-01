Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15073C457D
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841159; cv=none; b=CeY80Ns40CjPR9ik4LIaiJ18wG7sIcMijDWSDQtEhyQI3QZD1guPDRBVYa5edvbmQtmtquZ/RyYJYXUvaHU3uzCUYaV0qwsEp+Xq0pqF6cMxW2O06a0hlwvkW9zE368WAO2K7re1m9ISD6L26BB8Ytk1qsO9NKCz16KdPr51dQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841159; c=relaxed/simple;
	bh=TNWX3OiscYdEIgqQTdlMe6MVT+KT9Zr0Ks4fA9xYcc0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDNpwm7F0HqvJjmyKoG5VO8sR6b1hhRYoML/X574hhbgdOgEhqPbMW4bIW79BBgDx7k7ZVoqnqV+8zboHIiwB6e9b6N1PgWZdT10G5UwaJEiY9TIAiSydR1+pho3Wc2mxDEnkNswLh+A970i1N7I1cXhWU5XkvkrD7m2qkdmKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/2Ymtg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/2Ymtg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6296B1F0089B
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790841158;
	bh=TNWX3OiscYdEIgqQTdlMe6MVT+KT9Zr0Ks4fA9xYcc0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=G/2Ymtg64FfVIeozboVa/rvXddNL6pBVVvl+jqjzFkFlfeyvR07+4JdfpZ+p7viA0
	 vtRbtKLeazbYGoRmb7e47uFRx4gI8m2uiI7y1UJVy0cXHUhN1UBQFrDYUO14H3I3eC
	 8/3h6wXdgsMCNRr6S71CyqsvprgDp8mT4X/D2K1EVz2PEqi6CRDUQ3gmGlMo0ZcXlk
	 CpM7GY6DSb3t0XXnjpB2KaG0mffpYSl5+iS8IzL1WQMpZqzHCY6irgW/t40qiYPr6N
	 yRwr/dfenfY1K9udhOMLj9yG1hqXBTkZNxrEe/qb4CzV4S4xRUXIL4gSil/JwphfRK
	 3X9le4P0HfXjw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba390408cdso2420363e87.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 00:52:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzPOStuzVp7Q2lEfWGzy2Wa7/Zy7icCxf7++coAzAqxxnNKXwb7tlRXM5fjfD8iN9TdCoweDMMSJg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLawRXCE+oAeljisufvl/6e2k5aHPJJdF+QSxCrZY+hU/7x5JOH
	Li5mN52PSLHHFsRoTL0Fsi7Bv0uMgCN2Spb0yizyUWkjfep7dbvtljnwtVbdmMrIZ/uo53A3EHb
	m7VVPSe8Pqj4f1TvnO2LxoS8KtsBWExbHn3b9ygkBig==
X-Received: by 2002:ac2:5615:0:b0:5b6:1a7c:59d1 with SMTP id
 2adb3069b0e04-5ba405f88ebmr1216346e87.43.1790841157086; Thu, 01 Oct 2026
 00:52:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:52:36 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Oct 2026 10:52:36 +0300
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net> <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
Date: Thu, 1 Oct 2026 10:52:36 +0300
X-Gmail-Original-Message-ID: <CAMRc=Me4m2vR8qScuP5DzV-Q7x_q2qC3kkus1TbMDbmfarhFAQ@mail.gmail.com>
X-Gm-Features: AclHuK9lDtmp-6zlrLdql0EWyux__fuJev2I81mWG7n21T5kCqKjNHkMh7-kRLc
Message-ID: <CAMRc=Me4m2vR8qScuP5DzV-Q7x_q2qC3kkus1TbMDbmfarhFAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()
To: Alexey Charkov <alchark@flipper.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Corentin Labbe <clabbe@baylibre.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sep 2026 12:05:49 +0200, Alexey Charkov <alchark@flipper.net> said:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> PCI pwrctrl never did, leading to a memory leak.
>
> Add an explicit kfree() for the consumers array.
>
> Cc: stable@vger.kernel.org
> Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
