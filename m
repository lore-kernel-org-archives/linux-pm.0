From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 14/16] intel_idle: remove use and definition of MWAIT_MAX_NUM_CSTATES
Date: Mon, 11 Feb 2013 18:46:14 -0500
Message-ID: <511982C6.7080505@kernel.org>
References: <1360372100-28482-1-git-send-email-lenb@kernel.org> <137ecc779c80138723677209730738d76262e810.1360371180.git.len.brown@intel.com> <5118B16E.6010709@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:36829 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab3BKXqR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 18:46:17 -0500
In-Reply-To: <5118B16E.6010709@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On 02/11/2013 03:53 AM, Daniel Lezcano wrote:
> On 02/09/2013 02:08 AM, Len Brown wrote:

>> The reason to change is that intel_idle will soon be able
>> to export more than the 8 "major" states supported by MWAIT.
>> When we hit that limit, it is important to know
>> where the limit comes from.
> 
> Does it mean CPUIDLE_STATE_MAX may increase in a near future ?

Yes, perhaps to 10.
Let me know if you anticipate issues with doing that.

thanks,
Len Brown, Intel Open Source Technology Center

