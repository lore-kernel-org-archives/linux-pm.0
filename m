From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] of: thermal: Introduce "linux,hwmon" optional property
Date: Thu, 5 Oct 2017 15:57:00 +0100
Message-ID: <510ceb7b-7e01-2054-008f-e018079f891f@arm.com>
References: <20171005084206.2914-1-kukabu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdJEO5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Oct 2017 10:57:04 -0400
In-Reply-To: <20171005084206.2914-1-kukabu@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Tatarinov <kukabu@gmail.com>, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Please add devicetree bindings mailing list when you are add such
generic and linux specific bindings. For now, I disagree on the approach
unless you convince that's the only way on devicetree list and get
ACK from DT binding maintainers.

On 05/10/17 09:42, Michael Tatarinov wrote:
> Introduce an optional property called "linux,hwmon", which enable
> registration in hwmon subsystems.
> 

Both the commit and the property binding seem to conflict with the
comment in Documentation/thermal/sysfs-api.txt

It states "when no_hwmon == false, a hwmon sysfs interface will be
created" while you seem to indicate that this is required to register
to hwmon subsystems.

If it's just to enable this sysfs access, then binding seems a bit of
misuse.

-- 
Regards,
Sudeep
