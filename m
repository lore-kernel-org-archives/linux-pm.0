From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: handle domain energy unit
Date: Thu, 12 Mar 2015 15:05:36 -0700
Message-ID: <20150312150536.630c0644@icelake>
References: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<5500B2E0.9000107@gmail.com>
	<20150312142413.7bd42863@icelake>
	<55020C4F.3010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46791 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbCLWGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Mar 2015 18:06:30 -0400
In-Reply-To: <55020C4F.3010406@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kazutomo <kazutomo.yoshii@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>

On Thu, 12 Mar 2015 16:59:43 -0500
kazutomo <kazutomo.yoshii@gmail.com> wrote:

> > according to the document, future DRAM energy unit will always be
> > hardcoded to 15.3uJ, no enumeration since there is no domain
> > specific MSR for energy unit.  
> Which document are you referring to?
Intel DocID:330784-001 Sept 2014
Intel Xeon Processor E5-1600 and E5-2600 V2 of 2.
