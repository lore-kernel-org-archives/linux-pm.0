Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525413D5236
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162562; cv=pass; b=Nq1+TmkObOb0kthExKNqxW1QrGUEKeffveo+8ktAyr/ylLE/rSfQ5zxbA28S7m9krywvyui4mu0855nn2MSFQbZ58Q8zYF6aEWN+tn5DKyXTamW8krdu/t60WQHr36XrIDzSwnIg0HnL1iYjLRs/JfEaAwcD1nE/vAQPRn2fe6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162562; c=relaxed/simple;
	bh=Ido82lTsBObPiLyE+cnbnYTa5RnXovthshiMl4cqqxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CulE61ZgCHzfDmllAtixnlRUnuN067wznvyZrGG4PIChXX87366Z9lwQPZDUThFYZ219b92qt9LbWcKtn8R0o+Au+fGAgde2+zLGj32yFU57R83GOpRSRMCr0oT9zu2EcbFmWULU6gBGhoiV1jErbAIQqmrC5hAZtimMokezPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAg1W+YC; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAg1W+YC"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2beae348eso5882535e87.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776162554; cv=none;
        d=google.com; s=arc-20240605;
        b=ShVHA1gE+9jxoiePRFTP9skubA0gI6pW4aQC89aPegDCE07DgDm4egWhlGXQ7fMxQe
         tU9pI43Az5oDzZt0QsuuG2uj1H1iNwI6vUztVvTQMlvcCKkjxBdTqpZhVj5Hj1DboqEK
         o9ImuA9wKqGIrYv08ajYPD4cRefMIiGUEzDWsom+oNZBktL630p+MQliaJ2rhDgEo13w
         JRZMjNRaMJ2U+10cf0Wu75UpoWNdxSAkOtJFJJlN8PkQ56c4KoX5DLYXfhSo2l9dXQkz
         Fi5tPZK2TWMdeIHJXLK5x3TiTEk7QXnU83Um7Q7aoAsu1kp50Qmp8ioFuiwL7GuwBkHO
         b86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        fh=4tUSCAFUqNzJfTlkAnOP+ntMsrChKrwZ9kesFoZD97U=;
        b=I3yQVWfO2TUEuNGPs23WMEHs+GSgRhjiGwqZCgG/yRbySR3FaN6LGdD6kk4OJXtfDM
         1XBQt643m6eybV1HKlH8r2QnEKKE6I/eHJn/dyLBVhqhXaZasF70BTZMYYgHQHLSEwxF
         VbNmL/b/3t7I50hWYziIQLIlX3JPS3uwDbRDIgaksxKs5qhRmUEeM+eLwZPGH31rRY19
         I56zF34z/pV0xv2DW4vwAY+favN383gIbfbeYmfBhutBBf0uCo0CZTAazUVnZoiMNg7N
         DZC+N/HPQ0LjHdcp96LTFM5ixImC6f4xYKldN7XOVSsMk5Yjm352mA1XpIRXvwWY5mMn
         cGzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776162554; x=1776767354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=CAg1W+YCDWa+7hMyoFTX9wrJnea3anbAiHdxWmpDFPNhe7kCyRPxDRCs4+n9KcUSjl
         w6nzvTJigwS7oM6UFv5A3HKxmii0VyJz1d3VSyhkRHh9KbLCHy+zvkfyRpySbb5xZhZu
         JuL3QYV3wyDOI2wfxl8ehTcAnuZZDMlWKsh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162554; x=1776767354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=i7MQ0U2BocBaR6/Lb+LeFpqJtvFMo1L/lPWxm88FhCsfGxAs1PxXdSCVark/zQT2nW
         fFlC4X5vLAlOQY1IJ/tEZUNRUUO/N3Axof2yVhg6OA1NYyvPTo8wFyV9F7eTNmROcG/Q
         ITjDwp07malYGHGkaQtjuOhM7RSyuEZgS50KUlqMg3uOsjyuaiXhQ2jHpm0c41rHGXph
         HM1ExFULemKYj6wxSySD28FDHpz7W/LvQ4ANDCxfyG1R84g6IpTd6lxuUlpNuOosLV1+
         yErHNEabz9x1UYXeVY3v/EoOspjlG0DqryfDsSzrOwBlQSEIlTzPhuL+T49zAKGOFWII
         topg==
X-Forwarded-Encrypted: i=1; AFNElJ8Qs8Uv+suHHfxFkVXylXsWqVk5am+dEtu6mYtG9wY+1Tq/mZp5wAFM2y8JH8GbHMj++ftRG6mFbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwocHWd/XqQbka3WQU2LZpKiGd2mcniS7S7KUiUQQUGcfcakf2E
	0QufzRyRfjp66Imz2VklsvGJK+LqxNmgK+k44Th7VUeDqDEYgnELappkzD5wLT0v6di0yrveFZX
	VOz9xwQonOU79LsLZV9i9+11+aUH+qHjoqXS1xVBa
X-Gm-Gg: AeBDieuOCwe5HtUjczSrRl7DquUoHeoxzYwhR1yB5SUpqR+HipTkpgNhzsIO1ZWgz0O
	OhV+13nm/XX+tE9xCKaVBeTx6vpTRrXwidFgLihoSX06/vQg8VrwWf/VMU2ngzBiwefJStappQo
	L7eZriqltwTPAb1J4KAdP3l93kGdKrGCxlmeJBXk/wnHBOZYPkUnReanRCx3HBpMaOxbpHdDpAn
	uKXfW3S3rlX7a+NsS2GVnGJgzcjtwXnXLcnwPx4zD/UefNYTsBTEFZhzA+9SFjU1DBhSuuFlgut
	RXZvP2qHgVTdVju+F0/NHhBRLBvJG15/GjHq3ussszjf5+nw
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr4850095e87.29.1776162554447; Tue, 14 Apr 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com> <ad36pIu-0dutL7Nk@ashevche-desk.local>
In-Reply-To: <ad36pIu-0dutL7Nk@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 18:29:02 +0800
X-Gm-Features: AQROBzDHB_HCwto4iaprIWgL7mrQWt62yIrtGAtxckKlX4EUkJwTT3ZqPu-YslU
Message-ID: <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam w=
rote:
>
> ...
>
> > > > > - Given that this connector actually represents two devices, how =
do I
> > > > >   say I want the BT part to be a wakeup source, but not the WiFi =
part?
> > > > >   Does wakeup-source even work at this point?
> > > >
> > > > You can't use the DT property since the devices are not described i=
n DT
> > > > statically. But you can still use the per-device 'wakeup' sysfs kno=
b to enable
> > > > wakeup.
> >
> > I see. I think not being able to specify generic properties for the dev=
ices
> > on the connector is going to be a bit problematic.
>
> This is nature of the open-connectors, especially on the busses that are
> hotpluggable, like PCIe. We never know what is connected there _ahead_.

I believe what you mean by "hotpluggable" is "user replaceable".

> In other words you can't describe in DT something that may not exist.

But this is actually doable with the PCIe slot representation. The
properties are put in the device node for the slot. If no card is
actually inserted in the slot, then no device is created, and the
device node is left as not associated with anything.

It's just that for this new M.2 E-key connector, there aren't separate
nodes for each interface. And the system doesn't associate the device
node with the device, because it's no longer a child node of the
controller or hierarchy, but connected over the OF graph.

Moving over to the E-key connector representation seems like one step
forward and one step backward in descriptive ability. We gain proper
power sequencing, but lose generic properties.

The latter part is solvable, but we likely need child nodes under the
connector for the different interfaces. Properties that make sense for
one type might not make sense for another.


Thanks
ChenYu

P.S. We could also just add child device nodes under the controller to
put the generic properties, but that's splitting the description into
multiple parts. Let's not go there if at all possible.
