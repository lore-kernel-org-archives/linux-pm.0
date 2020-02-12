Return-Path: <SRS0=mnou=4A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B513C352A4
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8EA20873
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 09:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="No83RYQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgBLJEB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:04:01 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:45316 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBLJEB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 04:04:01 -0500
Received: by mail-pl1-f176.google.com with SMTP id b22so705640pls.12
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 01:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gRnbs9UyfGjvIhynZ2KVS4IHtfYSTjBz7Uxnflp9deU=;
        b=No83RYQ5WXmqUxAtV/DbkdJ742GjayOW5ooTSd2Ahiv8cV+xq8uvbU51Lyf+DVSgCB
         OMob3+p0NjXL8Gv7cKBiWoVgDiFL+vKUbR6ekgIojtOrqgLHAYVsJFprObVdfYxdvEJ0
         /IZty0pcQhdZyUthceSRL04SmiwayyZfOs7DvLLeJgvxYGymfBuBscpZ5Yj/KFoJHj68
         yvdnFaj7195LrjMh9188Q9hraC0kZ81UGG9ZbwFyGCsIXNqZIPl1bZgrZJtnzVxQIYfL
         Wp048yq8MWFpZZmPYT5DjpXuFJa/gmnQnWHQ+SndErjnS2bmXLhAZz/a2UvCMvmluaSE
         cgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gRnbs9UyfGjvIhynZ2KVS4IHtfYSTjBz7Uxnflp9deU=;
        b=PHGG5yj3yO8Kj2TSeXh7ElRed0AoB69sw3j8NjeUSXV3/RGRXo1vZUKWnWzcH9Q+MV
         Uv4SSI1WzLV89JHT7cUR5M5MAgMABC8XOKipflKqGnIJjbKOkXttc9Qcxg+1yE7+Uo7c
         LmIRWP9gGvDGLpMBMM2kTeWT/8zEFaCZ3g3DWy/WtWSLLaRZoSEG2DLRyl+k0GRwpCCv
         7iNvwaKGuFdc/zV/kR28yuS/JIBLmvpUYsTaD0lAkOj60boXukLvu5f/4ILRCFLOF8Rd
         mdOguZVzfzbkYttU4MVZfKilqrQcQC6yvKGvIL/LgWvkVuaza5CCC8m6iZJ+LdzMGpPa
         CqSg==
X-Gm-Message-State: APjAAAXz2qY1yGb/oy0BLtUOsVT3qJ3USh+vKHOCdrJ5gEyVU8UG75U7
        NvDCoAJ/X3o0DXqqXxvrxN/hVA==
X-Google-Smtp-Source: APXvYqyWsFhWjuIclAiFWmBBhY2Gb5f/tFGJL0ji9ZTiqepHu132XIMinaueCci9NIJAUiGmUSt+ng==
X-Received: by 2002:a17:902:b484:: with SMTP id y4mr21819287plr.126.1581498239335;
        Wed, 12 Feb 2020 01:03:59 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id d22sm7037640pfo.187.2020.02.12.01.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 01:03:58 -0800 (PST)
Date:   Wed, 12 Feb 2020 14:33:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / OPP: Add support for multiple regulators
Message-ID: <20200212090356.x6aieuddym5zea5d@vireshk-i7>
References: <20200212075529.156756-1-drinkcat@chromium.org>
 <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7>
 <CANMq1KA1=LTtCD2ic7GcskX7izuEkAqUo1xxwwCXBeTLi0r5vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMq1KA1=LTtCD2ic7GcskX7izuEkAqUo1xxwwCXBeTLi0r5vg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-02-20, 16:57, Nicolas Boichat wrote:
> I see... And you're right that it's probably best to change the
> voltages in a specific order (I just ignored that problem ,-P). I do
> wonder if there's something we could do in the core/DT to specify that
> order (if it's a simple order?), it's not really ideal to have to copy
> paste code around...

I will suggest adding your own version (like TI) for now, if we later
feel that there is too much duplicate code, we can look for an
alternative. But as of now, there aren't a lot of platforms using
multiple regulators anyway.

-- 
viresh
