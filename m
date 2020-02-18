Return-Path: <SRS0=JpcB=4G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB22C34048
	for <linux-pm@archiver.kernel.org>; Tue, 18 Feb 2020 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F062464E
	for <linux-pm@archiver.kernel.org>; Tue, 18 Feb 2020 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582046112;
	bh=y7y/2uFhH+46BBtP5zDjE6H4fDuvmrC89I0sFFjdYSQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1jRJE334ymDvIYeZtgPNSf+K4OUjPXg+BbhkrCbqqO87V5e43NNr1jJHYYVHaDMgb
	 8tsNXQ7za5mxcMIcKRX09ld/77bs6eSRqGypdKLyXUEYo7QJShxb7110je3K+DYaAW
	 a5M/x9hU/yVEGOr083jfdQhObOhuYnlsjpzEQtGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBRRNZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:13:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34844 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgBRRNZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 12:13:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so20277730otd.2;
        Tue, 18 Feb 2020 09:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KxKWes5Maiiz92tj+onliCPmpibZ/Bkve3W+pNRz4Mc=;
        b=pPdB5Tm2in8T1907YMvR6CliDUREpPsIQjmcfrfC+segvsIdLzGRCjVJLaynod4Y/i
         yivauLepwRgD2x3AWvi9tiVrEwQSPbm575N9VfoCb/JrxLxlbDDhvMYM/ZStNkdn711H
         HF127XDj53mn4gRgd5qUmsoFjtiCdJXAbx6SeudM9gD6RTw6Eb4RxzZoZwZiSlkxrFjB
         t4eTDfd6egrl4L5lhgnoLb+E3KomlVyKDxq9gYIw9RyMVneJSUV0O8xh48N4jy5gNKbV
         DCHPEt7jU4QkNihapAHUGk4YHjWLJe/COl2DX1KDA/IPJta+risZA2Yd25U8wC5VsdWT
         LvHw==
X-Gm-Message-State: APjAAAWwkDcNRKv8WC/jVaskR9EZEVtde1acWJxTcgcs4jmvFPz0bTNz
        EUDxKbdZcOki1Ko4HW5JLw==
X-Google-Smtp-Source: APXvYqw78RKkguXMrAM7M8gSXlZrfkdWkZ4c6zf2HSWTeBKpVzryzLJxnnrYZ2glk4KBR3Pi24m44w==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr4047747otu.238.1582046003552;
        Tue, 18 Feb 2020 09:13:23 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:13:22 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Jon Loeliger <jdl@jdl.com>, Alexander Graf <graf@amazon.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Mark Langsdorf <mlangsdo@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        James Morse <james.morse@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        kvm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Subject: [RFC PATCH 00/11] Removing Calxeda platform support
Date:   Tue, 18 Feb 2020 11:13:10 -0600
Message-Id: <20200218171321.30990-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Calxeda has been defunct for 6 years now. Use of Calxeda servers carried
on for some time afterwards primarily as distro builders for 32-bit ARM.
AFAIK, those systems have been retired in favor of 32-bit VMs on 64-bit
hosts.

The other use of Calxeda Midway I'm aware of was testing 32-bit ARM KVM
support as there are few or no other systems with enough RAM and LPAE. Now
32-bit KVM host support is getting removed[1].

While it's not much maintenance to support, I don't care to convert the
Calxeda DT bindings to schema nor fix any resulting errors in the dts files
(which already don't exactly match what's shipping in firmware).

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20200210141324.21090-1-maz@kernel.org/

Rob Herring (11):
  vfio: Remove Calxeda XGMAC reset driver
  ata: Remove Calxeda AHCI driver
  cpuidle: Remove Calxeda driver
  cpufreq: Remove Calxeda driver
  EDAC: Remove Calxeda drivers
  iommu: arm-smmu: Remove Calxeda secure mode quirk
  net: Remove Calxeda XGMAC driver
  clk: Remove Calxeda driver
  ARM: Remove Calxeda platform support
  ARM: dts: Remove Calxeda platforms
  dt-bindings: Remove Calxeda platforms bindings

 .../devicetree/bindings/arm/calxeda.yaml      |   22 -
 .../devicetree/bindings/arm/calxeda/l2ecc.txt |   15 -
 .../devicetree/bindings/ata/sata_highbank.txt |   44 -
 .../devicetree/bindings/clock/calxeda.txt     |   17 -
 .../memory-controllers/calxeda-ddr-ctrlr.txt  |   16 -
 .../devicetree/bindings/net/calxeda-xgmac.txt |   18 -
 .../bindings/phy/calxeda-combophy.txt         |   17 -
 MAINTAINERS                                   |   14 -
 arch/arm/Kconfig                              |    2 -
 arch/arm/Kconfig.debug                        |   12 +-
 arch/arm/Makefile                             |    1 -
 arch/arm/boot/dts/Makefile                    |    3 -
 arch/arm/boot/dts/ecx-2000.dts                |  103 -
 arch/arm/boot/dts/ecx-common.dtsi             |  230 --
 arch/arm/boot/dts/highbank.dts                |  161 --
 arch/arm/configs/multi_v7_defconfig           |    5 -
 arch/arm/mach-highbank/Kconfig                |   19 -
 arch/arm/mach-highbank/Makefile               |    4 -
 arch/arm/mach-highbank/core.h                 |   18 -
 arch/arm/mach-highbank/highbank.c             |  175 --
 arch/arm/mach-highbank/pm.c                   |   49 -
 arch/arm/mach-highbank/smc.S                  |   25 -
 arch/arm/mach-highbank/sysregs.h              |   75 -
 arch/arm/mach-highbank/system.c               |   22 -
 drivers/ata/Kconfig                           |    9 -
 drivers/ata/Makefile                          |    1 -
 drivers/ata/sata_highbank.c                   |  635 ------
 drivers/clk/Makefile                          |    1 -
 drivers/clk/clk-highbank.c                    |  329 ---
 drivers/cpufreq/Kconfig.arm                   |   10 -
 drivers/cpufreq/Makefile                      |    3 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    3 -
 drivers/cpufreq/highbank-cpufreq.c            |  106 -
 drivers/cpuidle/Kconfig.arm                   |    7 -
 drivers/cpuidle/Makefile                      |    1 -
 drivers/cpuidle/cpuidle-calxeda.c             |   72 -
 drivers/edac/Kconfig                          |   14 -
 drivers/edac/Makefile                         |    3 -
 drivers/edac/highbank_l2_edac.c               |  142 --
 drivers/edac/highbank_mc_edac.c               |  272 ---
 drivers/iommu/arm-smmu-impl.c                 |   43 -
 drivers/net/ethernet/Kconfig                  |    1 -
 drivers/net/ethernet/Makefile                 |    1 -
 drivers/net/ethernet/calxeda/Kconfig          |    9 -
 drivers/net/ethernet/calxeda/Makefile         |    2 -
 drivers/net/ethernet/calxeda/xgmac.c          | 1927 -----------------
 drivers/vfio/platform/reset/Kconfig           |    8 -
 drivers/vfio/platform/reset/Makefile          |    2 -
 .../reset/vfio_platform_calxedaxgmac.c        |   74 -
 49 files changed, 2 insertions(+), 4740 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
 delete mode 100644 arch/arm/boot/dts/ecx-2000.dts
 delete mode 100644 arch/arm/boot/dts/ecx-common.dtsi
 delete mode 100644 arch/arm/boot/dts/highbank.dts
 delete mode 100644 arch/arm/mach-highbank/Kconfig
 delete mode 100644 arch/arm/mach-highbank/Makefile
 delete mode 100644 arch/arm/mach-highbank/core.h
 delete mode 100644 arch/arm/mach-highbank/highbank.c
 delete mode 100644 arch/arm/mach-highbank/pm.c
 delete mode 100644 arch/arm/mach-highbank/smc.S
 delete mode 100644 arch/arm/mach-highbank/sysregs.h
 delete mode 100644 arch/arm/mach-highbank/system.c
 delete mode 100644 drivers/ata/sata_highbank.c
 delete mode 100644 drivers/clk/clk-highbank.c
 delete mode 100644 drivers/cpufreq/highbank-cpufreq.c
 delete mode 100644 drivers/cpuidle/cpuidle-calxeda.c
 delete mode 100644 drivers/edac/highbank_l2_edac.c
 delete mode 100644 drivers/edac/highbank_mc_edac.c
 delete mode 100644 drivers/net/ethernet/calxeda/Kconfig
 delete mode 100644 drivers/net/ethernet/calxeda/Makefile
 delete mode 100644 drivers/net/ethernet/calxeda/xgmac.c
 delete mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c


base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
--
2.20.1
