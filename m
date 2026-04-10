Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E571862A
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820858; cv=none; b=p8V4gmNnAzfeOrq5XtqCHV3FpZgWcUb1AnXXs8mHvQR189AOUXNvOcprN7C9sZf4uyzNUoUs2XDxWZi59/mzWC/fQ4IFR01BvVQzHVwBpf2RwybbR6skR0l0/LYuD6b5FhkitfeuUZZY03Gh3XDTqApb9Qda9Ld9f/yXruQyIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820858; c=relaxed/simple;
	bh=iiXUh+8OgezdWY/5T7u2+h2sUQa9BkPxNx1OfFFb9No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPfxnN7RejwShqeVNB8iLsSo5cAClSMpPmu0LVqE/ttRRJPmJXp5A4OPkAcJn3m3B00vxUHKnqX7VnCrC/m5cNiqZpZruCGMB8dFawLoJCSlSAqSPA2GYw0l3HidpofP7N8MbceOmpgxRs9SY12zc9Ersr2D/rJGDa09zRTycwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHwOpAAK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHwOpAAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D0C2BCB4
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820858;
	bh=iiXUh+8OgezdWY/5T7u2+h2sUQa9BkPxNx1OfFFb9No=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AHwOpAAKVTNRFR+pUzymrFUAYt8cIsjCoXyZW+BE53TOaiDOlope2Lr6PRX2NL8Xp
	 hntUtHvpUHrHBWqk7sWWHtNbTB2uEVbHubnsCdsdgymlq6ThGtyYpSW1MiIBPb9gSb
	 +WzdU4jrdm2DpEdW32BCPgYM28LueLZCrDtLbyhDH7rvKGkvxAlYv52jIIOo0mIGJG
	 mGi+exZCSHZlXLvDWyXJF3glxtdT0bbUh5IzDBBo0V4ehZxD6IOQvHdb9R2axTv6ul
	 0Z1ZOzlFA824t/alE7eXi3rZ5qWW6m+fHOezhV5JtcXaK0b+otke6XhSe2eoA8zZ5+
	 BlhCOKuydL6Zw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-470145d7e6fso808581b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 04:34:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrHeal0D2lSFim85HF8A0o+XMOy7vr4TajeoxdT6G2C91tdHRkY4lxGDQW2THO2H9nmM+TRqleqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/nznzslbO+qFTZmMM/1vNbtMn6E8AqnH+OpFaxdS+3iHoUqf
	ttCrlhMRjITxo34JdPWsp/AB3hiyRPzXzEZzjN3SkZCkpRdnw3f1pvEotnhPFOdkRbuk7QQo9aV
	kfPDxgH1szxAWNxQZoBEBVS6pJR/8DZ0=
X-Received: by 2002:a05:6808:1985:b0:467:3f4:907b with SMTP id
 5614622812f47-4789dc473d7mr1470351b6e.7.1775820857092; Fri, 10 Apr 2026
 04:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <298af5b4-f008-4a09-a6be-7c0652392ea6@oss.qualcomm.com>
In-Reply-To: <298af5b4-f008-4a09-a6be-7c0652392ea6@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Apr 2026 13:34:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ioKJAD-aBs=8x=xSiLZk-uTKDfcJpaPZO4AEZnLkyNTw@mail.gmail.com>
X-Gm-Features: AQROBzCYYwNtdMbKDRds7rFck6qldRpwIYu5cGH-Vs-l8H0Ruk7K1CaE8P4IKOs
Message-ID: <CAJZ5v0ioKJAD-aBs=8x=xSiLZk-uTKDfcJpaPZO4AEZnLkyNTw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers changes for v7.1-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Richard Acayan <mailingradian@gmail.com>, 
	Manaf Meethalavalappu Pallikunhi <manafm@qti.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Gopi Krishna Menon <krishnagopi487@gmail.com>, John Madieu <john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Apr 9, 2026 at 10:18=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca8906=
81:
>
>    Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.1-rc1
>
> for you to fetch changes up to bf746e2a41efd98668c97759e06d436ae5af5a82:
>
>    thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entry
> (2026-04-09 21:47:15 +0200)
>
> ----------------------------------------------------------------
> - Added an OF node address to output message to make sensor names more
>    distinguishable (Alexander Stein)
>
> - Added hwmon support for the i.MX97 thermal sensor (Alexander Stein)
>
> - Clamped correctly the results when doing value/temperature conversion
>    in the Spreadtrum driver (Thorsten Blum)
>
> - Added the SDM670 compatible DT bindings for the Tsens and the lMH
>    drivers (Richard Acayan)
>
> - Added the SM8750 compatible DT bindings for the Tsens (Manaf
>    Meethalavalappu Pallikunhi)
>
> - Added the Eliza SoC compatible DT bindings for the Tsens (Krzysztof
>    Kozlowski)
>
> - Fixed inverted condition check on error in the Spear driver (Gopi
>    Krishna Menon)
>
> - Converted the DT bindings documentation into DT schema (Gopi Krishna
>    Menon)
>
> - Used max() macro to increase readibility in the Broadcom STB thermal
>    sensor (Thorsten Blum)
>
> - Removed stale @trim_offset kernel-doc entry (John Madieu)
>
> ----------------------------------------------------------------
> Alexander Stein (2):
>        thermal/of: Add OF node address to output message
>        thermal/drivers/imx91: Add hwmon support
>
> Gopi Krishna Menon (2):
>        thermal/drivers/spear: Fix error condition for reading
> st,thermal-flags
>        dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
>
> John Madieu (1):
>        thermal: renesas: rzg3e: Remove stale @trim_offset kernel-doc entr=
y
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: qcom-tsens: Add Eliza SoC TSENS
>
> Manaf Meethalavalappu Pallikunhi (1):
>        dt-bindings: thermal: qcom-tsens: Document the SM8750 Temperature
> Sensor
>
> Richard Acayan (2):
>        dt-bindings: thermal: tsens: add SDM670 compatible
>        dt-bindings: thermal: lmh: Add SDM670 compatible
>
> Thorsten Blum (4):
>        thermal/drivers/sprd: Fix temperature clamping in
> sprd_thm_temp_to_rawdata
>        thermal/drivers/sprd: Fix raw temperature clamping in
> sprd_thm_rawdata_to_temp
>        thermal/drivers/sprd: Use min instead of clamp in
> sprd_thm_temp_to_rawdata
>        thermal/drivers/brcmstb_thermal: Use max to simplify brcmstb_get_t=
emp
>
>   .../devicetree/bindings/thermal/qcom-lmh.yaml      |  3 ++
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  3 ++
>   .../devicetree/bindings/thermal/spear-thermal.txt  | 14 ---------
>   .../bindings/thermal/st,thermal-spear1340.yaml     | 36
> ++++++++++++++++++++++
>   drivers/thermal/broadcom/brcmstb_thermal.c         |  8 ++---
>   drivers/thermal/imx91_thermal.c                    |  4 +++
>   drivers/thermal/renesas/rzg3e_thermal.c            |  1 -
>   drivers/thermal/spear_thermal.c                    |  2 +-
>   drivers/thermal/sprd_thermal.c                     |  6 ++--
>   drivers/thermal/thermal_of.c                       | 20 ++++++------
>   10 files changed, 63 insertions(+), 34 deletions(-)
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/spear-thermal.txt
>   create mode 100644
> Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

Pulled and added to linux-pm.git/linux-next, thanks!
