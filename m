Return-Path: <SRS0=Ia5J=CR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA184C433E2
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CE321741
	for <linux-pm@archiver.kernel.org>; Tue,  8 Sep 2020 08:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgIHIda (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:33:30 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:48892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729234AbgIHId0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 04:33:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 89BF218224D99;
        Tue,  8 Sep 2020 08:33:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shake14_071231d270d3
X-Filterd-Recvd-Size: 1575
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Sep 2020 08:33:22 +0000 (UTC)
Message-ID: <cb6c0af0c9e729f87f3fdd8417115d66e3dc8b93.camel@perches.com>
Subject: Re: [PATCH 1/4] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Tue, 08 Sep 2020 01:33:21 -0700
In-Reply-To: <20200908082722.GA704757@kroah.com>
References: <cover.1599501047.git.joe@perches.com>
         <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
         <20200908082722.GA704757@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-08 at 10:27 +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 07, 2020 at 10:58:05AM -0700, Joe Perches wrote:
> > Convert the various sprintf fmaily calls in sysfs device show functions
> > to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.
> 
> But no sysfs_emit_at() calls are used in this patch :(

Try patch 4.

No instance where it was appropriate to use sysfs_emit_at
matched the cocci script requirements in this directory.


