Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDBEE49A5
	for <linux-pm@archiver.kernel.org>; Tue, 22 Aug 2023 20:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHVUc2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Aug 2023 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHVUc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 16:32:28 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB43CC
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 13:32:26 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso8890245ad.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 13:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736346; x=1693341146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLyy3Q1H8KrLwXpWgraGaTRGriez2byM5532r5vLlxY=;
        b=Pl9mZW8+KBaohn2x8WeyVgipOfSqK7ujF3CibyUgwSW2ZP+URvMzhN+Fn7A70YZUUQ
         WI4Z0UORehBKI4j06uc2qskzTbIGyDv0cYstSwQ6m00M5AcSF8ogd0TLKiesyMdQCONa
         KtqdxF27TM6XeSEY8R4dbwShCnWs6Nz6wB82A2FJ10aBLpjOcNiR9D1qEvoWXjKsBG/4
         oPQpXPfOeLHYUxD6ycEFVJZpg4/9dr7K8MWOTxbEBZgamjpBPzWcFls5U1bRSxbp3BRu
         Wo5RzNDa8SUgBKkvyh5PM4gS9Y7XtBFVcQkNSbsTzmgWDeHaQ7JHeBsRve3JhZq1EzU4
         Y2Jw==
X-Gm-Message-State: AOJu0Yw/h2+Mb6tiFAwo1uT5QVAVEwUtMAf2j/hbwvCRjWRRP7N0qHLD
        W9KVsdgMvLxqJ5nDYNpP/+CY2jwZvsiPGb7fRl0=
X-Google-Smtp-Source: AGHT+IGe0ltRWTv26v8RgENHIjqkX2gM5Za4HZ4awrMhZMnA96WY8/DakG0IhXjQJLeOaVRwckUjNTf7VC/jsBUIZU8=
X-Received: by 2002:a17:903:1d2:b0:1bb:c2b1:9c19 with SMTP id
 e18-20020a17090301d200b001bbc2b19c19mr12211806plh.6.1692736346254; Tue, 22
 Aug 2023 13:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <CAJZ5v0i3DiLTcqcFbUqQaBcmA0epJz9m0QdSm+45kTepfuWdHg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i3DiLTcqcFbUqQaBcmA0epJz9m0QdSm+45kTepfuWdHg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 22:32:14 +0200
Message-ID: <CAJZ5v0hJ1qrj+MSLfgypSNkbx98W1UWn6GrHUcK+ZvyZhu4ybg@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Folks,

On Wed, Jul 19, 2023 at 7:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> It has been possible to submit micro-conference topics through the LPC
> website for a while, so please take the time to submit your Power
> Management and Thermal Control MC topic to allow the schedule to be
> put together.

Please submit all of the Power Management and Thermal Control MC
topics, if you have not done that yet, by the end of this week (August
27).  It will not be possible to submit any more topics to this MC
later.

Thanks!
