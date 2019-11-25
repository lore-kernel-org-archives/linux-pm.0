Return-Path: <SRS0=cbcz=ZR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DBC432C0
	for <linux-pm@archiver.kernel.org>; Mon, 25 Nov 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADAD20674
	for <linux-pm@archiver.kernel.org>; Mon, 25 Nov 2019 18:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfKYS1E (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:27:04 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:62298 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfKYS1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 13:27:04 -0500
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47MFqp6rkBz1bHy;
        Mon, 25 Nov 2019 13:27:02 -0500 (EST)
Date:   Mon, 25 Nov 2019 10:27:01 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <2977390.9qzeJo7xji@kreacher>
Message-ID: <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com> <2977390.9qzeJo7xji@kreacher>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:

> > I'll send you a patch to try for that.

> Appended (untested).

This is promising! I've only tested a handful of suspend cycles, but so far:

- Charging events don't wake it up
- It suspends with the charger connected
- Suspend current draw consistently gets to the lowest idle point
- It always comes back from suspend, even after connecting a charger when suspended

... IOW, everything just seems to work, and better than before. I just
remembered why I had to use "ec_no_wakeup" (pre suspend-rework) in the first
place- this is a convertible and accelerometer events would take the laptop
out of (and immediately back into) suspend and your rework fixed that but then
I had the issues listed in my original E-mail.

I'll keep testing it (and the best way to get something to break is to proclaim
it's "fixed" :), but for now I'm pretty happy with the patch.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
