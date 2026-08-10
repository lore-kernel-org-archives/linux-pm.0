Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48AE3BB107
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359671; cv=none; b=qxSENMb3sZ1QOezGk0387fMQGDkRQhT1ZbNHRzbMzmEI+vYs+pcmGDF35GKZVh4xED59y5je7OY54PqIJCneiuC74l/wa4nY4r+hLQPixXVwawL8hEd34fT+keFvEEzOVpm0emHiIUrEp7WNkETOwe5iXxQY3RLzMPA05PYGBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359671; c=relaxed/simple;
	bh=pFfOm6QPUdjcAHRhW+KhtnVdVDxBYYj+3InpXS0SGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6onxQx0Kkq6dP8AkDU0xWPdxDMSW0xCAfAHaKPA5bR1/rJdoKy3OeRTvj7AxRaEIEfUcULHI7PZGVmBUn7vMEjaEnKI4tKti89bGAs4wsEjfdM3z7q0cnx5Cb6NvTdF3t6ahba1Zieb3wqf1XaTcB+EwG1EE4VXrHjuWUfev6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5X8L/4C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5X8L/4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87811F00A3D
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359669;
	bh=Gg7NYLihy0yhhoGsR6TvR7b81PTDY5aUKkDBFrt/+tI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X5X8L/4CV0NI0gipwjIo7SEuB6RexeMVNcYQK4+aD/43MYo5DUam+MI83JMRuiBRz
	 nC9oksx6sNZjgt/QxqQqT0yolTWgmo4uoIqp58duQqo73yoDUZfbYcYCKtQ6kzI7KC
	 8gSgjC/9/uIn+Ln58iGdmxGg0TfHSkh3JaauIgTjG7g1Mtphwi/ehG2Z68xeuMhmvx
	 5P+w9mO/32K117DtYbwL5SFIJxxbJh0nb7/zOYoT7NTLUAGU2mX914Mb+u89EP7n7+
	 YwJSr2T4HIEEufO/CuaDUsGw7X3xdnMRXtBCZV3r+vidtRWgNCWOouM0Dl4rjvEoE1
	 L9dh+Yqr5HcFA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so1487081e87.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 04:01:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqKkks5F+nptYpghGMAlS4kjvMAw7gJRPLk2QSqO3hesgcwEYbWHquo11rc1fT/vruEnklm3+dp5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK57JxrHGGRkADZk9XfNa+Dyn1XpVqI3HhPHkVzhpCHQy7XqkM
	WNRxwpVxXCRZg35NXnCrclt1BOgze5AsLEJL/SJFqXUuH5JxXtg5A6/J4PpNRXCKmpFx+edVwiC
	RtPgRfs6A1N24WV7h1dzk/FMiftrguVk=
X-Received: by 2002:a05:6512:1054:b0:5b2:eb46:1e66 with SMTP id
 2adb3069b0e04-5b3181a259fmr135671e87.14.1786359668218; Mon, 10 Aug 2026
 04:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7d85c5c6-3ee3-4ce6-aeeb-e4f15cb57b32@oss.qualcomm.com>
In-Reply-To: <7d85c5c6-3ee3-4ce6-aeeb-e4f15cb57b32@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 10 Aug 2026 13:00:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSKHdXXT0rQrj3Cmg4QZY_Bpp5H1RkWAJGTbeZQNYreQ@mail.gmail.com>
X-Gm-Features: AUfX_mwg0-vgqumwEaOjlKy_ovLo78wQQpdZS1sUlDCmHZeGALcltF4saxBWa2c
Message-ID: <CAJZ5v0hSKHdXXT0rQrj3Cmg4QZY_Bpp5H1RkWAJGTbeZQNYreQ@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Bryan B. Lima" <bblima@usp.br>, 
	Dan Carpenter <error27@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Rakesh Kota <rakesh.kota@oss.qualcomm.com>, 
	Can Peng <pengcan@kylinos.cn>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	Haritha S K <haritha.k@oss.qualcomm.com>, Pei Xiao <xiaopei01@kylinos.cn>, 
	marek.vasut+renesas@gmail.com, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andreas Haufler <andreas@haufler.info>, Pan Chuang <panchuang@vivo.com>, surendra <kr494167@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Aug 7, 2026 at 10:04=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi Rafael,
>
> please consider the following changes since commit
> 8cdeaa50eae8dad34885515f62559ee83e7e8dda:
>
>    Linux 7.2-rc2 (2026-07-05 14:44:06 -1000)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.3-rc1
>
> for you to fetch changes up to 55c16e15ff9f91bc994a20124b83faf27f0e3690:
>
>    thermal/drivers: Remove redundant error messages on IRQ request
> failure (2026-08-07 17:27:28 +0200)
>
> ----------------------------------------------------------------
> - Move thermal_zone_device_enable() to the right place in order to
>    prevent calling it if the thermal zone registration failed (Dan
>    Carpenter)
>
> - Improve bitfield manipulations on Armada (Bryan B. Lima)
>
> - Remove unneeded 'fast_io' on Sun8i and Armada (Wolfram Sang)
>
> - Fix wrong boundary when clamping the low values in the set_trips()
>    callback and fix wrong mask when setting the temperature interval on
>    Airoha (Christian Marangi)
>
> - Make use of the regmap API in order to support the Airoha AN7583
>    (Christian Marangi)
>
> - Fix adc_tm5_get_temp() return check value on the QCom SPMI ADC
>    sensor (Rakesh Kota)
>
> - Fix unbalanced clock enablement when the resume fails on the iMX
>    driver (Can Peng)
>
> - Add Qualcomm Master BandGap thermal monitor support (Satya Priya
>    Kakitapalli)
>
> - Add Maili Temperature bindings compatible (Haritha S K)
>
> - Add a devm action to clean hardware interrupts, sampling, and
>    control registers on Spacemit K1 (Pei Xiao)
>
> - Fix trivial typo in an OF code comment (Marek Vasut)
>
> - Remove unecessary print on Qcom SPMI ADC driver when a call to
>    devm_request_threaded_irq() fails as this one already prints a
>    message (Jishnu Prakash)
>
> - Add support for QCom PMIC5 Gen3 ADC by using auxialiary driver and
>    shared interrupt with the IIO driver (Jishnu Prakash)
>
> - Make resets optional on MT8196 and add the corresponding property in
>    the DT bindings (AngeloGioacchino Del Regno)
>
> - Fix clock staying enabled with the resume operation fails on Qoriq
>    (Can Peng)
>
> - Fix wrong closing brace position in thermal library header (Andreas
>    Haufler)
>
> - Fix low and high trip point validation by moving the check after the
>    clamp on the spacemit driver (surendra)
>
> - Remove redundant error messages on IRQ request failure (Pan Chuang)
>

Pulled and added to linux-pm/thermal, thanks!
