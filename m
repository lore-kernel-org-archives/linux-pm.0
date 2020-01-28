Return-Path: <SRS0=8pdy=3R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE0C2D0DB
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224824683
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jan 2020 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580251472;
	bh=bu7XnOqWbb3uhg757Q7ALIPaGwkhgj/0StoQ4256nz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rS6plNh7lHj2gZHE/romIq/RTcp4l75iShYG7u+o2CjE7646EYhCp7GWRyAzhInl9
	 pUx647rn9yEKXGfHI+rS4sEUQoK6bujQKqly5BrqiNZsS9NelTYFHi3ndKpe6bw0E7
	 m7Q/wn7hZMAZMzK02BlOcYHK2NJ0ZxOwtNpgWN9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1Wob (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:44:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32967 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1Wob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 17:44:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so12110524oig.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 14:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8OCor50dbz87HysQnsFchVbiY0ND5uEbG8IYejs9vQ=;
        b=oVuqBcGY9XnimWe9+Gx9TKgXJ3iEhsJP9yBzaqFh6BvSWrzZCUk3z2nFCAjQecqsBL
         mzdkBeh2YmN8cie0Cpt1cYsfsvG4bgk/lkjdrAdU/9r/sVPvHzvaPmQU3WwbS5I7Vly8
         oiR1zaRtSbDMHxn41L7ABa5Jsf9vWHBhiAhA6QJ9jp5EQcLsHrWccRmTXRDvFa/dWdxv
         lB2doFSRdBX5sEOBq3a+7M9ksu6wlL0FtNyX+gyOtMedEH8tVmMPmFyYt5sUKDZ0rEmS
         4NDaigvvGAQZ24AqW77kMEEEsm4QBzXph94f3qtNsnq9Bq+leym44m2ARYaBnFERst1+
         X3Yw==
X-Gm-Message-State: APjAAAXQjQKUusxxtqQKm3awyxyBpgd12Eia+utMK1AIo1TNATUQxp6D
        maSm6shKbVk5xSpN0cGCc6Zzex8xmShcnuXk8IjtoA==
X-Google-Smtp-Source: APXvYqxgqYOUbWCVib/7eC4DX5a7UZShrtpk7WirAFPs+YkexJEKfg+HPoz/xTBNuGJr8vbHFWJsL1JjVv3l1auaLDg=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr4632068oiy.110.1580251470543;
 Tue, 28 Jan 2020 14:44:30 -0800 (PST)
MIME-Version: 1.0
References: <7c92807e-073e-c2a1-e229-9b5d5dd24f14@linuxfoundation.org>
In-Reply-To: <7c92807e-073e-c2a1-e229-9b5d5dd24f14@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 23:44:19 +0100
Message-ID: <CAJZ5v0hq5J0KCrqkQV=B-orZrF5w7VzSENieJs+r9SGREusd+g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.6-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>, latha@linux.vnet.ibm.com,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 28, 2020 at 7:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following update for Linux 5.6-rc1.
>
> This cpupower update for Linux 5.6-rc1 consists of a revert from
> Thomas Renninger and a manpage correction from Brahadambal Srinivasan.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
>
> ----------------------------------------------------------------
> The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:
>
>    Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux
> tags/linux-cpupower-5.6-rc1
>
> for you to fetch changes up to 8c30fa7666ff08dad632411d1a9b9883940e53ef:
>
>    Correction to manpage of cpupower (2020-01-27 08:43:31 -0700)

Pulled, thanks!
