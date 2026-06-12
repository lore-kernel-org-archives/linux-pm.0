Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09D292B54
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248036; cv=pass; b=Vo69qqe81FW5F3nY4XSKrbvxRdiO+oxKrSfsYfLd9xevZPfrjY/zMs6j4AZKssrY2+mHETgnTnciRQjjvfSfcNKkkkLCgwWT3OMSiXndo02e10kAYEvU3gpRac4MGMyWiaXvy2FSIGG5CeMwFEd1ybzk/UPEBwdib3fbLzUnd48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248036; c=relaxed/simple;
	bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3ecZUJjESh7kPREKEgwYSNTgliayg0eYxntL/yUqeLHGOYrQHYZLMnzSu/gs/KA2l9pri5PHzaUcOC2NVlb3/0H5hZK1HzgDm56wlBcklh1D5U6Ll28KuqlaRvzfB+Eg7l479xMUl0YhIPH74PPsujoS6Gxjgx3/vZhUNdEhv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GX6a316Y; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GX6a316Y"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7e2cb01a974so6856767b3.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781248033; cv=none;
        d=google.com; s=arc-20240605;
        b=YXvNKFzHCX2EqHypjHjZGEjNQwE1xhv/FzlsE7DjRQ7LMDoQPbvxscoAOdE4xdcqaK
         GhxRLO9rAdACXTi7oaVq169oTMvvOLClqx3w3dPNHVUPhsteSXxo1opmaQQ5G0C14NMt
         hE/v1zZJeHv0aWrAWpMltzSZ4G52/BxZXB+OfHWBOyEiCKJQIl3DDHJrPyvG7uO+H1Sl
         TJPsH29B9OmqTlwuRXeUPN10qDMDNqDkLaKosm/5TfHDqx/O/RWvsiUHWVAFuKdtkCB2
         QE6X75+24pqL7qkynUFgASYyM1UkmZ99AbdbmFF8RpRHaLku4dwiYoeLvwk2KrIteNP5
         qAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        fh=3rIbc/oYl3WzeFf1kphRO1tkZh0E7BYmDMrqh3JMEf4=;
        b=BksLVYj/BaHGJyRKctjnOdnu2KYH2CjaIXTLWxqxeGGi50pPILacvA1Mu/0TMH0s9X
         WOU3YgV4cLRsp8eSMVbRWPMO9LFe4vNqSTB9VFnSxo/bZ+bRxUEFnuUV8RvnVgjpjBQo
         bct3Oln5fl0U/NfjsxqfZ5/f3lnz2TSat/wVjpOLsFV2ovMjMVZTl5l/I2lM5blhAl/g
         Wg6CrtMJapcaR3zONPmw29ULeF3VJOh1Pgf2dzTalMT27AZutwSTNbWy/vFShPm1Im4w
         viUTe36QR+Uflrg+JpjRjLnXNPSFI3lp0gimHTEIxw8JzkGy3AFdOEKY8GpFnZLhN7Zp
         Dz3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781248033; x=1781852833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        b=GX6a316YJGltvP7NQQNtDlNb59sOQi88Gn9mV1Y8TuxfeZyuhU9puM51+9riltZKfx
         JHWs8YDubZD9ui4RTOdUsaFTPaj91O1gorrBEECB6BwQPfCHQz+vtI56oYtN5Xxwvhzr
         yDJo96lcZ6Yu/IHeXD9RRo3g9YtRxf78bYOiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248033; x=1781852833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        b=NWnSoZNEQrex5XtjfZW9zZ0Z7VTpkeLpu7NHlBhmyf0q/FuiS4Q6FBqTLM0PePeaiR
         el2guT6Jowx8zGKFnkaeKCdBij9pl3PQyCrzYttEx+VdHWNyzDoPapWgtNp737UDN2QE
         n+uIBFHsVCgwa/DDjNgOG1HYGFeSPL33JwUx+c8DWSIg0t7v5YdayzGo64ENSrIlbuL4
         hZDWZ8itddrxLX4Y78AFDWPylK0AfQE1DG/EbjIR6oeVBpJ9H8q6Ke5uSlP1B7ESkevG
         Jxuwr5J+0MVqoO5T5M3zJ/EIg7wxGlyQv1EY+4XKPlMhBolu6WN5719vpl/ibj8NGMT6
         bZBQ==
X-Forwarded-Encrypted: i=1; AFNElJ96pBouBfh2+AyNBoxs+jK1E/+ScBWYh3EZRI6O+7JCHDxLk3lML8Ya79w4yNZUo86HBxEOar/zDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6pIVZUulDtm1BNuRsQkCogpKCIZuLN3Dx7tkT3oGOf9Lfu3j
	IokbRBVFcxCYTsPFcTpy50m/lvhAxHxq0B4scnKlDXq5baqOWIIhGbYad/+ctw/7xr/WQKyfMg4
	IrLl74Jupu6pr/NA6pv4oM0p/ChiiPsEvDZ8WF+Tp
X-Gm-Gg: Acq92OHnn//UPZFeUC11G/EyFWIU3YtH4xCpY7g8Y1SZpnEsiawefy5kKGTEvaQh+GS
	ZssfFkbLXus9nJ/75TTrXp3avI2MZD3RtxUf73TmsKXDTdPQhgPN/RDlD5bsN6/jrFVTJvaGy0P
	zU6fC9IjEjYJR5NYfeOevL1UuawCut+tLgb34fP0zhf7/kzNG8OBThC8J1r81LJBOLRMrqBKaZ0
	yyTfmDbwFCdO0gmLN0x8O6v7UErd3nUHR13GyTZEw6yXovJbkaRtIFrphIOZp7pvBtrF6kk/pkt
	ZnD2rfKI
X-Received: by 2002:a05:690c:e3d1:b0:7d2:6b8:6e4a with SMTP id
 00721157ae682-7f7b6448b2bmr14221767b3.18.1781248032935; Fri, 12 Jun 2026
 00:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-2-wenst@chromium.org>
 <ailtMyYhbkOgaZWw@ashevche-desk.local>
In-Reply-To: <ailtMyYhbkOgaZWw@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:07:02 +0900
X-Gm-Features: AVVi8Cewi0jX5G3AwANJfv_JfU8wtj5jI6ryJrZRjeBtUWWvLVEyokylnfzsf8o
Message-ID: <CAGXv+5EZp0KvTqMde9da9mUWJyg+6X6Eon9Sqxx0VbikfVr8fw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] device property: Add fwnode_graph_get_port_by_id()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:35PM +0800, Chen-Yu Tsai wrote:
> > In some cases the driver needs a reference to the port firmware node.
> > Once such case is the upcoming USB power sequencing integration. The
> > USB hub port is tied to the corresponding port firmware node if it
> > exists.
> >
> > Provide a helper for this.
>
> Okay, if it's really needed.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > +/**
> > + * fwnode_graph_get_port_by_id - get the port matching a given id
> > + * @fwnode: parent fwnode_handle containing the graph
> > + * @id: id of the port
> > + *
> > + * Return: A 'port' firmware node pointer with refcount incremented.
> > + *
> > + * The caller is responsible for calling fwnode_handle_put() on the re=
turned
> > + * fwnode pointer.
>
> Note, the Return section must be last one in the kernel-doc. The last par=
agraph
> sounds to me as a better fit for main description. Basically check how ot=
her
> kernel-doc(s) in this file are organised and follow that pattern.

Will fix. I likely just copied it from the nearest function which happened
to not have a Return section. I did a quick look through and it seems many
of them are missing this.

ChenYu
