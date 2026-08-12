Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915F27FD4F
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523584; cv=none; b=m5ZBP7O6aiImbIQarVjNly2fGDqol9llXjcF+af+rAJbRrHgRwoOzgJBb+4r9hPKfj0q8Eggnso+5tCMmW3Z+pk3N/YW6xZurI05hq7S/YEGpNcoPF9gfT8JBPt3QMaZnq1yZzjiWK3j4ZIPNNspfaZxnw7ijJTKTthP+BkVFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523584; c=relaxed/simple;
	bh=59NaB9DJpc9PT2zjlAZDUJ2PEpr3NRLYiZ77p37FDlc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMFrFkQ3bbx4aBJ/D4kfVtjZ6TbLOk7e1oyYUTPqkiJF+p/RoJSTCAFS0jNIwDmbxK+6RUeoUaSm1R2hsRovOv4DeuNTkL+lfBz2IE7SrbE6vt+ENc8zlKQATnpg4SEERAMOUmmpqqEkLsVtftzRU0Xj/YtGHV+CAx0Ag7F+sCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buu0Mg8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buu0Mg8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01C61F000E9
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786523582;
	bh=D4fYTkdonNFudLiCicR5+qg8B8A7g4fsWwyZCZbxLtU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Buu0Mg8k5L6va2gl/TI+hcRlvayeuYJDbjhDtY/y8vyg/1BISPqu6/T3pKOETOOh8
	 RGYAMTgqxAQM5WZnPHeQ/lZGcteO5VZO0+Pl7kOMGTv34E8a77pIwRv/7rMf9N6ebO
	 2lmOUMVa+PPVw3r37rCFNrmyvYmrrKA0wewDTydmtlD/aFrAlDAMhITKJ9o3Zseduo
	 FVjwG9Xh262Pp3f8wNPkNWMF6yENjt/RLi+xQVufOGTrJl699X2VhkZZOqV/7hTOEV
	 gUd3fAoWxrpYx9OL2CMoc0DztTU5qIrIOxP/zRM3IOAkyUuGNGZPc2hL/HWqIqPW0E
	 2t0IjjDGEfoOg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so643477e87.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 01:33:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqBEvddfoAvmqp0Vuxzz+I8Bx30Kdl2unUtbea4YVjJ5DSQlRurB4tXdS2N17ycCsPBpJQvQOHmNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEpodwU8KhyanVotb6sYJT3cVOif2xaheXvg459jSpfdSJX1e
	84cU+EjxVo4R8/gWDObRdX7cqF2zMSzUHYFY4KR3Rftml4quFkBcMN8LGlGseyOLQjIvc5KB+d0
	I64TCKCYHbot+0NrJJs/h/815mF3s9PLNSz3AoskgGw==
X-Received: by 2002:a05:6512:605:20b0:5ae:c454:3746 with SMTP id
 2adb3069b0e04-5b44e315709mr317066e87.43.1786523571645; Wed, 12 Aug 2026
 01:32:51 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:32:50 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:32:50 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260812081856.GF1072730@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>
 <20260812081856.GF1072730@google.com>
Date: Wed, 12 Aug 2026 01:32:50 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me7Nua8xgKA43rCH9SV2DQoCyAuOqb+KNDTuPxv_H5y9A@mail.gmail.com>
X-Gm-Features: AUfX_myM-KKHFiWlmkYHiKUnznZQ5Xi8sRhpZ_nwB_pCgToX6LZLHX_mNL9495Y
Message-ID: <CAMRc=Me7Nua8xgKA43rCH9SV2DQoCyAuOqb+KNDTuPxv_H5y9A@mail.gmail.com>
Subject: Re: [PATCH v24 08/12] mfd: psci-mfd: Add psci-reboot-mode child cell
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026 10:18:56 +0200, Lee Jones <lee@kernel.org> said:
> On Mon, 03 Aug 2026, Shivendra Pratap wrote:
>
>> The PSCI "reboot-mode" node does not define a compatible because it is a
>> configuration of boot-states provided by the underlying firmware. With
>> the new firmware-node based cells in mfd-core, this node can now be
>> exposed as a proper child cell.
>>
>> Add the psci-reboot-mode child cell to the psci-mfd driver with a
>> named_fwnode. Add psci-cpuidle-domain cell first to isolate it from
>> reboot-mode failures.
>>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---

...

>> +	if (ret) {
>> +		if (ret == -ENOMEM)
>> +			goto out;
>> +		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);
>
> Okay Yoda, but why is this okay?
>

Hi Lee,

I'd like to call you out on this because making snarky comments on a non-native
English speaker's syntax is really not OK. Please don't do this. As a native
speaker you could have just proposed a better sounding version.

Thanks,
Bartosz
