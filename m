From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 07/14] power/avs: Use %pS printk format for direct
 addresses
Date: Fri, 8 Sep 2017 18:37:41 -0500
Message-ID: <20170908233740.btg2zvor2ajxc6u5@kahuna>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-8-git-send-email-deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:32177 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbdIHXhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 19:37:50 -0400
Content-Disposition: inline
In-Reply-To: <1504729681-3504-8-git-send-email-deller@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org

On 20:27-20170906, Helge Deller wrote:
> Use the %pS instead of the %pF printk format specifier for printing symbols
> from direct addresses. This is needed for the ia64, ppc64 and parisc64
> architectures.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: linux-pm@vger.kernel.org

Looks fine to me at least. Kevin/Rafael if you'd like to pick this up in
some rc or later cycle..

Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
