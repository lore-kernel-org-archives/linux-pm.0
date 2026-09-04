Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452403F3273
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532969; cv=none; b=tUC/PVm3apFEAVq8KdhfVRg53pdSfaKeyMgSfBwFur57jnk65h1JtiboBuUEevzVRho79nqZuuXf3/X6WmpPDnBx7HRDxeE47egzh9Vj7jmAQ0rbBNFtx8zugvNDoxH6b/b0vuFNFU4pQLjwrYPrJu5A3TNcybj67uTD5+D0Sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532969; c=relaxed/simple;
	bh=TcGIo92RiATa8vkGJVdjHgxt9WlzbewL1KtAW6cGFCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz5dIpPEdKTyrGu++49874nPAUZVso7Mdg7l7CeacW+wPt0xzV3Zk+tr5fiNsT/bn8Mvy3hVv/gPZ+J/y0YuIhHHLpiW9VjUWOkMcxvCpUUTZN1OmxQtG+D4kgfM8rnNPL3TA03X57+zt4cgiHPG+9Rg/c9CaHRiEFYE0Nv+md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c56dbc3a51so402334e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532967; x=1789137767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iy22q1YzKGiQPGN9B1bpmbrGTjC/sYmYXe5uXN4aXJo=;
        b=kXwexDKRkzvp7mlV4+AA1bprDLM4EIYDNwoud7LBEFgFj4CLMXsmxoFgwZstJbGzAW
         Yo151KNtg9prDW/05ftWqkxE30SEHWMQaXx/nxDOq9yS27wyf+/bN8vr11cmHhaDntJz
         ZpuJJfy45/wX0NZX9exileGfTDpIrTwCKrg78J7OQqQl7Vo0PwBIaNkC4fRw8BOGTARi
         MdqYo9HV/3VisoVnsxf/Wtvvw5NUTJ+zTthLw0o20hf5JsnmN7UIDJ3tYZF90bwBZDG1
         VCyqLvmmDD7ajfT02cRj9wPvyg86EGUoSx/QwLj7SM1JVpOFYJzpbzi+oWjpNhCzmpl/
         O0kA==
X-Forwarded-Encrypted: i=1; AKwUvBwS/3aItfW3t5W3uHgZooA2ZXNpjmiNFq4c5QUJMaxrsLkIwT2jfZTu4JbkgX2YXzmGIL8rQM3yhg==@vger.kernel.org
X-Gm-Message-State: AFuF++kku+WM6CHpMrF94Ghclih/LC9PNszhHKuZ1pdcI80jodcAAiHw
	A3Us3LTn83QP0nUU/jyqeT6oa1Eho8trARFS+EkKnkB6crXkWYAWn1wWO25D8b914L4=
X-Gm-Gg: AYBFou3wdTqF3+0/dyzYKJaGMAFSwjLO8SV/XryeMK0Dd+GuHsnoK6wvUrL668v3mwZ
	qNAHqBNMdrk5HzImDM9rcR3KZlD7XKAIyDIgArlrPJTI3ZE/TtQ80m3SQanEdNz1areUUAyUbyt
	tg8KjPGhhElID77j4EJU5v/7oHlyWwWVkyOXFB5nH/W+2pZqBoZyBdv32qtve8FbT7j/nAkAagP
	6oboHxx5nwItmAe4+QLbJ9oEn6PRaGD+SLZDNsSxMRy2V38X95DzPPkE6z9Pn48kZJRm3T02RPD
	I/08MVUFOCgHEI1sDmAGLQ2VgIDogLY775i5Z71sbMRRddYJ08PKPiykPHie11a8czQTYeCcT7O
	VDI/opio3hoA+O1y6GPC8IYjiqG6FUX6OYZhMjhxAzOxEYS7cX3BPyKQz4cBvNk9kbWq/0Vb+Ol
	mMXrH6vrYPmOgA7EDwQ6zTJlTRkCEA3E7E4CpVjwXwmFH0G12mLegup6flYyCRPOqWqqizCAAQa
	Fn5x3gB8qZBPfFmcNIb1Svm0A==
X-Received: by 2002:a05:6122:338b:b0:5c6:5fff:f2c9 with SMTP id 71dfb90a1353d-5c7ed41c953mr2825346e0c.4.1788532966904;
        Fri, 04 Sep 2026 07:42:46 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec25b9casm2186485e0c.11.2026.09.04.07.42.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:42:46 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-765c077b5c1so370693137.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:42:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxFvqug+7j2GFpGFnzRbDJ4heXCG/mTPY1ZB2SH65dlmVeiMdhEC9WPxV3bctx1VPcfw3EF0fVV3g==@vger.kernel.org
X-Received: by 2002:a05:6102:2d04:b0:785:eb33:87a8 with SMTP id
 ada2fe7eead31-78a4a883885mr1900429137.4.1788532960799; Fri, 04 Sep 2026
 07:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788338320.git.geert+renesas@glider.be> <2cf42d7ef9b452efbab3007ec2c2340cf87adbbf.1788338320.git.geert+renesas@glider.be>
 <20260904-fabulous-lionfish-of-cookies-0d614c@sudeepholla>
In-Reply-To: <20260904-fabulous-lionfish-of-cookies-0d614c@sudeepholla>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 16:42:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_u1ticUomZffY8iU2GoWgyTNDPaL2O6KB7yucr47dDA@mail.gmail.com>
X-Gm-Features: AcwNN1WAkp69Or55f6uh4v6WhdtMEG7Qz9QclhM1mQOZ0FBl4cYNnC9KwnYi2zM
Message-ID: <CAMuHMdU_u1ticUomZffY8iU2GoWgyTNDPaL2O6KB7yucr47dDA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] dt-bindings: clock: renesas,r8a78000-cpg: Add
 renesas,scmi-firmware property
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Saravana Kannan <saravanak@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sudeep,

On Fri, 4 Sept 2026 at 16:03, Sudeep Holla <sudeep.holla@kernel.org> wrote:
> On Wed, Sep 02, 2026 at 01:29:17PM +0200, Geert Uytterhoeven wrote:
> > On systems using the ARM System Control and Management Interface (SCMI),
> > the Clock Pulse Generator hardware registers must not be accessed
> > directly.  Instead, the SCMI message protocol must be used for inquiry,
> > configuration, and control of clocks.
>
> Why is this node needed in the devicetree at all or why is it not disabled
> so that any driver in the OSPM is not probed at all.

The node is needed so the corresponding driver can bind against it.
The driver takes care of remapping DT hardware descriptions to the
abstractions offered by the SCMI firmware when SCMI must be used.

> > Add a "renesas,scmi-firmware" property to distinguish between systems
> > with and without SCMI, and to indicate which SCMI firmware interface
> > provider to communicate with.
> >
>
> I still don't see the need for this if you disable the node, so still

The node is not disabled.

> NACK. Sorry if I have missed some discussions, please present the information
> as part of this patch in the commit log if not the actual binding itself.

That's why we have cover letter, with links to previous versions and
discussions.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
