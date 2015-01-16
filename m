From: Javi Merino <javi.merino@arm.com>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 16 Jan 2015 12:10:50 +0000
Message-ID: <20150116121049.GB2898@e104805>
References: <54B7F7CD.7030903@free.fr>
 <1421399293.11224.7.camel@AMDC1943>
 <54B8F19F.8060108@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:35848 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbAPMK7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 07:10:59 -0500
Content-Disposition: inline
In-Reply-To: <54B8F19F.8060108@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

Hi Mason,

On Fri, Jan 16, 2015 at 11:10:23AM +0000, Mason wrote:
[...]
> OK. I'm also interested in frequency-throttling when temperatures
> rise beyond specific thresholds. What subsystem ties sensors and
> cpufreq together?

The thermal framework.  Have a look at
Documentation/thermal/sysfs-api.txt and
Documentation/thermal/cpu-cooling-api.txt

Cheers,
Javi
