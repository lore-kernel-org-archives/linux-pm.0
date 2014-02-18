From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 0/5] intel_pstate updates for v3.14-rcX
Date: Tue, 18 Feb 2014 12:29:54 -0800
Message-ID: <5303C2C2.8040605@intel.com>
References: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51501 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaBRU36 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 15:29:58 -0500
In-Reply-To: <1392228067-14817-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: dirk.j.brandewie@intel.com, linux-kernel@vger.kernel.org

Hi Rafael,

On 02/12/2014 10:01 AM, dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Based on v3.14-rc2
>
> Patch 1 removes energy reporting the patch from Maurizio Lambardi
>   intel_pstate: fix race condition in intel_pstate_init() can be dropped.
>

Any reason why patches 2-5 did not make rc3 other than timing?

Patches 2/3 can easily wait for v3.15.x

Patches 4/5 fix bugs that are in the wild.


> Patch 2-3 cleanups
>
> Patch 4-5 Baytrail bug fixes
>
> Dirk Brandewie (5):
>    intel_pstate: Remove energy reporting from pstate_sample tracepoint
>    intel_pstate: remove unneeded sample buffers
>    intel_pstate: fix pid_reset to use fixed point values
>    intel_pstate: Use LFM bus ratio as min ratio/P state
>    intel_pstate: Add support for Baytrail turbo P states
>

--Dirk

