From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 00/15] thermal: sysfs: add locking
Date: Wed, 1 Jun 2016 09:26:46 +0530
Message-ID: <574E5CFE.6040708@ti.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58927 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805AbcFAD4w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 31 May 2016 23:56:52 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>



On Tuesday 31 May 2016 12:01 PM, Eduardo Valentin wrote:
> Hello,
>
> Several thermal sysfs entries are currently being called
> from userspace without locking. Data and calls to ops
> are accessed deliberated without any care for locking.
>
> This patch series attempts to fix this.
>
> Now that sysfs handlers are on the same place it is easier
> to visualize this issue and fix it. The strategy is essentially
> to lock any access. Also, functions in thermal core and thermal
> helpers are assumed to do the proper locking already.
>
> This patch series is based on the thermal core reorganization.
>
> There is no change in the ABI to userspace. The difference
> is that now serialization to data will be done.
>
> For your consideration, I am also adding this to this branch:
>    git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal sysfs_locking

Tested and checked for reading temperatures from all the thermal zones
on DRA7/DRA72 and AM57XX-BEAGLE-X15 boards.

Also tested emulation using a rebased version of
https://lkml.org/lkml/2016/5/10/346

For DRA7/DRA72 and BEAGLE-X15:
Tested-by: Keerthy <j-keerthy@ti.com>

>
> Comments are welcome.
>
> BR,
>
> Eduardo Valentin (15):
>    thermal: sysfs: lock tz in type_show
>    thermal: sysfs: lock tz while on access to mode properties
>    thermal: sysfs: lock tz while on trip_point_type properties
>    thermal: sysfs: lock tz while on trip_point_temp properties
>    thermal: sysfs: lock tz while on trip_point_hyst properties
>    thermal: sysfs: lock tz while on passive properties
>    thermal: sysfs: lock tz while on policy properties
>    thermal: sysfs: improve locking of emul_temp_store()
>    thermal: sysfs: lock tz when access sustainable power properties
>    thermal: sysfs: lock tz when access tzp properties
>    thermal: sysfs: lock cdev while accessing type
>    thermal: sysfs: lock cdev while accessing max_state
>    thermal: sysfs: lock cdev while accessing cur_state
>    thermal: sysfs: serialize access to instances
>    thermal: sysfs: add comments describing locking strategy
>
>   drivers/thermal/thermal_sysfs.c | 133 ++++++++++++++++++++++++++++++++++------
>   include/linux/thermal.h         |   2 +-
>   2 files changed, 115 insertions(+), 20 deletions(-)
>
