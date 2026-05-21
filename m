Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BEF3E7BA9
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370634; cv=none; b=SnJUCQFEobk6004AE++M+KOyCEY32t4b+rNSBYQnu+Vs/nBVGiaxMr7NXK/0zEuQzhW0PKNgfW7UDD+1APSISoj+D89sDxBTtSMAnKl5Rm9ZmwjzNmfDCtJIJUo3lHEZ3MeUQL/D1HgUg8SYJ+KWFbMCbH0jaRMQxFxMLI7CBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370634; c=relaxed/simple;
	bh=GVU7y2GRo+07J5gGxH+9wWWI8SU7wt0EySRNG7HFLKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ut2eMhdX7MxtxpZL0FLZlHEFJiDdQ1p2jTXui+c9zUVFNdbVzeI/FXlj8J0pFtZbXAnnVytnUSqxHjQI0ghuIhnyiP1+Ep5p1ejJYh30pjKxlGjN5R+oM0Q1otaFIXnWoZ5xn91WazXKxJhIbMQPCOa6d6FWwVlc5U47xn8LBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im6KKJtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im6KKJtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095471F00A3B
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370633;
	bh=voImLt9U33hBPjIQg8QhUUlnxhHKHG4IMiIMQPxp1a4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=im6KKJtgMb4dBr0758y++DUHqRCQPLHVVUbEDIZurXk/h4tKNFCtRwnYybXjidRcx
	 Uht9PhoCg73eIqhgU9CA4WROqN/gW/BeaS06xc08vDA5nvif82QsTaOfinbKbX94Pm
	 rmonx1jUYjJe0k0ZAHhPy8MvUMdXyb5DLYpta2aNXyd1muQK8J4hapvdfn1tO+CfuG
	 HoJObSYOflmfO+JcCQLtiLfax4IICV6Tsl1grXO1tnLqgoooriyEbclB2lfkgP9+UM
	 /ryPd98YK7OBsJsjO6FsyYaCAW3CmlwNSk8FxkFX5Wsl60Ch+TMaRNGjRseIaKygY2
	 aJQmi0y1GXKvw==
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c19d23b19so8318499c88.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 06:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HsAHobXNIEYs+f9E1VvtOActRO4Tn8IP+54Vc7NYO5vWMsUYQ6K6S+zhuu0AoG0m3N+WJUs8bjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVAakmV5wboEew5zJb3l8gM6RVvU2RznYjcEgY9Iau/sN80Ui
	2mVD2V0YfZYcDVU7NvbTp+NG7/3lXrjFES6/pCOjQ8jirW6uHGBSnEEbW4DUHroEly3MwldBXlZ
	YT/T61kylulTMTw0minueI7/RMX4fGKDiKzfOQVtIbg==
X-Received: by 2002:a05:7022:e997:b0:12d:de3e:be88 with SMTP id
 a92af1059eb24-13632f5dea9mr1288887c88.36.1779370632106; Thu, 21 May 2026
 06:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
 <20260521112638.GD2921053@google.com> <CAMRc=MfqaCjiALZyVBHQs=Taft1M9xmNTFvQHWPrd5PgcTfJDQ@mail.gmail.com>
 <20260521132419.GA3591266@google.com>
In-Reply-To: <20260521132419.GA3591266@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 21 May 2026 15:36:56 +0200
X-Gmail-Original-Message-ID: <CAMRc=Me5QS4xA3PJWXNuRP1N_C+w3sP9ZvqH36GNh2Ebc9hwcw@mail.gmail.com>
X-Gm-Features: AVHnY4LFH9UCgONPbT3gC0_YdCdFnqhHf3b94YzGu6vwiF1lpLEOG3Bm7uxIaYE
Message-ID: <CAMRc=Me5QS4xA3PJWXNuRP1N_C+w3sP9ZvqH36GNh2Ebc9hwcw@mail.gmail.com>
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD cells
To: Lee Jones <lee@kernel.org>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, Sebastian Reichel <sre@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> >
> > I suggested it because of its flexibility. The alternative I had in
> > mind is something like a new field in mfd_cell:
> >
> >     const char *cell_node_name;
> >
> > Which - if set - would tell MFD to look up an fwnode that's a child of
> > the parent device's node by name - as it may not have a compatible.
>
> Remind me why the chlid device can't look-up its own fwnode?
>

Oh sure it can, but should it? I'm not sure it's logically sound to
have the child device reach into the parent, look up the fwnode and
then assign it to itself after it's already attached to the driver.
This should be done at the subsystem level before the device is
registered.

Bart
