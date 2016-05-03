From: Mason <slash.tmp@free.fr>
Subject: Re: Weird interaction between thermal and cpufreq drivers
Date: Tue, 3 May 2016 17:34:18 +0200
Message-ID: <5728C4FA.6040200@free.fr>
References: <57222B46.4070502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:39571 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535AbcECPee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 May 2016 11:34:34 -0400
In-Reply-To: <57222B46.4070502@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Sebastian Frias <sf84@laposte.net>

On 28/04/2016 17:24, Mason wrote:

> I'm seeing a weird bug, where the thermal driver(*) returns bogus
> temperatures once I lower the CPU frequency.

Egg on my face...

cpufreq was a red herring. I simply failed to initialize TEMPSI_CFG.
(And the hardware playfully sets it to an arbitrary value at reset.)
Patch incoming.

Regards.
