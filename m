From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/6] powerpc/powernv: Add definition of OPAL_MSG_OCC message type
Date: Mon, 10 Aug 2015 10:23:58 +1000
Message-ID: <m31tfcf0td.fsf@oc8180480414.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:49669 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbbHJAY2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Aug 2015 20:24:28 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Sun, 9 Aug 2015 20:24:27 -0400
In-Reply-To: <1437033863-15864-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> Add OPAL_MSG_OCC message definition to opal_message_type to receive
> OCC events like reset, load and throttled. Host performance can be
> affected when OCC is reset or OCC throttles the max Pstate.
> We can register to opal_message_notifier to receive OPAL_MSG_OCC type
> of message and report it to the userspace so as to keep the user
> informed about the reason for a performance drop in workloads.
>
> The reset and load OCC events are notified to kernel when FSP sends
> OCC_RESET and OCC_LOAD commands.  Both reset and load messages are
> sent to kernel on successful completion of reset and load operation
> respectively.

How is this done on OpenPower systems? Explanation involving just what
OPAL does is likely better, rather than explaining in context of FSP,
which Linux has no real knowledge of (OPAL provides all abstraction of
it).

