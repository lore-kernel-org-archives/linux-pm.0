From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [patch V2 00/12] thermal/x86_pkg_temp: Sanitize hotplug and
 locking
Date: Tue, 29 Nov 2016 21:27:59 -0800
Message-ID: <20161130052758.GB27252@localhost.localdomain>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35421 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcK3F2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 00:28:03 -0500
Content-Disposition: inline
In-Reply-To: <20161122175256.922158782@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

Rui,

On Tue, Nov 22, 2016 at 05:57:04PM -0000, Thomas Gleixner wrote:

<cut>

> ---
>  x86_pkg_temp_thermal.c |  593 ++++++++++++++++++++-----------------------------
>  1 file changed, 249 insertions(+), 344 deletions(-)

I am assuming you are handling this one in your tree directly. In any
case, you can add my:

Acked-by: Eduardo Valentin <edubezval@gmail>

for the series.

BR,

Eduardo

