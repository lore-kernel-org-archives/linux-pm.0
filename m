Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984842DA36
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250376; cv=none; b=K6SWDM0h16fkW7YsvtU6JJckL3zL80Qkgtgd0VewO08Ee3aReSpRavYj/y9uI8dHrHJVo92SY0JxO/kY6QBrxKlwrhcklg1580TAK+WwZitj9G7vibZTp/MYY0WwBB3tL/ZU4lVivOW4G4MpHH9aW1WX05Boq3M/yo5j3RyTBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250376; c=relaxed/simple;
	bh=UKXw3nlhzFxoxJKUzXxgUkHYXWhUvYau+KO/Tskao8Q=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJoUYrndGtsZWpiXRojHVbe9rgDj7IBmbmnAmQgY0wbPbcozvhyLINQ2Ys/hwhchHS+UNhZ0W2djeyPa3ybvyFRZf9fRqm7zmVH6K/A3tYPxk1cRtaguVGZZDhZxnV7wKn5AfRV32xYH113GnJX08c0US2JcbE2mD5rGDu01QCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGSR4wr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGSR4wr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F331F000E9
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 08:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788250375;
	bh=HBmpv/kkFlJED2xyi2We3aIip3PLbNhKdHR6adYaq6w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=DGSR4wr7vG4DOE5LQp5fXQLm22woEM2CJP7IqR5xydptbatSxoFgcA5Oj+mgGQXkE
	 0rkMOshXkyt81tVbP8LnOobbQrV00XivAOst3JT66iN0rgiSAYSJ1AfNb4IWnpTf8t
	 zwZ1F76sH2qxug++ZQSfAPNNEz1xuFsbQwiB0sTmfuRbzD/P4g1ySp7oNaQbdagWXK
	 l+UEuKr7/avi6Eid6+VbdhZ0Fg+XRzaTCSovd67CWvHWjWyy4uGzWn0YIcIIgtbLw+
	 WLv/v7b9nwcdctPj+0Yo2yyxIzNnPlPJrYI1Met9lPR6UV9fVYAz1T9CJ2MA4V7lFF
	 h6lGYmG8CEVgg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b4ac3ba821so3691794e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 01:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByj7tipMV6YMJMqDK4oblQMSf4g1FEArhZsd5o6GJa/F9p1hdL7gEucRZBJebupwikicpJ+sk5LeA==@vger.kernel.org
X-Gm-Message-State: AFuF++nr1rr/lCpI679K7DCXoYAi2yaI3+DNXHDtCi/p4QOrufkh/5kh
	UJbKLPsEWM9Z/eeXC5A/9qeq+3Rn8RPOdircNv2emw1jZH9zPfUsCysIkDjs29f1zKkw2S+NwOq
	ApVkrm9gddS5S49OgmuQfVtCFZOgDkfmqLcMWnMrt5Q==
X-Received: by 2002:a05:6512:234b:b0:5b4:adb1:b25b with SMTP id
 2adb3069b0e04-5b5fe0d8420mr2844144e87.14.1788250373694; Tue, 01 Sep 2026
 01:12:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:12:52 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 01:12:52 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260827125906.GJ770273@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
 <CAPx+jO9QE_KG8BbfnMLTebDpGDj7OSpPDtgc9uTBGZCDJeLu_w@mail.gmail.com>
 <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com> <20260827125906.GJ770273@google.com>
Date: Tue, 1 Sep 2026 01:12:52 -0700
X-Gmail-Original-Message-ID: <CAMRc=MduBgkP4K3yabbDbZicWyb9WWqmF=yUqo+WHocE6hpiLQ@mail.gmail.com>
X-Gm-Features: AcwNN1URolqPxNp7OBkDyFKCbmiVpB4IqtdYvYItWVcsvGzePxbvMEDVrJj876Q
Message-ID: <CAMRc=MduBgkP4K3yabbDbZicWyb9WWqmF=yUqo+WHocE6hpiLQ@mail.gmail.com>
Subject: Re: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
To: Lee Jones <lee@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2026 14:59:06 +0200, Lee Jones <lee@kernel.org> said:
> On Wed, 26 Aug 2026, Bartosz Golaszewski wrote:
>
>> On Fri, 21 Aug 2026 14:59:49 +0200, Ulf Hansson
>> <ulf.hansson@oss.qualcomm.com> said:
>> > On Mon, Aug 3, 2026 at 11:45=E2=80=AFAM Shivendra Pratap
>> > <shivendra.pratap@oss.qualcomm.com> wrote:
>> >>
>> >> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
>> >> Currently, both the PSCI core driver and cpuidle-psci-domain bind
>> >> directly to the same PSCI node "arm,psci-1.0". Additional consumers, =
if
>> >> introduced, would also need to bind in the same way, leading to sever=
al
>> >> drivers attached to a single device node.
>> >>
>> >> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and register=
s
>> >> PSCI child cells. As the first user, register cpuidle-psci-domain as =
a
>> >> child cell.
>> >
>> > I don't think PSCI should be modeled as an MFD device with childrens.
>> >
>> > Instead, this looks rather like a better fit for the auxiliary
>> > bus/driver. Please consider using that instead.
>> >
>>
>> Hi Uffe!
>>
>> Since I was the one to suggest MFD - would you mind providing more argum=
ents
>> in favor of your preferred option?
>>
>> My reasoning for MFD was that it is indeed a device that provides multip=
le
>> functionalities, of which cpuidle is not really he main one even though =
it's
>> currently the only driver binding to this node.
>>
>> In any case, we'd need a "core" driver binding to the psci node and with
>> multiple auxiliary devices with their own drivers, we'd end up reimpleme=
nting
>> MFD.
>
> Ulf could be correct.
>
> MFD is usually reserved for real devices, whereas the aux is a little
> more loose.  Please consider it as an option.
>

My point is: if you start registering auxiliary devices from a "core" platf=
orm
driver based on real child OF nodes then you're basically re-implementing M=
FD.

At that point you're better off just using the existing MFD infrastructure.

Thanks,
Bartosz
