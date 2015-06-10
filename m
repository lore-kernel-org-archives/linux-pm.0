From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH RFC 1/3] PM / Domains: Allocate memory outside domain locks
Date: Wed, 10 Jun 2015 10:33:37 -0700
Message-ID: <7hpp53o4cu.fsf@deeprootsystems.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
	<1433456946-53296-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36530 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933970AbbFJRdn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 13:33:43 -0400
Received: by pdjm12 with SMTP id m12so42154434pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 10:33:41 -0700 (PDT)
In-Reply-To: <1433456946-53296-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Thu, 4 Jun 2015 16:29:04 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> In order for domains to be powered on/off in irq locked context, the
> domain locks could either be a spinlock or a mutex, depending on the
> domain. 

I'd drop that sentence.

> In preparation for atomic support, allocate domain data outside

In preparation for supporting IRQ-safe domainss, ...

> the domain locks, so the allocation calls dont have to be context
> sensitive.

OK, but *why* don't these allocations need to be protected by the
locks.  Presumably they were put inside the locks for a reason, so you
should make the case for why the lock protection isn't needed.

Kevin

