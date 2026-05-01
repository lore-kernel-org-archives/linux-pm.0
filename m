Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2D3A4F26
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639843; cv=none; b=cNt6OR6bw31gF8SBVxtwjPjekBCVXbUf4sRLSnvLhdiDNMt9FuV7KvQQscmSebyUgEE2CLmtgoXpL607fHwNL5jXK8bBlzDkVTfWh0PRHjv/JHcbcOMXF0yX8+9qSY2e8nDvfUoYRqvVaKFDrchII4lDF8JyW/KRPPh6XeyeZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639843; c=relaxed/simple;
	bh=6d+XYNzObxNK8kcRL+W7Rn3x9wh/i7CXg3NyKQjNICg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOs0tq4me+k7lVPa9HbsSJIMyha+8QXUOx952kbn4PMdLAsty58ypLeuRRICoppskjontb5R/JGZraG+oUzzN5nvqjNh4vANaVIbDHROGoCusU4RxPLIwGZAilxvc9Dm3kzfnL/KLNSeM+UxClMdkkRgfqhKF4qTMFvWAWY9rMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwgeOSwN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwgeOSwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E2BC2BCF5
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777639843;
	bh=6d+XYNzObxNK8kcRL+W7Rn3x9wh/i7CXg3NyKQjNICg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WwgeOSwNzsj29WDtcE1mS/HSpqxDm49Ki6Wh35yYgu2sMY1jdMvP7YPGuHCCFg0QK
	 psshTmr9gecrnfFazEd8xpfKMYuA8aB3l8IZhzfjnhClinJVlCqcsX4tngGxSQpWsP
	 MwxEhKDD95+OOJRWeWE3/FjkHjUzqKNG5kwCwj0UdrTqP97cI4P5FLGql813h6mMKu
	 HnbElXEGV3CjXwEqsXplw2kSzLk6v3CIqiIzTijj3jkJgaoLcwktJ6YOwmyWZHhuH3
	 3mtCZj5zwq3xgVEAeJLvRV6Rdsu5uxQ2W9IV2rt7zlOhsfcSsII8fUS/uaN6kUhVq+
	 SYltRbsLQAHzQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a85b30dd54so565891e87.2
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 05:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5oUxHVjSufRzAMEUZO2p7yjdaZpQFt+vKc0phf9CIXadrUC/pwInAR2y5JJDZqSz+k2wMk3v92A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlm2oaZHgEQUie7rrehFPo39c+3Z3eCrMaubvnXZVac0yrBWwH
	hZafckpnZn8tbKXRIZUtKY6EpXGvoLm2jsopg9ORJEnkaMJksL2E8dKiaawVVUzegsV6O5WP9H9
	zmqb3cGR09fkrEqvCvBJHQ4mD3sj0jWY=
X-Received: by 2002:a05:6512:1195:b0:5a4:496:5b9d with SMTP id
 2adb3069b0e04-5a8522dbc58mr2709876e87.33.1777639841084; Fri, 01 May 2026
 05:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
 <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com> <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 May 2026 14:50:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com>
X-Gm-Features: AVHnY4Is75lcHeqjktPD_iG7LrS1UJOnFheEfGOLNioGrZD80RF0qAgXlsmF7fE
Message-ID: <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in
 the OF code file
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: daniel.lezcano@kernel.org, gaurav.kohli@oss.qualcomm.com, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Apr 29, 2026 at 6:14=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
> >
> > The node pointer being assigned to the cooling device structure is an
> > action done by the thermal OF only and does not belong to the core
> > framework code. Move the node pointer assignation in the thermal OF
> > code. Consequently, the devm_thermal_of_cooling_device_register() can
> > call its non-devm version resulting in a more intuitive design of the
> > API.
>
> I wouldn't make this change.
>
> It adds overhead to the OF case that's not really necessary and
> complicates the code just to avoid using struct device_node pointers
> in the core and I'm not really convinced that passing a function
> pointer to __thermal_cooling_device_register() is so much better.

I would start with splitting __thermal_cooling_device_register() so
that it becomes (sorry for the white space breakage induced by GMail)

static struct thermal_cooling_device *
__thermal_cooling_device_register(struct device_node *np,
                  const char *type, void *devdata,
                  const struct thermal_cooling_device_ops *ops)
{
    struct thermal_cooling_device *cdev;

    cdev =3D thermal_cooling_device_alloc(ops);
    if (IS_ERR(cdev))
        return cdev;

    cdev->np =3D np;

    return thermal_cooling_device_add(cdev, type, devdata, ops);
}

where thermal_cooling_device_alloc() does all of the ops and other
checks and the cdev struct allocation, and
thermal_cooling_device_add() does everything else previously done by
__thermal_cooling_device_register() itself.

Then, it could be renamed to __thermal_of_cooling_device_register()
and the non-of variant would simply skip the np assignment (and it
would not take np as an argument).

You can deal with the devm_ variants of the above analogously.
