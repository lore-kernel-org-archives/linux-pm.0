From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 31/47] x86: apm: Register with kernel poweroff
 handler
Date: Tue, 21 Oct 2014 10:46:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410211045530.24255@pobox.suse.cz>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-32-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45257 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbaJUIql (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Oct 2014 04:46:41 -0400
In-Reply-To: <1413864783-3271-32-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

On Mon, 20 Oct 2014, Guenter Roeck wrote:

> Register with kernel poweroff handler instead of setting pm_power_off
> directly. Register with high priority to reflect that the original code
> overwrites existing poweroff handlers.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

For this one:

	Reviewed-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs
