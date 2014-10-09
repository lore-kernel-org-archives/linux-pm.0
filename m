From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Bug#763320: linux-image-3.16-2-amd64: intel_idle enabled for
 Intel Atom S1260, causes high CPU temperature when idle
Date: Thu, 9 Oct 2014 04:37:12 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94845DFE975@fmsmsx115.amr.corp.intel.com>
References: <20140929095709.3255.93208.reportbug@izoard.lan>
 <1412035987.9388.72.camel@decadent.org.uk> <542A461D.9060900@siemens.com>
 <269B8283-9171-4EBD-9852-0796A4AA2008@thil.de> <542BFB31.8000402@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31528 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbaJIEhQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 00:37:16 -0400
In-Reply-To: <542BFB31.8000402@siemens.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Christophe Thil <christophe@thil.de>
Cc: Ben Hutchings <ben@decadent.org.uk>, "763320@bugs.debian.org" <763320@bugs.debian.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

okay, so they are both model 0x36...

please send me the output from

grep . /sys/devices/system/cpu/cpu*/cpuidle/*/*

which will show the states being used in both the ACPI and the intel_idle scenarios.

thanks,
-Len

