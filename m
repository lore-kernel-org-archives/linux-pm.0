Return-Path: <SRS0=qrRL=VT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E908C76188
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 08:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5078822296
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 08:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfGVIyK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:54:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGVIyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 04:54:10 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 5dd4f2870aa3b3ab; Mon, 22 Jul 2019 10:54:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/8] ACPI: EC: Return bool from acpi_ec_dispatch_gpe()
Date:   Mon, 22 Jul 2019 10:54:08 +0200
Message-ID: <2789854.IgcpE17qYE@kreacher>
In-Reply-To: <20190721163929.GA12494@amd>
References: <71085220.z6FKkvYQPX@kreacher> <4778086.90p4OrCUAx@kreacher> <20190721163929.GA12494@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, July 21, 2019 6:39:29 PM CEST Pavel Machek wrote:
> On Tue 2019-07-16 18:12:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > On some systems, if suspend-to-idle is used, the EC may singal system
> 
> Typo "signal".

Thanks, fixed.



