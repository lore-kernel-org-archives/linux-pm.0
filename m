From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/3] drivers: cpuidle: add status property to ARM idle states
Date: Mon, 20 Oct 2014 14:38:02 -0700
Message-ID: <7hbnp6e81x.fsf@deeprootsystems.com>
References: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:45136 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbaJTViH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Oct 2014 17:38:07 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so5674463pde.8
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2014 14:38:06 -0700 (PDT)
In-Reply-To: <1413467997-32131-1-git-send-email-lorenzo.pieralisi@arm.com>
	(Lorenzo Pieralisi's message of "Thu, 16 Oct 2014 14:59:55 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On some platforms the device tree bindings must provide the kernel
> with a status flag for idle states, that defines whether the idle
> state is operational or not in the current configuration.
>
> This patch adds a status property to the ARM idle states compliant
> with ePAPR v1.1 and updates the DT parsing code accordingly.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

For the series:

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
