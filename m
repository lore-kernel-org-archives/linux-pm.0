Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6F27FB05
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248832; cv=pass; b=BJa3WFhEgUPkHNONQ75ltr+GtDUiPWZ+wRm2cgfQvhOc+UHk/W6ncI1THvsJdMxAmO9+MfpoP9MNmCQ3tDc1ze6n6oJEz8fsYFHL3xne+hbiFrB9LMMYkibOzOt9kEilarT1pVS/hx431pwZwwm/R97ZDocI6C4Qpm4trpagVyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248832; c=relaxed/simple;
	bh=IkWHCCFQX7aMDTxBgQKIawFEFZfCBBbHv2LydgIraqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0V+z6E3I82AjbRZKjK9vpIju555hwybl1l0vbzgaP+Q1mDg5afjOget8ItGpKPvaiSM+CSKbnUHrdwT1d6Flc82nT3QgzZot7xT4oQZfxCeXQXDvS3XYdWsbSt8JOI2YSqTk6lz8vSVnQBJYpw+FqsMfK8CIoMgug9jNPSRHao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oj4GuGzD; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oj4GuGzD"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e16f05fd79so7315427b3.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 00:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781248830; cv=none;
        d=google.com; s=arc-20240605;
        b=DB15v0/W1rrUGEewhMtsYHEqEljzT2POgJbhqm1OLuuOR9rSLKmjQ85zSFSUftnQ+9
         o7c5+Yt/JlJtukVioJlBmmStAAlqzIN/5szzKCnmaVa3T6DJLKdLi2ZJBqKa2C4IvdVv
         9Uzdtpc/Fu1Oz5L0PiH6iS0LGd8SUvJvr7/s9gRSwQXvpHV7qgYraDgNtmY6uXBji0FG
         s17KR7Zm8fBbGWSRrIeKzessV1y9aV78mIfy7GLO1eh973QhUTg7tGk5KHwwqdk+SrKz
         ETR5UH1O0KE4Fd4pHZ04gmD1pDIS95dMa9NrerxLAtLlk33Qy6JsJ81L+781jJ6508dy
         6r2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        fh=zXMP8cQWK0agwN/KlDljwYWC0hUjsJEPfeTu5WwtXzk=;
        b=ES+5DzO0TS5/fbTH65cFeRpz5o4jKoiwRsDUcYeZwwdV1OIThAQF96QFyukT/5lFxZ
         eGO+f5df1EiE/DHBSa5+8v10PkulkU9lguYTnD7pCpJlgDF7FodqNZque1q1dhVLrr7t
         yT6kwnLrVAXBTB2pzNfnw3SATp13w+lnOjlKZ/WcJkeGervJ+XES66Df+w5LKGC8IprC
         wZ1hX4nGoSxs4zEu4grE3iCSEMM4rijfcS4H9vHRK+lZe4irinEU9UMNHyYkowHYb3PC
         5dngf/8WQv8uhCqtwoYFWeldSjNwRKWiEhMcsZcB/5rLlpKG4wdsSI2vda1wep+GIPa5
         2XCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781248830; x=1781853630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        b=Oj4GuGzDu9GI26DqlprSNV/s5e3UxGAX3WAvF5EG3Eog+1hSTDfzsXpVg87iTTjNlf
         v8jWX1Dd+SPcZvi25Y2OkVchGb6xU6Sg8YfVmgsfJ99CLZH8s5qOmu3/P68rcrtYPtxS
         k85chdfol8gkgjb95XHASHkvZ+YTtvZKmW/tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248830; x=1781853630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEcj4bZjlu2HtgA6/DpQKuZoEr9jILxBgREI+9hl/bg=;
        b=cjkeIFFrruM6WB8mGZObwCqnOFtDuWALrnUOm7EtKYfPd9C+yrHxxiGtsSWxvmHJWj
         xYMgkD5FbQviA0YKhgkoE6H+PzGTfK2xwfpgJZwooxp30Kaw8WGW6h0a8bCkLgwuGAKa
         hdYBdFUx0BO7qCgrJgmLz8TcLVlTCVwP/NJC7DAoEbDULLOqx9WNd2321ocd4pTjSKxA
         dRkprQirTFeSif5XEQyi7V7DYdVWVoOLxUBLDyDXwl4+v8zwGjUiJtjMsnhNBYP0MJxS
         Zu32hwd9mRDKwbY1RnjErCGraOV5EFHUm0ngV/LNtbVVTEHQqGVqh3U6dOgnHa3u25kO
         hkIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8B3QDfGcN/irQ32kcXlCXLYxeIqgAzYgCKvayLQX0qPygrEL8eqO7t5B2CdVvwy4zV9HOH40wYPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyBxW/+7cQqRi+zk2SFE54VIMrpcmwgf2tGKDdjMMopkKK6u6
	JpDWml5GCAMjLOCfEeVgiuR3PGvLRsYKYEVEjjEBJg3PCzGP1dG7ZOEoUHnUMtthRmRS30IAG5J
	p8g/I8TsadiYeujBA9w5RdHeseg9IqVXeCHBvrNG9
X-Gm-Gg: Acq92OEKGQEZWr8M9upIupqHTy7MOOX8KobsWwLbZRHakQHFG/24O/OGE5Lpij+B/Yv
	xidpgalfm6TNHivOLApPG/+vsh0DCiQa2KMk8mClDVgQzEaWj0J5IrBwfrtsDifzyZmbwcN/2iN
	m2By2IYgMDnvOZlTHVq+FyhYXOIlAvOApf51w/5JoZvAcXA2gxn0MZx83Zotw4TbfmttPqDJRtU
	USghH5J09CAFESLmviyGS9RUwv5+wRLRjJ4XNnM8zZ8bgJ+dH/QtMbQhuulZTmWPolp+Fa/AzQC
	gc/K4Gza
X-Received: by 2002:a05:690c:c4ce:b0:7ef:81dc:c0e7 with SMTP id
 00721157ae682-7f7b6242881mr15277067b3.19.1781248829675; Fri, 12 Jun 2026
 00:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-3-wenst@chromium.org>
 <ailv8HpnrCH3Zb8C@ashevche-desk.local>
In-Reply-To: <ailv8HpnrCH3Zb8C@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:20:18 +0900
X-Gm-Features: AVVi8Cfix6rlRxpmlL_G61si3smqjEz2qk3oIH1X9DTqc3HutmT3uL6lEMZg0_I
Message-ID: <CAGXv+5EHHWfiWgqPpf-RMKoSQLc2cd9OA4Z36SNoL5C53kVh2g@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] device property: Add fwnode_graph_get_next_port_endpoint()
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

On Wed, Jun 10, 2026 at 11:08=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:36PM +0800, Chen-Yu Tsai wrote:
> > Due to design constraints of the power sequencing API, the consumer
> > must first be sure that the other side is actually a provider, or it
> > will continually get -EPROBE_DEFER when requesting the power
> > sequencing descriptor.
> >
> > In the upcoming USB power sequencing integration, the USB hub driver
> > first needs to check whether a graph connection exists, and whether
> > the other side of the connection is a supported connector type. The
> > USB port is tied to a "port" firmware node, and this new helper will
> > be used to get the endpoint under the known "port" firmware node.
>
> ...
>
> > +/**
> > + * fwnode_graph_get_next_port_endpoint - Get next endpoint firmware no=
de in port
> > + * @port: Pointer to the target port firmware node
> > + * @prev: Previous endpoint node or %NULL to get the first
> > + *
> > + * The caller is responsible for calling fwnode_handle_put() on the re=
turned
> > + * fwnode pointer. Note that this function also puts a reference to @p=
rev
> > + * unconditionally.
> > + *
> > + * Return: an endpoint firmware node pointer or %NULL if no more endpo=
ints
> > + * are available.
>
> Yeah, you see, even here is inconsistency with previously added kernel-do=
c.
>
> > + */
> > +struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct=
 fwnode_handle *port,
> > +                                                       struct fwnode_h=
andle *prev)
> > +{
> > +     struct fwnode_handle *ep;
>
> Unused?
>
> > +     while (1) {
>
> This is usually harder to read and follow. It's like "pay much attention =
on
> the code", but here no rocket science, no code to really pay attention to=
.
>
> > +             prev =3D fwnode_get_next_child_node(port, prev);
> > +             if (!prev)
> > +                     break;
> > +
> > +             if (WARN(!fwnode_name_eq(prev, "endpoint"),
> > +                      "non endpoint node is used (%pfw)", prev))
> > +                     continue;
> > +
> > +             break;
> > +     }
> > +
> > +     return prev;
> > +}
>
> So, this can be rewritten as
>
>         ep =3D prev;
>         do {
>                 ep =3D fwnode_get_next_child_node(port, ep);
>                 if (fwnode_name_eq(ep, "endpoint"))
>                         break;
>
>                 WARN_ON(ep, ...);
>         } while (ep);
>
>         return ep;
>
> But also big question why? to WARN*(). There is no use in the entire
> property.c.

Will drop. This function was lifted from drivers/of/property.c then
adapted to the fwnode APIs, so it still has the structure of its
origin. With the WARN() gone, rewriting it as do {} while() becomes:

do {
        prev =3D fwnode_get_next_child_node(port, prev);
        if (prev && fwnode_name_eq(prev, "endpoint"))
                break;
} while (prev);

return prev;


Thanks
ChenYu
