Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A7C10F12
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A942073F
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hzbDny9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfDQINV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:13:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:64324 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQINU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 04:13:20 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417081318epoutp01799d729f266144231994dc6ba77d9447~WNNIer9Cc2067420674epoutp01U
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 08:13:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417081318epoutp01799d729f266144231994dc6ba77d9447~WNNIer9Cc2067420674epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555488798;
        bh=FYFpeGo0yVIiPQyi12AUSy+pmRBnQEaMXAyn4/6Vigw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hzbDny9xDWTgHmHrzalsYAJClPPewJFy4wQUkErQa9VOYCc+fNc2GIW3VgYhMV51s
         p6VDLayJC5HV4nF+ZQil01+VxY4/101cpsNTCyuC1qebAAHg83fKuiNpeMncKkBJo0
         pcRsc9AP3CzRq+fw7fSddHAXYCTp6cmu4iYXyUKE=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190417081314epcas1p49f0c37e1829720ab04935a4a28667992~WNNEzlsjm0470004700epcas1p4d;
        Wed, 17 Apr 2019 08:13:14 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-42-5cb6e01394d5
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.9B.04143.310E6BC5; Wed, 17 Apr 2019 17:13:07 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [Pull Request] for Rafael, Linux-PM, from devfreq.
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAJZ5v0h+P0PNDma4NH6SnLy17U1qb9opOm5ZwJVAXNWWOfs5Vw@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190417081306epcms1p56acc17942dcb11828995ebbf2b8a7fc0@epcms1p5>
Date:   Wed, 17 Apr 2019 17:13:06 +0900
X-CMS-MailID: 20190417081306epcms1p56acc17942dcb11828995ebbf2b8a7fc0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmrq7wg20xBheui1isuX2I0eJWg4zF
        594jjBZrj9xlt3i+qZPVYu6XqcwWZ05fYrU4cHEim8Xc3xPYHDg9Lvf1MnnsuLuE0WPnrLvs
        HptWdbJ5HHy3h8ljy9V2Fo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnbHt+2L2gvOcFZ+mL2VtYHzE3sXIySEhYCKx
        7tVZxi5GLg4hgR2MEnu23mXrYuTg4BUQlPi7QxikRljAWeLE3TXMILaQgJJEw819zBBxfYmO
        B9sYQWw2AV2JrRvusoDYIgLaEksWXWUGmcksMJNZoqP5DyPEMl6JGe1PWSBsaYnty7eCxTkF
        AiU2LTgIdZCoxM3Vb+Hs98fmQ/WKSLTeO8sMYQtKPPi5mxFmzowp/6FmVktcm76YHWSxhEAL
        o0Tv6ilQRfoSZ+aeZAOxeQV8JdZtmMkKYrMIqEp0zJgANdRF4tb9S2CLmQXkJba/ncMMCghm
        AU2J9bv0IcJ8Eu++9rDC/LJj3hMmCFtN4tDuJVA3y0icnr4QaqSHxMQbC1gggXuHUWJx4yLW
        CYzysxDhOwvJtlkI2xYwMq9iFEstKM5NTy02LDBGjtJNjOD0qWW+g3HDOZ9DjAIcjEo8vCt+
        bo0RYk0sK67MPcQowcGsJMLrmLIlRog3JbGyKrUoP76oNCe1+BCjKdDTE5mlRJPzgak9ryTe
        0NTI2NjYwsTQzNTQUEmcd72Dc4yQQHpiSWp2ampBahFMHxMHp1QDY3fQDJVdjBt3/p+YcWHS
        u9f80zrY2b0/2vyLMQl5sHjCS8F9XMc11a7/PPODVeWxbOoxkZKjWvNX//5wRb+ZbQJzyvu/
        CvJRuhLvS+M73I8X8qx+GmWtG+t5b+aZhs7yI/sr4nhv5dVeU5k2/bZ4XfvK8LAHHlWLNt9a
        KzH1vNqLP+47fDRMapVYijMSDbWYi4oTAd9cvLe1AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db
References: <CAJZ5v0h+P0PNDma4NH6SnLy17U1qb9opOm5ZwJVAXNWWOfs5Vw@mail.gmail.com>
        <20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
        <CGME20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p5>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>On Wed, Apr 17, 2019 at 4:26 AM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>>
>> Dear Rafael,
>>
>> Here goes a pull-request for next / Linux-PM.
>>
>>
>> Cheers,
>> MyungJoo
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:
>>
>>   Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)
>>
>> are available in the git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next
>>
>> for you to fetch changes up to cf451adfa392bd9ba36f31659dbe6a5010b46ef9:
>>
>>   PM / devfreq: add tracing for scheduling work (2019-04-16 09:29:18 +0900)
>
>Pulled, thanks!
>
>That said, next time can you please provide a high-level brief
>description of what's being changed, so I can add it to my merge?
>
>Cheers,
>Rafael

Sorry for missing that part in the mail message; I forgot to add it
from the tag message.

It's

This includes:
- Number of bugfixes (mainly on exception handling or styles)
- Exynos-bus: fix issues related with shutdown/reboot
- Rockchip-dfi: code refactoring
- RK3399: support trusted firmware
- Added trace support for devfreq-event


Cheers,
MyungJoo
