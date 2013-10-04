From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] Thermal: Tidy up error handling in powerclamp_init
Date: Fri, 4 Oct 2013 09:37:15 -0700
Message-ID: <20131004093715.5a3e43c6@ultegra>
References: <1380903804-18913-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38063 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab3JDQhP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Oct 2013 12:37:15 -0400
In-Reply-To: <1380903804-18913-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Fri,  4 Oct 2013 21:53:24 +0530
Durgadoss R <durgadoss.r@intel.com> wrote:

> This patch
>  * adds missing kfree() for cpu_clamping_mask
>  * adds return value checking for alloc_percpu()
>  * unregister hotcpu notifier in exit path
looks good. thanks for the fix.

Jacob
