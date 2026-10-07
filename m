Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA49408600
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410349; cv=pass; b=cvAoCkvfTM5nMA3ehSujF1HSUGJdJTct75b22LadkZjr6m18ZoJHRYNgw6kSyEksvexmMOIF/l96mohGlwEUoVHcPeCNYyxGog3gliqV+Lb+oyNRvWB8U7ifmxIqmZjYIBWjRokIogluF6oNvPcM04McLOJNaMihQl4xz6JjDt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410349; c=relaxed/simple;
	bh=NdpHyiQEK20ZJUkrXWW8lkNpvrkh/Tq1SrhZFgg2dxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGlqh0R/ZnLD1UHljtT/jGAZwB6zZRfXAUajr5QJo1GIGJ7C0q0Lth2O+u6wtWHw0UTX3FJkOY22G1Q796qM0HANuhX3iy3bp8rq9DXLhUpCQ2qdGy0WVIei6v4DbnpZ6NqlsLf5I2ryJfJ4rdoq5CJ17qB1AGih1o2rFiuGoso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=K6F154/d; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="K6F154/d"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2e2db5e8e4so765064466b.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 14:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791410346; cv=none;
        d=google.com; s=arc-20260327;
        b=WzVHHAnTBG7q1xIaCCi6mgYFX/CpUAjEAA6G14T/p69i/g5tuZL0qBi1GZ1c1uKlb7
         FGvwpXFMGvNP9kIbjCKNg4bYlFgr/LTovD8CGxDiskUq1He9ggaIMg9s1Pk3oz3OrMrE
         5DOhRgT+oQGfHXzyr7oCppqk3RAJGlXyAQjdhGwCgGiCKQdiglIB4QG2XWiZXGjNYk97
         ke5VBKUr7qu0NmmdKz8P9VFMkiJazSagGzl+OSB2OnU0wvFz0jeow9Dy2wm4ls2dzEAZ
         OS22M0Yw+Dlex/IH6KmAac+LwJLwkl0upo8gKk09PSV60su1Po02+eV/dai5RxjVrOOp
         C3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTupLQqOTwq3jH2ZB+au6HoSAz3uNI5sbJCpfgUjYak=;
        fh=565sIlDF6D7UUQksXf9S+Ty9Ij1wnEe5zVgegBfsfPQ=;
        b=Jbd0gxTEhCjSCU/DNKwJxbpgHg+UQVLRUdEgYW+KIx4Sw+/g6eU08DDG7IEiK0/6Q9
         D5dewla7ZImYYEPjRCxCyJIyIqF6JK7DmbjY2zudRnjKXXLDtqomrJ2bpkX0szWrkPj0
         NryTnHhWFqGipwQ+dv+bnTmhuGGTW3QGAZOy8e3A4nv0oZbiHhzoJlNhiWoC8cZtLtrd
         jamvaHxIY/U2dttHgQMMZFwTRWIXH6LGmT43GBCeLOTQcdpLFRT9c1hXHbprf50Rlhr+
         4P4aREqoW6iOyOuFGgZpfAksL12WeGOdlpscHqba70jcXA4t2A3o3lF1BBgYNU8QLl9P
         9J5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1791410346; x=1792015146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gTupLQqOTwq3jH2ZB+au6HoSAz3uNI5sbJCpfgUjYak=;
        b=K6F154/dH/kooP5BOsLg7rgu5qE8VoRb28+/aNuZpnEpw0lM1KSAQ6DkMWyNBHhEBf
         GZiW3IXZiWIpy/9qc4fuQM9n6MYZOmoMwQfpuDAxHuK2TNEqPSREmOJLUmO2ogrXj4JF
         DBtXCu3VhHpX4my6zYmFxJoBIYF2ACGxya8FTbfXZXgwgnirO0jMxTexip47BCNPnEP+
         Zi48FERJjhw7AwGZiBiim+6gbFznxH62uAn/YWu+kZfOgReSSI9kEAIHxpdoXygZQOyO
         P8oEfpCyzpEcGmgGCUFgmqkFXwtEh73CDjcjL0K3QpdfGETYlQTCGTm3Fa8edo9RpZ0i
         ishA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410346; x=1792015146;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTupLQqOTwq3jH2ZB+au6HoSAz3uNI5sbJCpfgUjYak=;
        b=IMwas5ELCZ0FAUqccPdRKiyH00XTKelA7wYjxUxUqdES4UsluG2g4j91GCMozhufv9
         WSXgm+EsSvi8HqdNicxgaffPluXMVDhcyjgzHimCVxdq1PcGpvojFKAk/73kWer72Dbr
         FWpyNY7DklcJEuXEeGQ4tOPxsAF/+JfmBrrlmFXcD/UKOdY5kTgQwKjMLax4l9wYnZrL
         CtP9tvCCxF6cDjAh2NQ1rxhi2xNThkYNhiAlTatNjytn/PsmJd9DcaXdXVsZDZNor0fo
         PTfkUKQTJOeBrc2NWIWm4TorKqa/jdEsqrgk7pIpkc9U9nQkGLTbjXC221w8GOARxl+d
         vbjw==
X-Forwarded-Encrypted: i=1; AKwUvBwjMgHSwSAvvwa2YAqhmLiZPEVqNXNb2t2Tk6HNYKtXKdhuvG8Z3jGnjxs2Dp5lUy6U2IpVfVtkWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lYQSR0tVJ3tKuA5dWCVBjkyxlKwHq3uDtOMSd+wpB2COp78BEO
	rjOdL4WSA4VOAeOGXCBh7GBmzyJEWpJjqNhxhIXI8XDo7GQ095nQRiA2/b/lzq9sK8aW2j9+oaK
	eUkaAzSLlJlabv253WyxiuUKe/BXifkOmXE8T5f8uKA==
X-Gm-Gg: AYBFou1zT5EpO/OWZI9I11vOBzmx7sJubJ8cxoeYUoVJfuJcfvRQulFO1URe+Hr0GCf
	5/85XyykBoHMXuEbRZ9bTRPBVHTdpj0xeYRlfQmgTfTOLO7O/W19UdkDr8Nw7THBuCS8RIOfCMI
	eWBywcqKW9eoLxT9WmGQMHwMR1oBGaBqJry0ymx55rqBo4eVr3IpejeroO4hRJA/6ju8BZBiOqO
	hVutIg7t81k36JQ+pEtkf1kPK2CfmM+rjm8+oaaisxa5Tb7+UfLuVmAj1nLHJ75VEZAwVm421vG
	7nGR0dofEvAqUbOJKAwdly6KK9rFUfAq6F78xfT4vHJqBA3wMAAlf+NGE+4IH3Rb14Y=
X-Received: by 2002:a17:907:3d52:b0:c2e:7daa:23e2 with SMTP id
 a640c23a62f3a-c317c18cedbmr350164566b.48.1791410345894; Wed, 07 Oct 2026
 14:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
 <20261006-b4-rk3576-reboot-mode-v3-2-6edba064693b@flipper.net> <20261007212432.GA381404-robh@kernel.org>
In-Reply-To: <20261007212432.GA381404-robh@kernel.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 8 Oct 2026 01:58:55 +0400
X-Gm-Features: AclHuK9YQekpwAgg-J06h9HjpyEEerPcos0qnPQI7GTm7jMZgcXE5m4c13MgYQo
Message-ID: <CAKTNdwFo03jFGMeJQpxXp1yOX+cG+6BZOYf1eGGZTdZWAFdz5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:24=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 06, 2026 at 08:02:40PM +0400, Alexey Charkov wrote:
> > Whatever program that acts on a reboot mode runs before a full OS, so i=
t
> > may lack the capability to enable the regulators it depends on, and a
> > reset that preserves the mode register generally leaves the regulators =
as
> > the previously running system left them.
> >
> > Allow a reboot mode node to name such supplies, so that they can be
> > turned on while the mode is being requested.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 =
++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboo=
t-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-m=
ode.yaml
> > index 79ffc78b23ea..5ed70c87269e 100644
> > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.=
yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.=
yaml
> > @@ -36,6 +36,14 @@ patternProperties:
> >    "^mode-.*$":
> >      maxItems: 1
> >
> > +  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
> > +    description:
> > +      Supply that has to be powered for whatever program acts on the m=
ode.
> > +      That could be a boot ROM with no access to regulators, and a war=
m reset
> > +      leaves them as the previously running system left them and not n=
ecessarily
> > +      what their expected out-of-reboot state is. Any supply described=
 here is
> > +      enabled when a mode is requested, and stays enabled.
>
> Sorry, but no. If we allow this, then what next? clocks? power-domains?
> GPIO lines? The list is endless. Maybe if a not generic binding is used,
> but still pretty much pure configuration.

These are the resources which are required to handle the reboot mode
request, they are not exactly configuration. There is a limited and
hardware defined number of IP blocks which need to be powered for the
reboot mode request to complete successfully. In my case (Rockchip
RK3576), these are the IPs that need to be made aware of the trained
DDR memory parameters: if they are unpowered _at warm reboot_ then the
boot process stalls immediately with an exception (cold reboot is
handled by the power-on default state of the PMIC).

I see that this may be abused to hack around what should be a
bootloader's job, so it would be great to find a way to explicitly
limit the scope of these - though I couldn't think of one yet. Any
suggestions would be much appreciated.

Best regards,
Alexey
