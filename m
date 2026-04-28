Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B02DB79F
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362742; cv=none; b=Egx2BD2iPm0NLpRjj4vTcPSERtcWg9CjnwxIZN8Qa83IU3VBtc1TSCHQgMLv0l1lXUaQ60EBfFuTkEb7P/hxwcSP4619b+t+o3CWwxALXMPtydndbTZnGj+kTYdE2mQnlw075umU/mv1Rdmrpnpp8RiJRyzgaG/BFZ9Es5/BnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362742; c=relaxed/simple;
	bh=+7A9hGMrCf5qj6wp/qYnO4QPp5VlOkW3o6k4/MWiEsk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftfJprk5m6rJ+OtHceK58Wgh5Kdl6XHzTuXybKDrx0iOyKgDeJb2AmLxlSo5iRMyWoVVZxuuGPuimNt9hXP3U9/uQXKKzhmK/VOi22O8/qeFgDlkxpkj0oOQ5HjOQNMJ/rb+OXqx3/qmqfoBqz3qMEAhjRTajXZfA+Rfs4Y4G00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoCIMMKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoCIMMKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D96AC2BCC6
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362742;
	bh=+7A9hGMrCf5qj6wp/qYnO4QPp5VlOkW3o6k4/MWiEsk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=eoCIMMKyYiSuRzdor/l71p2rAcsfpB1EMt2reKfrgJ37j66rMJrcHhumrZfx0cX9w
	 9daLWO4AojV60ZG0IjWFR+RpTaHOa620GJEG9R3HNc6NFS1KCLVSFLNWZvFXrwmxLL
	 Xxc5TZ4dv0HFeiO+Mpi5KADFwCz2RVuyVe35A+kPcMydsmj8NByQomBljV5WX+ddIh
	 Ep+r/wCH5NbNfs+I8YUEcYe/utYM0cF9p/7NToAXjvkrZTfe5wEydHPYFrab0P1EMt
	 EeYIlXo/lT6mYPxOstcplZg32cduJrX+1ZZvVI8t61SVylhJzMJ2JkE2tdPmq4hPdz
	 8buYBICbFrAvg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so16941892e87.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 00:52:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxm2WQbRM8XLaealbm38OohQSmht+hJguXrEtHHCzuFm8JCOyv3
	osvK1/irCYDGc1Nc+2URIAElOeJ0CaZfdqIJJ31KPu4LHMLidKMADHhvZdwIS3QcNo9mHK8sItC
	Rc+uompp+e8yObAfpfUDHdEQ9N3Q3cH8SLOXaHJky3w==
X-Received: by 2002:a05:6512:398c:b0:5a4:1145:ce6b with SMTP id
 2adb3069b0e04-5a746610247mr877281e87.28.1777362741261; Tue, 28 Apr 2026
 00:52:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:52:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:52:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-6-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-6-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 00:52:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc-1CbmdkcpK+GO42zA91JD1bn4uty2Q67LCfdWZSjd6w@mail.gmail.com>
X-Gm-Features: AVHnY4IAeEz9DOJDqUcpSkV3z45GTKftIgb7vtFP5IquBk4MzrXKdkX87mZcNa0
Message-ID: <CAMRc=Mc-1CbmdkcpK+GO42zA91JD1bn4uty2Q67LCfdWZSjd6w@mail.gmail.com>
Subject: Re: [PATCH v21 06/13] dt-bindings: arm: Document reboot mode magic
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 19:34:46 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Add bindings to describe vendor-specific reboot modes. Values here
> correspond to valid parameters to vendor-specific reset types in PSCI
> SYSTEM_RESET2 call.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
