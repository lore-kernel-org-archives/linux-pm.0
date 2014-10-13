From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 0/2] power: charger-manager: Fixes for unbinding other psy
Date: Mon, 13 Oct 2014 15:34:29 +0200
Message-ID: <1413207271-23836-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:22255 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbaJMNel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 09:34:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,


These are two fixes for accessing old power supply by charger manager
after unbinding the driver implementing given power supply.

Actually the source of these two bugs and the solution for them is the
same in both patches. However I decided to split this because fixing
this was quite intrusive and squashed patch would be rather big.


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  power: charger-manager: Fix accessing invalidated power supply after
    fuel gauge unbind
  power: charger-manager: Fix accessing invalidated power supply after
    charger unbind

 drivers/power/charger-manager.c       | 161 +++++++++++++++++++++++-----------
 include/linux/power/charger-manager.h |   3 -
 2 files changed, 108 insertions(+), 56 deletions(-)

-- 
1.9.1

