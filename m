From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] intel_idle: re-work bxt_idle_state_table_update() and its helper
Date: Sat, 16 Jul 2016 03:01:58 +0200
Message-ID: <2348427.sm43UVpP65@vostro.rjw.lan>
References: <5770E54002000078000F8D82@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52472 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751054AbcGPA5K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2016 20:57:10 -0400
In-Reply-To: <5770E54002000078000F8D82@prv-mh.provo.novell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Monday, June 27, 2016 12:35:12 AM Jan Beulich wrote:
> Since irtl_ns_units[] has itself zero entries, make sure the caller
> recognized those cases along with the MSR read returning zero, as zero
> is not a valid value for exit_latency and target_residency.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

This ans the [2/2] applied, thanks!

