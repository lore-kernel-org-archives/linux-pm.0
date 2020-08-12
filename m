Return-Path: <SRS0=05zK=BW=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12513C433DF
	for <linux-pm@archiver.kernel.org>; Wed, 12 Aug 2020 03:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC11720782
	for <linux-pm@archiver.kernel.org>; Wed, 12 Aug 2020 03:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLDvh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:51:37 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:40552 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgHLDvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 23:51:37 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 0AAFF18005B1E;
        Wed, 12 Aug 2020 03:51:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3ED6C8378BB9;
        Wed, 12 Aug 2020 03:51:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crow00_520afc026fe8
X-Filterd-Recvd-Size: 2088
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 03:51:33 +0000 (UTC)
Message-ID: <d5af6b286fa6c9de8d71075b657b952bf775e557.camel@perches.com>
Subject: Re: [PATCH v2 2/3] perf/x86/rapl: Support multiple rapl unit quirks
From:   Joe Perches <joe@perches.com>
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     linux-pm@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com, rafael@kernel.org
Date:   Tue, 11 Aug 2020 20:51:31 -0700
In-Reply-To: <d7a19f05497b4137bacd639e576b7166e4a19842.camel@intel.com>
References: <20200811153149.12242-1-rui.zhang@intel.com>
         <20200811153149.12242-3-rui.zhang@intel.com>
         <445d4b9039daca40a4d937959a0bc48ffe347f7f.camel@perches.com>
         <d7a19f05497b4137bacd639e576b7166e4a19842.camel@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-12 at 11:29 +0800, Zhang Rui wrote:
> Hi,
> 
> Thanks for reviewing.
> 
> On Tue, 2020-08-11 at 11:19 -0700, Joe Perches wrote:
> > On Tue, 2020-08-11 at 23:31 +0800, Zhang Rui wrote:
> > > There will be more platforms with different fixed energy units.
> > > Enhance the code to support different rapl unit quirks for
> > > different
> > > platforms.
> > 
> > This seems like one quirk per platform.
> > 
> > Should multiple quirks on individual platforms be supported?
> > 
> enum rapl_unit_quirk is just used as a flag.
> multiple quirks can be deployed with the same flag, just like what I
> did in patch 3/3.
> Also different platforms can either have different flags or share the
> same flag.

Sure, but it does lead to possible code duplication in the quirks
as enums can not be combined like bit flags.

No worries, your code, your choice...

