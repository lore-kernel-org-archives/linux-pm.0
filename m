From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2, 0/3] intel_pstate: Improvements related to the
 APERF/MPERF computation
Date: Thu, 12 May 2016 17:34:04 -0700
Message-ID: <1463099644.991.25.camel@linux.intel.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	 <4400018.TlI4RAhtYU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63339 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbcEMAee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 May 2016 20:34:34 -0400
In-Reply-To: <4400018.TlI4RAhtYU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2016-05-11 at 19:06 +0200, Rafael J. Wysocki wrote:
> On Saturday, May 07, 2016 01:42:53 AM Rafael J. Wysocki wrote:
> > Hi,
> > 
> > As per the subject, on top of the current linux-next branch of
> > linux-pm.git.
> 
> This version has been reworked to retain more APERF bits after
> carrying out the
> \Delta_{APERF}/\Delta_{MPERF} which should lead to a bit more precise
> numbers
> in sysfs etc.

Tested the series and looks fine now.

Thanks,
Srinivas

> 
> Thanks,
> Rafael
