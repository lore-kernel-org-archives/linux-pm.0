From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v7 3/7] arm: dts: qcom: Add SPM device bindings for 8084
Date: Tue, 30 Sep 2014 10:31:22 -0700
Message-ID: <7hd2ad10d1.fsf@deeprootsystems.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
	<1411779495-39724-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35612 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaI3RbY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Sep 2014 13:31:24 -0400
In-Reply-To: <1411779495-39724-4-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Fri, 26 Sep 2014 18:58:11 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Add SPM device bindings for QCOM 8084 based cpus. SPM is the sub-system
> power manager and controls the logic around the cores (cpu and L2).
>
> Each core has an instance of SPM and controls only that core. Each cpu
> SPM is configured to support WFI and SPC (standalone-power collapse).
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

nit: This will need some more description, IMO.  The changelog talks
about SPM bindings, but all the stuff added refers to SAW.

Kevin
