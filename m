From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:668
 tick_broadcast_oneshot_control+0x17d/0x190()
Date: Mon, 10 Feb 2014 11:06:53 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402101056260.21991@ionos.tec.linutronix.de>
References: <52F84A9B.5020008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56612 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbaBJKGs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2014 05:06:48 -0500
In-Reply-To: <52F84A9B.5020008@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: poma <pomidorabelisima@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Olaf Hering <olaf@aepfle.de>, Dave Jones <davej@redhat.com>, "Justin M. Forbes" <jforbes@redhat.com>, Josh Boyer <jwboyer@redhat.com>

On Mon, 10 Feb 2014, poma wrote:

> [   83.558551]  [<ffffffff81025b17>] amd_e400_idle+0x87/0x130

So this seems to happen only on AMD machines which use that e400 idle
mode. I have no idea at the moment whats wrong there. I'll find one of
those machines and try to reproduce.

Thanks,

	tglx




