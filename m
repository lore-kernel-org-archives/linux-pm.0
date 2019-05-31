Return-Path: <SRS0=W2LS=T7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC232C04AB6
	for <linux-pm@archiver.kernel.org>; Fri, 31 May 2019 09:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BC525973
	for <linux-pm@archiver.kernel.org>; Fri, 31 May 2019 09:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEaJ1m (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 31 May 2019 05:27:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48084 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJ1m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 05:27:42 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id d5641f8fb15585b2; Fri, 31 May 2019 11:27:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        todd.e.brandt@intel.com
Subject: Re: [PATCH 0/3] pm-graph 5.4
Date:   Fri, 31 May 2019 11:27:39 +0200
Message-ID: <3397449.Zp8aqk8sBs@kreacher>
In-Reply-To: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
References: <cover.1557855894.git.todd.e.brandt@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, May 14, 2019 7:53:56 PM CEST Todd Brandt wrote:
> Considerable upgrades to the summary functionality, as well as
> new sources of data from turbostat and mcelog. ACPI methods are now
> traceable in the timeline as well in dev mode.
> 
> Todd Brandt (3):
>   Update to pm-graph 5.3
>   Update to pm-graph 5.4
>   pm-graph 5.4 config and other files
> 
>  tools/power/pm-graph/README             | 552 ++++++++++++++++++++
>  tools/power/pm-graph/bootgraph.py       |   8 +-
>  tools/power/pm-graph/config/example.cfg |  26 +
>  tools/power/pm-graph/sleepgraph.8       |  16 +-
>  tools/power/pm-graph/sleepgraph.py      | 857 ++++++++++++++++++++++++--------
>  5 files changed, 1253 insertions(+), 206 deletions(-)
>  create mode 100644 tools/power/pm-graph/README
> 
> 

All three applied, thanks!




