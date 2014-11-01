From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 30/47] x86: iris: Register with kernel power-off
 handler
Date: Sat, 1 Nov 2014 20:41:29 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411012040510.5308@nanos>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net> <1414425354-10359-31-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47378 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252AbaKATle (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Nov 2014 15:41:34 -0400
In-Reply-To: <1414425354-10359-31-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

On Mon, 27 Oct 2014, Guenter Roeck wrote:

> Register with kernel power-off handler instead of setting pm_power_off
> directly. Register with high priority to reflect that the original code
> overwrites existing power-off handlers.

Acked-by-me for all the x86 parts of that series.

Thanks,

	tglx

