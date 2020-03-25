Return-Path: <SRS0=knII=5K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63788C43331
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 09:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3776B20772
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 09:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585130278;
	bh=VBlYmGDntmPnOzTL6eabTzbRIvqY0qeVA9siIV5zk+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J2LcPU8hD6fLJK8RE8yPG4Jqdvuv6Z4GKjCUEOUPHKx/Zup1NIcOVOUhvA7F1y5qS
	 5tCL/6/jpuvGJxo2LyuVQ3JXDAwpyJ48htU8iyTYcw1O9zbI1xDScpNEAVHmRPGOaI
	 sVYAxKIo9z87tR0PFDOqayFmy3MitBgrZ5pCPR0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCYJ55 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:57:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38856 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJ55 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 05:57:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id w2so1537101oic.5;
        Wed, 25 Mar 2020 02:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrHDtRwPhSmDON/us38dmUQzHS32k9eLAFxKK6HSnl0=;
        b=DP5Pw4stLMIJ3D8u9E+sYOz+ggv19+wfz6lhCAXn9J/q33q40xLDZrQSjmxJDmjwBE
         8Tnb9BHJSb9wmbO5GJ94j3hoVDHOhtbzk+w1HMBVrrqhwbD2eZc597NxsIWgk3fDOT5/
         d8F+BmwYAK/83jBMeMB8JZe+vVk8bBs7rE/BOV2B5Zj0NT0CHJgUBa7HDqWeV8TLWg+C
         HieZTQZB1rRuPJ+EqpkSSWfSU+q78rX9KZasWs76i+0/DYP84s/fwLnU3uRisqGLQ1qo
         AAHYSqHCWwdz+jbIOr4b+vrF2i0JSYJSgdpCevoF4ljn6md7OLwvMybM051VZDhEpZ91
         j0Yg==
X-Gm-Message-State: ANhLgQ2Br9vXkzBJDuzDPCpHnU2+KYGp1DEIi8rfR4TWw6WTPP1v5ZX5
        q/4Nnn3T0S9pXF5ub7rogm8BgU19c7tGULEufek=
X-Google-Smtp-Source: ADFU+vty5QelQ9Rhdv8R71W76aSaOFGqdoguN3P+mdffL711qq/q5fywvQlk5Zp4b94WCLMPnyxxHbnfrLJNF+Yh9dw=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr1941750oic.110.1585130276966;
 Wed, 25 Mar 2020 02:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200324234525epcas1p28f4150423112c61645bc19e3742b22bf@epcas1p2.samsung.com>
 <21bd6b76-5a3e-96c1-4184-49e96ea5f594@samsung.com>
In-Reply-To: <21bd6b76-5a3e-96c1-4184-49e96ea5f594@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Mar 2020 10:57:45 +0100
Message-ID: <CAJZ5v0gDJkH=TBE4tFTz94rLoCCUnN1UNOpeYxRNPjf8uQsOsg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.7
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 12:45 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.7-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.7
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:
>
>   Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.7

Pulled, thanks!
