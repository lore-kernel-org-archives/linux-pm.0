Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618791;
	b=DeuPmXCg4ZpGgnUJEjX6epdAZsoKcNcWZoOhqfpxICMJYlMe3TsfukB5Aw4vfHNVh8O5
	 UBlbzAlBvX7EKujstvIbUKq5BOEg8OeDWcnpUMf6OS66+Q+Kuj/ENRKZWh5uax+t+Nm4x
	 5g5/J/6AFDIxNX5yTkXjk37PuSVCV4XjjxlSj2Fr12vu/YzcQhHMTZ5wXuEAQRCXJNz9G
	 UxskRaxmBgvMapk0yolR7F3wjMrsLrSLu0tpIZFRlbvydGMhBXfwhTwTjYHYKrztNx0MF
	 d/n3V4N6/7JdbqYDIHfU/MovbducjEVDzz8tn63Xk0EEwVj83u1WOdXM8WeyO2Ukmjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618791;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hlkk4xXsXyEvb1D9H1K80LoXoGwa5zP1sGDEDxlcUog=;
	b=xkTCMhOGzR1BMpKlbaVXnUJVz9Dybb/dKk8ylHuCCQdV3jQvhiwho3rt15qI4nqxQ4rA
	 kbhF+ap5pGTxNlfaVVVbgye5ehuO0/rF6W9Y9Rb7ee4XPKV2D2zwirAV37VIobhjboefp
	 EPhV5FvobPVX8IQyqg4bnG9HY7bIKSDI+70s62COfvc5Cx0rcvkoNFdIOMwasmGr59DsH
	 h7rHLTXBlqmUpVvAjOUl+X3IyvJzC7EAT9GNUCcJMXXKyQ8ZfYTNaihib+0NrVOVsocUc
	 VDMW/mtBBFUY8VpM0tUDWYmjjSaZql/XNnXsYJf1SvDR45Q1zTFjv/isHhFoQ5AMguA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E93606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E93606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-92182125ec0so1538206d6.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618790; x=1796223590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlkk4xXsXyEvb1D9H1K80LoXoGwa5zP1sGDEDxlcUog=;
        b=Bn5dtiFiE2TQftQdK0EW0z6DhsfZ2jEeNQvqyCuM05KHxM0GMze0a29ReYfXKG9hYD
         dOGPOS9zDYpjSJQZrSGQs+6nTKF5nhQHE5RASuhxp7uRALRUrtWB85w0jNLAx1YmUKp2
         J+NOPahBePa0dmTBrIkxW+e/9uIndT3ugGNqk3Blt7k/6xNifVvhcwWA7osoDqGZGtET
         Ql74bGjj4OJlYrKxKen2dES5wRW+q3kwrFfSi2T+80IXiKg7nOrXgSZZSv41YHH5wflH
         iDYs6OeZsVBmWZPykhWq9iEyoQJ9d+F0M+nNLT1q0nfY+jviTN0vQf5VY8T87Y29+AEP
         AXZg==
X-Forwarded-Encrypted: i=1; AL+hErHUuMTxZP8dsrhjV1E+z/1MKLZ5Ujh4UVXcBhW94J8P4zkiCwJWfRgMOg1LQH0lxvxZP562gqYKLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8V/MRETiCgOwA+4b2dT7TlP1uZtL9BRZNXnfQaQ9QRd1Ra/PQV
	uEGuBgxh6KXsuDp5py325Eodi7rpWGJzJvzLAJHFEPKVzfsfqpmd8kiIU+aB7tFW
X-Gm-Gg: AZFdTZc4IHw/sLRSm9WrYm8ZNS5OBcowtSxVzAJfAIbnP++O0LWyhhmTpgjyrosHRl/
	euirxibopmzGMDcg37vcLxRr4etFWUPLbiyeIWGl/AJ/wipmxVzaEbKxJYplgWHbXnJYdshFV1E
	T5M05g1sMOrownuFZrfQJp+FNcCyMXx84F1xPJvK2kKCkdeHDqcLe/T2t0Zjiih3E6O4L72y5of
	++9iM6za/HDPf16aRnVmtXr1kwQo8izfwsC0bCO9Yi6B7hONbq/9y4q0Ix0botfovijFPl/8iTu
	RzwHE/2yfrHjYBIJRabsVaxw98gY4T+Y81jbY9WbboH6AgVTStWJIiY6DCiWrGKt/5cea78lhtg
	NSsocG/bpWoZqp+VB5IKv39NkX/xUY1yUBeKFYNRjYzHZ9oANSWPknZe/Fo/bhDxZTxBzifBIhn
	IUJFlxHW60W/z5PSMr8cz6CU7z2job6GPFZfdPXbIqnRyWYCvywk2ASZm/10XsEO1FTFhkqhO3p
	T6fbVrBp03PzIF4w+ZGUUlNxevVy2JC3PigLtPjk/dH0Eb7F0pWAxsoaJvD/8j9f1a+3+sAbc3Y
	JFa2wAES//lPaEvNw2EjiY9+makOzwK6fUWPjruKN0cTlHjChJwLUB9/EvSx53RjmUdgRRc=
X-Received: by 2002:a05:6214:5091:b0:921:69ec:ebb1 with SMTP id 6a1803df08f44-92169ecec22mr102940286d6.12.1795618790190;
        Wed, 25 Nov 2026 06:59:50 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347966desm162099096d6.3.2026.11.25.06.59.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:59:50 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94958650b09so571488885a.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:59:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEGL+lf8mQfTj76nPyZb4rN6MROP02lGfJeaXJUVXlBXGHPfRRUU2+9fJDaDC1L7399f6Y4weCtAw==@vger.kernel.org
X-Received: by 2002:a05:6122:1784:b0:5dc:d0cb:7d74 with SMTP id
 71dfb90a1353d-5ee8adf3de4mr9944668e0c.2.1795618371669; Wed, 25 Nov 2026
 06:52:51 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795029012.git.geert+renesas@glider.be> <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com> <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
 <awAqqg6F2Z1t55x2@ninjato> <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
In-Reply-To: <d94ad9ca-afdd-4301-a69c-0bbad5b334fa@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2026 15:52:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX71k95powpC9qNiKdN=wRCYyYbvOT=EYmExE_2W8u3GQ@mail.gmail.com>
X-Gm-Features: Aa3M54re5ZNPOW-XITDy6yDteWVZ0ZL2EVGMi9yHMlXJRb9PY-Nvu_jZHjCd6J4
Message-ID: <CAMuHMdX71k95powpC9qNiKdN=wRCYyYbvOT=EYmExE_2W8u3GQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping support
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Paul Elder <paul.elder+renesas@ideasonboard.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Fri, 20 Nov 2026 at 15:33, Cl=C3=A9ment Le Goffic <clegoffic@baylibre.co=
m> wrote:
> On 11/20/26 12:10 PM, Wolfram Sang wrote:
> > Yes, this means the driver is then tied to a specific firmware version
> > because it only has this mapping. Not nice for a user. But we didn't se=
e
> > another way moving things forward for now.
>
> I think the DT is that other way.
> With the SCMI ids in DT, only the DT is tied to a firmware version, not t=
he drivers.

This only focuses on the IDs, not on different abstractions offered by
SCMI.

The latter leads to the need for changes in (many) DT bindings and
drivers, to support the same hardware blocks that are already supported
without SCMI in the same and/or older SoCs.  How many different DT
binding variants, with corresponding more complex handling in drivers,
are you willing to support for the same hardware block?
The remapping driver takes care of this in a single place, avoiding DT
binding and driver changes all over the tree.

> If a release that changes ids is already out, it needs a new DT, or a qui=
rk for that one release when the DT cannot be updated.
>
> The hardware stays described

SCMI IDs are not hardware description.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
