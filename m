From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 01/16] power: supply: axp288_charger: Do not stop +
 restart charging at boot
Date: Tue, 26 Dec 2017 15:29:34 +0800
Message-ID: <CAGb2v64ReFdDkweEx77SfubudGCdBXuMREGifWDud3CbtMRDiA@mail.gmail.com>
References: <20171222123754.9622-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:33702 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZHaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 02:30:00 -0500
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 1470C2776E
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 15:29:58 +0800 (CST)
Received: by mail-wm0-f41.google.com with SMTP id 64so33811380wme.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Dec 2017 23:29:57 -0800 (PST)
In-Reply-To: <20171222123754.9622-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Fri, Dec 22, 2017 at 8:37 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Before this commit we were relying solely on the extcon interface for
> cable detection, including to determine if a cable providing vbus is
> connected at all. This caused us to turn off charging at boot, because
> when we run the initial state processing the axp288-extcon driver is still
> running charger-type detection most of the time, so all charger cable
> types read as disconnected when we run the initial state processing.
>
> This commit reworks the axp288_charger_extcon_evt_worker flow to use the
> VBUS_VALID bit from the PWR_INPUT_STATUS register to determine if we
> should turn charging on/off. Note this is the same bit as we use for the
> online property.
>
> If VBUS_VALID is set, but the extcon code has not completed the charger
> type detection yet, we now simply bail leaving things as configured by
> the BIOS (we will get a notifier call when the extcon code is done and
> reschedule the axp288_charger_extcon_evt_worker).
>
> The extcon code is the only one to trigger the worker (outside of the
> initial run) and we can rely on it to only call us if things have changed,
> so while we are completely refactoring axp288_charger_extcon_evt_worker,
> also remove the code to check if the state has changed.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Other than the two patches I replied to, this looks good overall.
For the remaining patches,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Hans, I don't have any devices with this PMIC, so I'm unlikely to spend
much time on the axp288 specific drivers. Any chance you want to maintain
them?

Regards
ChenYu
