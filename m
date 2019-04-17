Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE17C10F14
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 02:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CD21773
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 02:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TgpkcuYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfDQC0V (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:26:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45436 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQC0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 22:26:21 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417022616epoutp01e4ae7aaa7d9f2211d79167298bb619ea~WIeIwiP7o2044220442epoutp01f
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 02:26:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417022616epoutp01e4ae7aaa7d9f2211d79167298bb619ea~WIeIwiP7o2044220442epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555467976;
        bh=UcP7A5wB7Mwv0P0IbEhWdfXFStd3seO8ML8sRu/F60w=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=TgpkcuYItc0XjJg7vyZdc29PJenWOXSfDPQiFiOBk+nEiY7jG2Qz/y8ppBynZTv9p
         hFu7ew+kkTzxKyAJSy8+FgTndOrZjgcURzUQKsDlxL1UIcPGWBNLrLsmNyLtRYnHnv
         awnbXxSGn+N8D50pmMeKFaV15NZ6oD6h9+P/Fb9Q=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417022611epcas1p27156ac92982e16456173121eacc32980~WIeDwBYRe2045920459epcas1p22;
        Wed, 17 Apr 2019 02:26:11 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-bd-5cb68ec26df8
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.27.04143.2CE86BC5; Wed, 17 Apr 2019 11:26:10 +0900 (KST)
Mime-Version: 1.0
Subject: [Pull Request] for Rafael, Linux-PM, from devfreq.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Lukasz Luba <l.luba@partner.samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
Date:   Wed, 17 Apr 2019 11:26:10 +0900
X-CMS-MailID: 20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmvu6hvm0xBk9nalm8PKRpseb2IUaL
        Ww0yFp97jzBarD1yl93i+aZOVoszpy+xWhy4OJHNYu7vCWwOnB6X+3qZPHbcXcLosXPWXXaP
        g+/2MHlsudrO4tG3ZRWjx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0
        ihNzi0vz0vWS83OtDA0MjEyBChOyM9ovX2UumC1d0bW1j72B8aRYFyMnh4SAicSTNW+Yuhi5
        OIQEdjBK3LjXxdzFyMHBKyAo8XeHMEiNsIC1xJPDJ9hBbCEBJYmGm/uYIeL6Eh0PtjGC2GwC
        uhJbN9xlAWkVEUiROHiWC2Qks8BWJomNO2+zQ+zilZjR/pQFwpaW2L58KyOELSpxc/Vbdhj7
        /bH5UHERidZ7Z5khbEGJBz93M8L0zpjyH2pOtcS16YvZQZZJCLQwSvSungJVpC9xZu5JNhCb
        V8BXYlHjO7A4i4CqxPfVR5kgalwkui9PAKthFtCWWLbwNdjvzAKaEut36cPc3LDxNzs6m1mA
        T+Ld1x5WmPiOeU+gRqpJHNq9BKpeRuL09IVQ93tITLyxgAUShoESa4+9YJ3AqDALEdKzkBwx
        C+GIBYzMqxjFUguKc9NTiw0LjJEjdxMjOI1qme9g3HDO5xCjAAejEg/vip9bY4RYE8uKK3MP
        MUpwMCuJ8DqmbIkR4k1JrKxKLcqPLyrNSS0+xGgKDIuJzFKiyfnAFJ9XEm9oamRsbGxhYmhm
        amioJM673sE5RkggPbEkNTs1tSC1CKaPiYNTqoHRQ/Fe6btp4tOmBphorkhd96FWrllHRlfu
        Z1p31/ZXVkfeTr0dKvyHvdjv9dzdJ8+b/WsM7Uzk5lu9zU1F4TmH7IN/D3rkyzZ9y5vAxnNi
        Xc7Dg/3zrB8v45thfjHvvkD8W9kTrLf+O3h98PSKuePn/siKf8EsgdNnDvfLnfvBeK3aN7yK
        f9UnJZbijERDLeai4kQAFunqWbkDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db
References: <CGME20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

Here goes a pull-request for next / Linux-PM.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2=
:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next

for you to fetch changes up to cf451adfa392bd9ba36f31659dbe6a5010b46ef9:

  PM / devfreq: add tracing for scheduling work (2019-04-16 09:29:18 +0900)

- ----------------------------------------------------------------
Enric Balletbo i Serra (3):
      PM / devfreq: Fix static checker warning in try_then_request_governor
      PM / devfreq: rockchip-dfi: Move GRF definitions to a common place.
      PM / devfreq: rk3399_dmc: Pass ODT and auto power down parameters to =
TF-A.

Lukasz Luba (2):
      trace: events: add devfreq trace event file
      PM / devfreq: add tracing for scheduling work

Marek Szyprowski (1):
      PM / devfreq: exynos-bus: Suspend all devices on system shutdown

MyungJoo Ham (1):
      PM / devfreq: consistent indentation

Rob Herring (1):
      PM / devfreq: Use of_node_name_eq for node name comparisons

Saravana Kannan (1):
      PM / devfreq: Restart previous governor if new governor fails to star=
t

Yangtao Li (5):
      PM / devfreq: fix mem leak in devfreq_add_device()
      PM / devfreq: fix missing check of return value in devfreq_add_device=
()
      PM / devfreq: rk3399_dmc: remove unneeded semicolon
      PM / devfreq: rockchip-dfi: remove unneeded semicolon
      PM / devfreq: tegra: remove unneeded variable

 MAINTAINERS                          =7C  1 +
 drivers/devfreq/devfreq-event.c      =7C  2 +-
 drivers/devfreq/devfreq.c            =7C 90 +++++++++++++++++++++++-------=
------
 drivers/devfreq/event/exynos-ppmu.c  =7C  2 +-
 drivers/devfreq/event/rockchip-dfi.c =7C 25 ++++------
 drivers/devfreq/exynos-bus.c         =7C  8 ++++
 drivers/devfreq/rk3399_dmc.c         =7C 73 ++++++++++++++++++++++++++++-
 drivers/devfreq/tegra-devfreq.c      =7C  7 +--
 include/soc/rockchip/rk3399_grf.h    =7C 21 +++++++++
 include/soc/rockchip/rockchip_sip.h  =7C  1 +
 include/trace/events/devfreq.h       =7C 40 ++++++++++++++++
 11 files changed, 213 insertions(+), 57 deletions(-)
 create mode 100644 include/soc/rockchip/rk3399_grf.h
 create mode 100644 include/trace/events/devfreq.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJctoG3AAoJEBOhurvWBoCK0EIQAI4FrdkJE3lHjsfyCeCxVlNE
8/G3PdY8FtqRjfjQGZnqjfXRb8yVrRninG2V2NVXEX/x4+P6MTqztnWFwF0CSrLB
PKTW0yjQzoD4qfu0bVxfD8Zy2iodJWtsVKyy8LnsWEMfZSxd/25+mJr/eIVHpQq1
g2ESlgbMIos1Vuq+NV0S4Z+oJXb7SMD/swqvSBVfebrE9WEsrwECFXLRcTxmb0ag
1YWx07g/DZ/jCN5OFtHrSsNtF9D7Gh/vNq5tEaIV9BzjYsiI1wC7Z3unVTUL1bKz
W8eL5Fkpi6b1w9+Ivb76pCbobZlzGI6YMBNzWQaaXoi85S+0DBkNeroOC2Eni+/1
7wB5krOS36aQIZJh/q1cV2k4Ekb2QV81BycDpSCLzIs8ACkHo7lNjIeLt56CGZQp
qo6oRH487SmH5MF2Q2kT6eoBYe8b/AjECpb69jk0JHD+6uwCCIKhmXIPDcTb73v+
x5pXhiQ8MH99IsUuaJ8LgCMxjjlrGfkbTzBhm02evsMV1gQz72oDtLzW5pqg9uFp
lBh54CgWp13hlm9UELgY44HYCcUk5mvB0R8w+hkBPyZY2IjCcEjeS6+xTVDjvYKd
KrnP0qYbx1+pZMdwwlkrqk1+UXMmdy5CHQAZRT4FgqxhgH3MDA2ObHV8P82ruQCp
ZmsWNOY1z6CH6Eiv8A2j
=3DWOOn
-----END PGP SIGNATURE-----


--
MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC),=20Ph.D.=0D=0AOn-Device=20Lab,=
=20Platform=20Team,=C2=A0Samsung=20Research.=0D=0ACell:=20+82-10-6714-2858
