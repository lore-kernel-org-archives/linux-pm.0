From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
Date: Tue, 21 Apr 2015 11:24:54 -0700
Message-ID: <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44597 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526AbbDUSY7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Apr 2015 14:24:59 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id DA6BC2035E
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 18:24:58 +0000 (UTC)
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 42B842035B
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 18:24:56 +0000 (UTC)
Received: by wgyo15 with SMTP id o15so222904784wgy.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 11:24:54 -0700 (PDT)
In-Reply-To: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Howard Chen <howard.chen@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Grant Likely <grant.likely@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Apr 16, 2015 at 9:10 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

[...]

> This patch sets the maximum number of static CPUidle drivers allowed to
> two, since it is hard to foresee systems with more than two sets of CPUs
> having different idle states

It's not hard to forsee anymore:

   http://www.cnx-software.com/2015/04/21/mediatek-helio-x20-deca-core-processor/
   https://liliputing.com/2015/04/closer-look-at-mediateks-upcoming-10-core-helio-x20-processor.html

Kevin
