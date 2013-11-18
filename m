From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] intel_powerclamp: Fix cstate counter detection.
Date: Mon, 18 Nov 2013 08:22:33 -0800
Message-ID: <528A3EC9.8060301@linux.intel.com>
References: <1384758395-5074-1-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8478 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab3KRQWf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Nov 2013 11:22:35 -0500
In-Reply-To: <1384758395-5074-1-git-send-email-yshuiv7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuxuan Shui <yshuiv7@gmail.com>, linux-pm@vger.kernel.org
Cc: jacob.jun.pan@linux.intel.com

On 11/17/2013 11:06 PM, Yuxuan Shui wrote:
> Having all zero cstate count doesn't necesserily mean the cstate
> counter is no functional.
>

... but it does mean that powerclamp will be non-functional

but you had a reason to make this patch.
Can you expand a little bit on what you were seeing that made you
decide this patch was needed ?

