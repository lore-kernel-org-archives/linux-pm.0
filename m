From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 0/2] power: supply: bq24190_charger: Pending patches
Date: Thu, 13 Apr 2017 14:04:10 +0200
Message-ID: <20170413120412.12773-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbdDMMEP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 08:04:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi Sebastian,

Here is a v5 of my pending patches rebased on top of the fixes from Liam
you merged earlier. Compared to v4 I've tweaked the commit-messages of
patch 1-2 somewhat and dropped patch 3 as Liam expects to have a better
solution for that soonish.

The first patch is still a bug-fix for the extcon support, which
relies on an extcon-core patch. The extcon maintainer has created
an inmutable branch for this which you can merge before merging
this patch:

git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git ib-extcon-4.12

Regards,

Hans
