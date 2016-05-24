From: Linda Knippers <linda.knippers@hpe.com>
Subject: re: Enforce _PPC limits
Date: Tue, 24 May 2016 16:37:35 -0400
Message-ID: <21572dff-ea5d-c0f3-6f48-66c9d38eda65@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g1t6225.austin.hp.com ([15.73.96.126]:56203 "EHLO
	g1t6225.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcEXUhk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 16:37:40 -0400
Received: from g2t4620.austin.hp.com (g2t4620.austin.hp.com [15.73.212.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g1t6225.austin.hp.com (Postfix) with ESMTPS id 1D9CD9A2
	for <linux-pm@vger.kernel.org>; Tue, 24 May 2016 20:37:39 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Srinivas,

I have a couple of questions about this patch set.
http://comments.gmane.org/gmane.linux.power-management.general/75263

Sorry I'm a bit late to the party but I've just booted 4.6 on my system
and noticed some things.

My first question is about enabling the feature by default on enterprise
and performance servers.  Is there any way to disable it on these servers?
I didn't see a way.  I'm always nervous when something starts looking at
a table that perhaps wasn't used before or introduces a new behavior that
might be unexpected.  Having a way out or not making it the default for a
while would be nice.

My second question is about the 48 instances I got of this when I booted my
2 socket, 48-CPU box:

> intel_pstate: _PPC limits will be enforced

I suppose in theory I could have limits for some CPUs and not others but
even in that case, the message isn't helpful.  I think it should be made
useful or go away, or at least only be printed once.

Thanks,

-- ljk
