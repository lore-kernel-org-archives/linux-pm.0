From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 0/7] The power allocator thermal governor
Date: Thu, 5 Feb 2015 12:06:57 +0000
Message-ID: <20150205120657.GA9212@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41993 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbBEMHJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 07:07:09 -0500
Content-Disposition: inline
In-Reply-To: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Punit Agrawal <Punit.Agrawal@arm.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

Hi linux-pm,

On Wed, Jan 28, 2015 at 05:00:31PM +0000, Javi Merino wrote:
> The power allocator governor allocates device power to control
> temperature.  This requires transforming performance requests into
> requested power, which we do with an extended cooling device API
> introduced in patch 2 (thermal: extend the cooling device API to
> include power information).  Patch 3 (thermal: cpu_cooling: implement
> the power cooling device API) extends the cpu cooling device using a
> simple power model.

We have compared the Power Allocator governor against Step Wise and
generated a report:

https://wiki.linaro.org/WorkingGroups/PowerManagement/Resources/EAS/IPAEvidencev1

Cheers,
Javi & Kapileshwar (KP)
