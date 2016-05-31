From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv3 00/48] thermal: reorganizing thermal core
Date: Mon, 30 May 2016 23:13:47 -0700
Message-ID: <20160531061344.GA2111@localhost.localdomain>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
 <574D11E8.3070703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34669 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcEaGNw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:13:52 -0400
Content-Disposition: inline
In-Reply-To: <574D11E8.3070703@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <a0393675@ti.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, May 31, 2016 at 09:54:08AM +0530, Keerthy wrote:
> Hi Eduardo,
> 
> On Tuesday 31 May 2016 03:45 AM, Eduardo Valentin wrote:
> >Folks,
> >
> >This is V3 of a patch series to improve thermal core. The idea
> >here is to reorganize the code and improve the way we
> >handle sysfs entries.
> >
> >The change in behavior is that now, thermal zones with empty
> >.type will not be allowed to be registered. Also, the way
> >we handle scanf's return code is now checking for
> >number of successful inputs.
> >
> >After this series, thermal core is split into the following files:
> >- thermal_sysfs.c: contains the functions handling the sysfs nodes
> >- thermal_helpers.c: groups functions that do not need to touch thermal
> >core internal data structures, such as internal lists, and list locks.
> >- thermal_core.c: functions to handle the lifecycle of the subsystem,
> >its governors, cooling devices, thermal zone devices, and their
> >interactions.
> >
> >I don't expect any impact on userspace.
> >
> 
> I applied the whole 48 patch series on top of mainline kernel.
> 
> I see boot crash when i have thermal modules built in kernel for dra7/dra72
> boards.
> 
> dra7 bootlog: http://pastebin.ubuntu.com/16859184/

I will be sending a v4 soon. I will also push to a branch.

