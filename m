From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 0/5] thermal: fixes the rockchip thermal
Date: Mon, 12 Dec 2016 19:05:30 +0800
Message-ID: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33183 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932181AbcLLLF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 06:05:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>

There are five patches posted for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
--

History version:
V1:
https://lkml.org/lkml/2016/11/22/250
V2:
https://lkml.org/lkml/2016/11/23/348
V3:
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1281432.html
---

Brain posted the below patches for upstream.
89267b5 thermal: rockchip: improve conversion error messages
a0b5649 thermal: rockchip: don't pass table structs by value
That make sense to improve efficiency

Caesar post the below patches for upstream.
bceed92 thermal: rockchip: fixes invalid temperature case
30be6d0 thermal: rockchip: optimize the conversion table
35636e9 thermal: rockchip: handle the set_trips without the trip points.
That will fixes some issues in special cases.
--

Anyway, this series patches should can improve the rockchip thermal driver.


Changes in v4:
- As Eduardo and Brian commnets on
  https://patchwork.kernel.org/patch/9449301
- Print a better name.
- As Eduardo commented on https://patchwork.kernel.org/patch/9449313/
- remove the Brain's review for previous version, since the new version
  update something.

Changes in v3:
- fix trivial thing for error message nd return value.
- change the commit.
- Fixes something as Brian comments on

Changes in v2:
- As Brian commnets that restructure this to pass error codes back to the
  upper layers.
- Improve the commit message.
- improve the commit as Brian commnets on https://patchwork.kernel.org/patch/9440985
- Fixes something as Brian comments on
  https://patchwork.kernel.org/patch/9440989.

Changes in v1:
- The original Brian posted on https://patchwork.kernel.org/patch/9437686
  Note: it'd probably be even nicer to know which sensor this was, but we've
  kinda abstracted that one away by this point...
- The original Brian posted on https://patchwork.kernel.org/patch/9437687

Brian Norris (2):
  thermal: rockchip: improve conversion error messages
  thermal: rockchip: don't pass table structs by value

Caesar Wang (3):
  thermal: rockchip: fixes invalid temperature case
  thermal: rockchip: optimize the conversion table
  thermal: rockchip: handle set_trips without the trip points

 drivers/thermal/rockchip_thermal.c | 153 ++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 53 deletions(-)

-- 
2.7.4

