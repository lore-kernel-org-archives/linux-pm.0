From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: intel_soc_dts_thermal binding issues
Date: Thu, 5 Mar 2015 01:55:45 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926301491FCF@SHSMSX101.ccr.corp.intel.com>
References: <CA+5PVA7SZ+csY8WwMkwRa-nOmsHP8SdVe4v=mUmq38RJ4LSsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63876 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbbCEB6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 20:58:46 -0500
In-Reply-To: <CA+5PVA7SZ+csY8WwMkwRa-nOmsHP8SdVe4v=mUmq38RJ4LSsyA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

What kernel are you using?
I think it should be fixed by commit 014d9d5d0cc1da79bbe48fbc5e1068c5616238d2, which is merged in 3.19-rc5.

Thanks,
rui

-----Original Message-----
From: jwboyer@gmail.com [mailto:jwboyer@gmail.com] On Behalf Of Josh Boyer
Sent: Wednesday, March 4, 2015 10:05 PM
To: Zhang, Rui; Eduardo Valentin
Cc: Linux PM list; Linux-Kernel@Vger. Kernel. Org
Subject: intel_soc_dts_thermal binding issues
Importance: High

Hi All,

We've seen a number of reports where people see:

[   20.499427] intel_soc_dts_thermal: request_threaded_irq ret -22
[   20.519160] intel_soc_dts_thermal: request_threaded_irq ret -22
[   20.532660] intel_soc_dts_thermal: request_threaded_irq ret -22

in their boot logs.  They view this as a kernel bug and report is as such.  The above log came from an ASUS x200ma machine, which has a quad core Baytrail-M Pentium CPU (N3530).

I can't tell if the issue is because the driver is trying to bind to all 4 cores and only CPU0 works, or what other issue would cause this.
I personally have a Celeron based NUC with a N2820 that gets the error above for both cores and the driver doesn't load at all.

Is there something else the driver should be doing to bind to the various CPUs?  If there's nothing else it can key off of, can we drop the pr_err so it stops showing up in dmesg?

josh
