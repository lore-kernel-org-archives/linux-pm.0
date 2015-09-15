From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [pm:bleeding-edge 24/34] kernel/power/snapshot.c:928:12:
 warning: 'swsusp_page_is_valid' defined but not used
Date: Tue, 15 Sep 2015 01:32:11 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640265824E9@shsmsx102.ccr.corp.intel.com>
References: <201509150808.N1zPZE8x%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20330 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbbIOBcP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 21:32:15 -0400
In-Reply-To: <201509150808.N1zPZE8x%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Thanks!  Fengguang,
Then a '__attribute__ ((unused))' might be added in next version.

Best Regards,
Yu

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Tuesday, September 15, 2015 8:19 AM
> To: Chen, Yu C
> Cc: kbuild-all@01.org; Rafael J. Wysocki; linux-pm@vger.kernel.org
> Subject: [pm:bleeding-edge 24/34] kernel/power/snapshot.c:928:12:
> warning: 'swsusp_page_is_valid' defined but not used
>  
> >> kernel/power/snapshot.c:928:12: warning: 'swsusp_page_is_valid'
> defined but not used [-Wunused-function]
>     static int swsusp_page_is_valid(struct page *page)
>                ^
> 

