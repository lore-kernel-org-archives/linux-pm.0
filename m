From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Thermal governors non-modularity
Date: Mon, 22 Feb 2016 07:06:17 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092633A963443@SHSMSX101.ccr.corp.intel.com>
References: <20160220140448.19b749dd@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63037 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752926AbcBVHGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 02:06:21 -0500
In-Reply-To: <20160220140448.19b749dd@endymion>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>

I tried to use them as module in the first place, but failed for some reason. I cannot recall the root cause, but I will try to check this and reply to you later. :)

Thanks,
rui

> -----Original Message-----
> From: Jean Delvare [mailto:jdelvare@suse.de]
> Sent: Saturday, February 20, 2016 9:05 PM
> To: linux-pm@vger.kernel.org
> Cc: Zhang, Rui <rui.zhang@intel.com>; Eduardo Valentin
> <edubezval@gmail.com>
> Subject: Thermal governors non-modularity
> Importance: High
> 
> Hi Rui, Eduardo,
> 
> Is there any fundamental reason why thermal governors can't be built as
> modules? We have more and more of them, 5 now, and the most recent is
> fairly big... Would be much more practical if they could be built as modules
> and loaded at run-time only as needed.
> 
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support
