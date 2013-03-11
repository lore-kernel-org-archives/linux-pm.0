From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] kirkwood: fix coccicheck warnings
Date: Mon, 11 Mar 2013 21:49:31 +0800
Message-ID: <CAOh2x==ECHa4=5Xz+7B9KVJh_8FM1=QndoFkG-unR_8+4PeTWg@mail.gmail.com>
References: <1362987319-6369-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:56993 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3CKNtc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 09:49:32 -0400
In-Reply-To: <1362987319-6369-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: cpufreq@vger.kernel.org, rjw@sisk.pl, rui.zhang@intel.com, andrew@lunn.ch, jason@lakedaemon.net, rob.lee@linaro.org, len.brown@intel.com, khilman@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 11, 2013 at 3:35 PM, Silviu-Mihai Popescu
<silviupopescu1990@gmail.com> wrote:
> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
>
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
>
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
