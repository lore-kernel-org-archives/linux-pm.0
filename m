Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F73E00B4
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859609; cv=none; b=KJztsXDqO8k7rIhk+9TQtkA/nBVLCinDWA+s1LzJshT83hYC5h1ObIDtDhJItRTHnbK6huFCYtzqHWC08TseNOEfrx7Sx2vBhIjFYR//GUhH2SAd4uM79WUyJ8tuUABd4LpCQ4rUeKua7RvyDv603wxNLjOioIrLPYw/FUizsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859609; c=relaxed/simple;
	bh=nSQhZQ6tGlBOmtUdwr13VWi2FIFZQeS4gjHokci/kyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSQ77ozKABGhJaiksu4/lnsyB6Wx7KZPIHiryyfY9umSsRODlLJE9KLno4s1B2sO4Q8f39/WMCnv2XIyHF1++ysRs3q1UjcqNlHlYct9A61SaABYTKaBkXse0RzmfIHpwriVuKDwwsmIbqQIhpT4qtuc6EtW2YPx/mG3R7duOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso387506266b.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859604; x=1779464404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkAu8P10dwihkNM39UctSZpVluViyWa9thhV649dqfg=;
        b=qxh1AV4zuyl5/fZd1mEYayW10MC02Zr0pzDhi2dC+nTUtyF41+Y90bhn7m6Qq20joP
         GZHm+q5TzeQJL0hzCsXMnx7ucWlhITk19KKP3qQsWyO2k1PQ96LtWvH3SqtxsIH1Min1
         5DxFHN73XWWaGizzGrjTcx/k6LIaPHFF3jtvfRueSAQN0ivIO4t0pXmalLhPB3PK/ruf
         j4bdbDK7FQQWOxlHZMlZP4IZ7JfaqSeYyD0CQq4WVuI74F5Kc2IQHl5qsoxu86eaZf+3
         uJN61dLCH6cE+6Tu0kcWcOiLsXJu66tE6RmPWi13XQd/c2FLVxxW49ephXEI3vWxH5aC
         OHjw==
X-Forwarded-Encrypted: i=1; AFNElJ/6MD+EA8L0/pb3wyDyxSPeGztoN2ulPcty3F0bYUgYvk45hF1fQcrbhWJDu/ebefIPeicq3NqkWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUPElTtemx4kYQcNV6rzHfRnQTXCv2dEA5er5B7onsL0yI5HEe
	ETkkrBYUS0m9nIIl28BR4Mn3FlQyVHZXzDQZZvyvvJT30gh05VKgJuiQ7c6s14CHjrE=
X-Gm-Gg: Acq92OF2azmFLiRITEmG9z8YLrtlIsilCV/hyIsP2GHC6oj+i47w9qAEcrOrXbqu1NW
	dTADs1Bod+f8y/fHAS2WYxifRmWKFfsLFJO/PIcPsNULAXz7/AT5B32INOlut31hPP70HA92kWX
	cOslGUNmEkvKmgcJG1hbk9FWrBehJ+vnJscbGPqWy9IPmvLn9YqjVkeqczfAqi6aktDiGHLmD14
	Cajx/rAonz3iWq8jRfJ2eCTNpImMydSakPBdqPH7FIeBm60xFm4A5ssJNYusLghbY/dZhlNC/zu
	XAxtTIo/nYQMzsZZJKwVJGX4zr9hxHvgZ/edST/vqEF/yxrY4DBTV9ND0veBQFKWvM06qzh/7oy
	JbhGc40y97mfiHdlx8Ei4Y7DoVuw8iImdNP4P0Ut1YZpWumyRUBcIdsVPRUfJO9G9vjV4uOQRcX
	bJsPG5JZnXvRdwVT7tf8L4awMibQeAnImFOfeRNacNqG4ySItxxN54yQhe6f2iS1RMgr9nPtk=
X-Received: by 2002:a17:906:f581:b0:bd4:8b66:c375 with SMTP id a640c23a62f3a-bd5177d0c3cmr248209866b.18.1778859603579;
        Fri, 15 May 2026 08:40:03 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c23feasm250305166b.14.2026.05.15.08.40.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:40:03 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso18718656a12.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:40:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9vtUvSa7wvUpX/4xoUmcPgNUVca6ZDubmDcpX/8mQd2N6dKOOguo7gsYpKOHYZvFnTfX582hYmnQ==@vger.kernel.org
X-Received: by 2002:a05:6402:e0d:b0:684:44f:d859 with SMTP id
 4fb4d7f45d1cf-684044fdae7mr1374876a12.3.1778859601770; Fri, 15 May 2026
 08:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
 <aekXUvIPb8nkhdKu@pluto>
In-Reply-To: <aekXUvIPb8nkhdKu@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2026 17:39:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8b9C3D8fV5th6GCgs6JAq7HZbF_SrOKz_gDy2H8ksow@mail.gmail.com>
X-Gm-Features: AVHnY4L73EskDuVnlvp0bKAJEo06GxthEmZ8mwHk1YJIsXaKqejpar7GeFZqJcE
Message-ID: <CAMuHMdX8b9C3D8fV5th6GCgs6JAq7HZbF_SrOKz_gDy2H8ksow@mail.gmail.com>
Subject: Re: [PATCH/RFC 05/14] firmware: arm_scmi: Add scmi_get_base_info()
To: Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

On Wed, 22 Apr 2026 at 20:45, Cristian Marussi <cristian.marussi@arm.com> wrote:
> On Tue, Apr 21, 2026 at 08:11:38PM +0200, Geert Uytterhoeven wrote:
> > Currently non-SCMI drivers cannot find out what the specific versions of
> > each SCMI provider implementation on the running system are.
>
> Thanks for your patches....this is not a proper full review of the series,
> BUT this patch catched my eye..
>
> Indeed, yes, it is deliberate that the SCMI version information is NOT
> exposed out of the SCMI world, since being the SCMI an attempt to
> standardize a common FW interface (as in [1] of course), you should not
> know what runs inside the black-box, it should be irrelevant...
>
> ...indeed the versioning is used inside the SCMI stack to deal properly
> with different protocol versions implemented by the server OR to apply
> proper quirks when needed, but all the rest should be standard....

[...]

> I watched a bit of the LPC discussions around this (from Marek I think)
> but sincerely most of those problems had one (not necessarily simple)
> solution: fix your firmwares AND/OR apply quirks in the meantime...

So let's forward to the future, where the firmware is fixed, is fully
compliant with the SCMI spec, and all IDs are stable, so no quirks are
needed.

Where do we specify the SCMI IDs to use?  Unless when using the
remapping driver proposed in this patch series, they must end up in the
DTB.  Existing upstream users put them either in the SoC-specific .dtsi,
or in board-specific .dts.

The SCMI server is supposed to expose to an agent (e.g. Linux) a
sequential and contiguous list of IDs that represent only resources that
the agent is allowed to use.
  - We cannot put the SCMI IDs in the SoC-specific .dtsi, as that
    describes all hardware in the SoC, which is typically much more than
    Linux can or even wants to use when running on a specific board.
  - You would think we could put the SCMI IDs in the board-specific
    .dts.  However, that would limit actual use cases later, which do
    not necessarily depend on the board solely.
      - E.g. when moving control of the CAN-FD controller from Linux to
        the Realtime OS, the CAN-FD node must be disabled in the DTB (by
        overriding status to "reserved", or by just deleting the CAN-FD
        node, both of which can be done by the boot loader). However,
        with SCMI, the IDs corresponding to CAN-FD resources must be
        removed from the ID space, causing a full renumbering. Who is
        supposed to update the IDs in the DTB?
      - E.g. when partitioning a single Linux system in multiple VMs,
        and distributing hardware across these VMs, all VMs need
        different DTBs, each describing a subset of the hardware.  With
        SCMI, each VM needs different SCMI ID spaces, causing not a
        simple partitioning of the devices in the DTB, but also a
        renumbering of all IDs.

Hence there are no stable SCMI IDs in DT, by design!
And what do we describe in the SoC-specific .dtsi?  E.g. U-Boot IPL
still needs real hardware description.

What is the stance on this from the DT maintainers?
Thanks a lot for your answers!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
