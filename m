Return-Path: <SRS0=GQM4=XO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B3C3A5A6
	for <linux-pm@archiver.kernel.org>; Thu, 19 Sep 2019 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB521D79
	for <linux-pm@archiver.kernel.org>; Thu, 19 Sep 2019 11:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbfISLqc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:46:32 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:48271 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387977AbfISLqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 07:46:32 -0400
Received: from hp-x360n (c-73-241-154-233.hsd1.ca.comcast.net [73.241.154.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 46Yw6Y2bv3z1Lfc;
        Thu, 19 Sep 2019 07:46:28 -0400 (EDT)
Date:   Thu, 19 Sep 2019 04:46:27 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me help you debug what seems to be an EC resume issue
In-Reply-To: <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909190444190.2973@hp-x360n>
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Thu, 19 Sep 2019, Rafael J. Wysocki wrote:

> You may still be able to use S3 on this machine if that's supported by
> the platform firmware.

It's not; I tried "deep" two days after getting it.

> I would recommend to try 5.4-rc1 when it's out to see if the problems
> above are still there.

Well, I'm running Linus' master tip right now and pull and run the latest
bleeding-edge kernel daily; does this mean you have further patches coming
down the line later?

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
