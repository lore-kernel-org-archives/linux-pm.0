From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 5/8] power: bq27xxx_battery: add BQ27425 chip id
Date: Sun, 29 Jan 2017 12:29:13 -0800
Message-ID: <20170129202913.32724-1-liam@networkimprov.net>
References: <20170129153512.eyaqj7mhuwlqkiu7@earth>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35122 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdA2U3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 15:29:40 -0500
Received: by mail-pg0-f41.google.com with SMTP id 194so95232221pgd.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Jan 2017 12:29:40 -0800 (PST)
In-Reply-To: <20170129153512.eyaqj7mhuwlqkiu7@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org

On Sun, 2017-01-29 at 15:35:12, Sebastian Reichel wrote:
>I queued this into power-supply's for-next branch. I fixed up
>the patch subject & description:
>
>power: supply: bq27xxx: add BQ27425 chip id
>    
>This fixes over- & undertemperature detection of BQ27425.

This patch is not a bugfix, it just creates a chip id for use later in
patchset. It probably should go in with the rest of the patches.

Should we roll it into the main bq27xxx_battery.c patch?

Also there is a cosmetic flaw in it.

Thanks
