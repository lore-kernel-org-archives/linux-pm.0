From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 20/31] thermal: core: introduce thermal_helpers.c
Date: Tue, 17 May 2016 07:40:45 -0700
Message-ID: <20160517144044.GB14550@localhost.localdomain>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
 <1462341765-13268-21-git-send-email-edubezval@gmail.com>
 <1463491216.29980.36.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33673 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcEQOkt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 10:40:49 -0400
Content-Disposition: inline
In-Reply-To: <1463491216.29980.36.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, May 17, 2016 at 01:20:17PM +0000, Zhang, Rui wrote:
> $checkpatch.pl 20-31-thermal-core-introduce-thermal_helpers.c.patch 
> 
> WARNING: added, moved or deleted file(s), does MAINTAINERS need
> updating?
> #187: 
> new file mode 100644
> 
> ERROR: trailing whitespace
> #302: FILE: drivers/thermal/thermal_helpers.c:111:
> + $
> 
> WARNING: please, no spaces at the start of a line
> #302: FILE: drivers/thermal/thermal_helpers.c:111:
> + $
> 
> total: 1 errors, 2 warnings, 287 lines checked
> 
> NOTE: Whitespace errors detected.
>       You may wish to use scripts/cleanpatch or scripts/cleanfile
> 
> 20-31-thermal-core-introduce-thermal_helpers.c.patch has style problems,
> please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Please remove these spaces.
> BTW, there are also some warnings in the other patches, please fix the
> checkpatch warnings/errors.

Yeah, I will fix those.

These patches were supposed to be reviewed/merged before the merge
window though. I am going to wait until the merge window is closed to
send them again.


BR,

Eduardo Valentin
