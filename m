From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v3] thermal: add temperature sensor support for tango SoC
Date: Thu, 24 Mar 2016 18:56:03 +0100
Message-ID: <56F42A33.108@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain> <56F3DB1E.9050605@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:31301 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbcCXR4P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Mar 2016 13:56:15 -0400
In-Reply-To: <56F3DB1E.9050605@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

On 24/03/2016 13:18, Mason wrote:

> +	if (temp_above_thresh(base, idx)) {
> +		/* Downward linear search */
> +		while (idx > IDX_MIN && temp_above_thresh(base, --idx))
> +			cpu_relax();
> +	} else {
> +		/* Upward linear search */
> +		while (idx < IDX_MAX && !temp_above_thresh(base, ++idx))
> +			cpu_relax();
> +		idx = idx - 1;
> +	}

That's wrong, I mixed up the two branches.

When temp is above thresh, we should search upward.

I'll send v4 in a few days (needs more testing).

Regards.

