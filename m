From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:bleeding-edge 24/34] kernel/power/snapshot.c:928:12: warning: 'swsusp_page_is_valid' defined but not used
Date: Wed, 16 Sep 2015 02:43:15 +0200
Message-ID: <1658485.DPiavY8Irk@vostro.rjw.lan>
References: <201509150808.N1zPZE8x%fengguang.wu@intel.com> <36DF59CE26D8EE47B0655C516E9CE640265824E9@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50804 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751772AbbIPAPP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 20:15:15 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640265824E9@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, September 15, 2015 01:32:11 AM Chen, Yu C wrote:
> Thanks!  Fengguang,
> Then a '__attribute__ ((unused))' might be added in next version.

I'm dropping the patch for now then and I'll wait for the next version.

Thanks,
Rafael

