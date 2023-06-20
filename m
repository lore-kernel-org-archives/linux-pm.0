Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE12EB64D8
	for <linux-pm@archiver.kernel.org>; Tue, 20 Jun 2023 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjFTRdC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFTRc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2023 13:32:59 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB427F4;
        Tue, 20 Jun 2023 10:32:58 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-987f13f8d21so107242966b.0;
        Tue, 20 Jun 2023 10:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282377; x=1689874377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AI51xZww4BuF4r8wG4yBPmYE1+ZW3VD0CqivSh1ga4=;
        b=BXqCEZWCHQC8XMBGBjW+3kwNeHK1OAgeuNOJLw8DNy/9i0ys743eOUJqLoSE7VmS/z
         zMDLt7+AsiYcPVgQWm7/iIjyDJdquToBds+jh4haM+Pn/O4axrKi+63HxISvy4SCDuug
         CvRNMdm5jVUfqVfNfxG8XEjQ6WvSmNnORp4JEEZ+W1OT07Gu95VfelmwuaIedZb7d19p
         jL3QPnZlaN5gw9jdcdzLnKpicvsVUiA5xokm1n7i8iNCj4rMPD5mGWdAyDPX7CYvp/pI
         iQjyxqSaiLAIJWlnemQK4HphYlhqSpTkUIGvG0/tsdJuGoWIHmgXEpbgpNwzq1gZXriZ
         lv6w==
X-Gm-Message-State: AC+VfDxdLPlSlCOgRG4ESo0vcCT1cW6qKNiFrmQ3XlnRA83JqWXUp+gu
        4TYrJYpVaEAJlaCe0J/SfmEclqYjLCQ2S5W89U4=
X-Google-Smtp-Source: ACHHUZ5QAtHoEsTTj0OV//8IjFN5WER6eismmqbo2c3amw803s4tCY8JXBvBI6ET1s858kT9/5/njhhncps7dCmUoRs=
X-Received: by 2002:a17:906:5354:b0:988:8220:2af0 with SMTP id
 j20-20020a170906535400b0098882202af0mr5508800ejo.5.1687282377095; Tue, 20 Jun
 2023 10:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230519032719.2581689-1-evalenti@kernel.org> <20230519032719.2581689-8-evalenti@kernel.org>
In-Reply-To: <20230519032719.2581689-8-evalenti@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:32:45 +0200
Message-ID: <CAJZ5v0ho-wpwuuObNOxjcicPycAdts7KCzA-Yj+zj4X2dCpJsQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] thermal: stats: add error accounting to thermal zone
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 19, 2023 at 5:27 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> From: Eduardo Valentin <eduval@amazon.com>
>
> This patch adds an extra stat to report how many
> temperature update failures were detected.
> Error count is increase whenever the thermal
> driver returns an actual error or when the temperature
> is non positive.

Why can't the temperature be negative?
