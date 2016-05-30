From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2 00/40]
Date: Mon, 30 May 2016 15:16:06 -0700
Message-ID: <20160530221605.GA14174@localhost.localdomain>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33876 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161691AbcE3WQL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 18:16:11 -0400
Content-Disposition: inline
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, May 30, 2016 at 02:27:19PM -0700, Eduardo Valentin wrote:
> Folks,
> 
> This is V2 of a patch series to improve thermal core. The idea
> here is to reorganize the code and improve the way we
> handle sysfs entries.
> 
> The change in behavior is that now, thermal zones with empty
> .type will not be allowed to be registered. Also, the way
> we handle scanf's return code is now checking for
> number of successful inputs.
> 
> After this series, thermal core is split into the following files:
> - thermal_sysfs.c: contains the functions handling the sysfs nodes
> - thermal_helpers.c: groups functions that do not need to touch thermal
> core internal data structures, such as internal lists, and list locks.
> - thermal_core.c: functions to handle the lifecycle of the subsystem,
> its governors, cooling devices, thermal zone devices, and their
> interactions.
> 
> I don't expect any impact on userspace.
> 
> Please give your inputs.
> 
> V1->V2:

Please ignore this one. I am sending V3 now.
