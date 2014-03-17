From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] PM / Runtime: Update runtime_idle() documentation
 for return value meaning
Date: Mon, 17 Mar 2014 21:27:42 +0100
Message-ID: <20140317202742.GA27222@amd.pavel.ucw.cz>
References: <1395087971-31897-1-git-send-email-geert@linux-m68k.org>
 <1395087971-31897-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38311 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaCQU1p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Mar 2014 16:27:45 -0400
Content-Disposition: inline
In-Reply-To: <1395087971-31897-2-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Mon 2014-03-17 21:26:11, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> As of commit 45f0a85c8258741d11bda25c0a5669c06267204a ('PM / Runtime:
> Rework the "runtime idle" helper routine'), the return value of
> ->runtime_idle() is no longer ignored by the PM core, but used to decide
> whether to suspend the device or not.
> 
> Update the documentation to match the code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
