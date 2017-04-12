From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/3] power: supply: bq24190_charger: Pending patches
Date: Wed, 12 Apr 2017 20:18:05 +0200
Message-ID: <20170412181808.31768-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbdDLSSM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 14:18:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi Sebastian,

Here is a resend of my pending patches rebased on top of the fixes
from Liam you merged earlier today.

The first patch is new and is a bug-fix for the extcon support, this
relies on an extcon-core patch. The extcon maintainer has created
an inmutable branch for this which you can merge before merging
this patch:

git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-4.12

Regards,

Hans
