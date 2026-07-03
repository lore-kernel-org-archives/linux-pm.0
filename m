Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40FC3D0BED
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081053; cv=pass; b=fLeHY0X0e1b4dhzrr5p7nR4ejemvnva+dXonYlapFRhUDa9Q1+NGiC+8ZcBLoGjZuu+QJ2jB+4RHq75+A2fsEYk+3XVcNjC//1pd+QUAjPUutkAXDQPvA0VUXUVLSBuxUNLTPuhE5OGkpKKQ/Dt1mFNybT5n3HCQ4glSD601it0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081053; c=relaxed/simple;
	bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfYz5ajsFrmvU3GJo4VoABHj5z7eSiUk6zSy8ZFhirCPK7/V01DTTTpQAvJVMf9weBFQ3JinWTPEeJ/rft3ZFTg+9mFbHsWGIGTtDFb7AL1wzmHYx0FGtRLaFIFS3WCpa17f7hGcXC6nBQXVcQYr+YBj4TjLablGQc3wqv/WLk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=La4rLw5G; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="La4rLw5G"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664d35b4777so573784d50.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081051; cv=none;
        d=google.com; s=arc-20260327;
        b=ci2PEJFCirUOlfwqWW4RCpujkz5dnEMmyGtuQyHwTmV5dfHIP81t2K1BnU0fNjsqWV
         gXnZDMBqGKsRR6o8l39hzJykyd4gdq+r53g6nIjraOFfQkJGkKYhWuLbBraojk1Rb/mO
         8UYC9WsFaz/ozbtTzKY46d90gV9VGN92sGIX+2/T8BfPH10WtZxmGyMV9W7Iwf7p2zS8
         y2QEayYds0UN5v6tw1mLDil/LuXmpIiK0/PlMbx+IqYBeoxhdcITjoE7G76xmpDUS2Zg
         baCVSfxRCWoZ5536nYVPNmU/d5tOnhLOtiuLd3n9PUYjjQtRWzQUQygKmv4HBWqDDh5b
         DuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        fh=qmp+uDQ7w/cu2CNHTGl07454qMUzPpYb5WB/dvSlZ5w=;
        b=A3MW+wC2xP17cJbvDd0ZN5ZnWq4pYrc/nMQElTEJXe7rA9WpVEK/Ueu1R7hM3yU6/A
         lcvB+B/LIX6jpWXXm/G8RQztRxHdnsaaghFuDjUcg6WRDd1PhqukI4j7uxYU78F0FWYx
         2z7fKEG85gTNq3qoI5yzfoc5AoVwmWOInfOaAt0ebx56O77hZ6n5WcfRzoLdItW4SGfL
         mcfffyX3s/TkIrDjhzjGSV5WaYAIrRv2iHRy+KACfaUyDTQL01Fcf/udJyJm8xenQiFS
         h7XdlS1UZ2rnojml3IlZa+PAjqsuwOxuxPI6vE2vCIlGCq2jBqbjY3y5QjNBCyaeA6yd
         /InQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783081051; x=1783685851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        b=La4rLw5Gf5gqClv10KJUzRgbRZWpkKExtGoirU0CX9a9jrQYpre1JYB5m/lZqJPlf0
         3cYEc+cCqrXzelFvrandfTJ1HTW1qcjS4V28uWSp/W6eKpaaI5WeEngCHPnPmiZ1hWWd
         iGuEVo1TxLdpP8k9+6p9LSymgO+vPjFK4hGRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081051; x=1783685851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wKIP/2g7MTxmMgVnWjjRdFjs9hik6bQNvbKXHobNWdc=;
        b=XzNE3/OaktIfdYPeEmlHs6BpkZfqTIVBBIOVJtfMSfhrDFe0sEEpuTOX95NHixndnh
         6oyC0IB14yJnfpMA83dFs2sfBE63eRwdyO/kV2oPqLESGUPAJ7ewBJbZeIoqtxsXHTt5
         QRiIj69cgnqwPzdoO952Eht6WHh5lIQinW/a1kbg1khpgwp7tHyHCqgIfoMxwO3hfZ61
         O5E7ZGEekj+jMlqWVE52EvWVfhH24kLGGT5ImUedFM6blKg0lrGpy4u2pkp6aiuu5MLt
         wtkG6g3+uCrpk+lgAz0hyBUWEe0cZW3o50rQV4V8+RqxcOkKc3NPNgAsX4ZhxLBaT/lt
         yW4Q==
X-Forwarded-Encrypted: i=1; AHgh+RoMofxwOZ621Q2LSczQZfGbkzwfqNN1ymE8h9BRWdZur2mg++ycg/cXcu+Udi7wzP9nlt+88f50dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKi/eN/fAXYVoOTK4+vk7NLcNZj4O/oVJ3iSfK5djnbew5GAjv
	6sZCRlDMA7Nvzq5tOdGqCVnPMq2FyBBkWBj9QESBvxJC6rjjy5WHtPzvvc+zwu9Oct8VexRVsNN
	Xy2YCY+9NKtaQYQ46emU0uPlhYfuEXslMUFLDcHiC1DiCufhWILo=
X-Gm-Gg: AfdE7cm8z3sq6wC9SEfOa/D83MwurB1qiPXufr9dQhwlccqzkDli0hn5tYEBgPsmE67
	9ab922pJ9PqsqpbG7EzncUVMIdZYr9nbC44M+W/04dr60k7KVYTaFjCmAmsOvffC7dSbvV6mwEW
	Zz1H6+i2MmK6zATE7/SoPuFPtGoncWvhgL15f2bh3Jsa6oxfNLxs34QK6fV0JHvFFMhjdc1PfK5
	e9G1cJFr2D/7ROQU/+csFewViEAhqtHhzBf/TIclQUVXGeSIzRNYvGhGx6HjVRsg0uf/RgKKDZY
	HpWaD/NU7zQuPAzYbMDrbyFRHO8=
X-Received: by 2002:a05:690e:bcd:b0:664:ae03:524e with SMTP id
 956f58d0204a3-6652195244emr9486423d50.6.1783081050982; Fri, 03 Jul 2026
 05:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-4-wenst@chromium.org>
 <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
In-Reply-To: <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 3 Jul 2026 20:17:19 +0800
X-Gm-Features: AVVi8CdRG77FVnl6YqrCOnoh5pU554e35My8Xh7iayyOJ32J-OMwjYcWxPxxPu4
Message-ID: <CAGXv+5HMVaERvte8YJDJ0fq0zoMvO7-7caAGQhsAB-9sUHoGtQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 8:07=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Fri, 3 Jul 2026 13:03:04 +0200, Chen-Yu Tsai <wenst@chromium.org> said=
:
> > The power sequencing consumer API already does power on state tracking
> > internally. Expose the state to consumers through pwrseq_power_is_on()
> > so that they don't have to reimplement it locally.
> >
>
> They wouldn't be able to do it as the field is private to pwrseq core any=
way.

Which is why a helper is added? Note this is returning the requested state
on the consumer side, not the actual state.

> In what situation would consumers need this? Typically you know what stat=
e the
> handle is in if you control it.

Mostly just to avoid extra tracking in the USB port device. For the hub's
port power feature flag, the hub driver actually queries the hub for the
current state; no in-kernel tracking is involved, i.e. the consumer doesn't
actually know what state it is currently in.


ChenYu
