From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] x86, ACPI: Constify irq_domain_ops
Date: Tue, 28 Apr 2015 09:22:51 +0200
Message-ID: <20150428072251.GA8772@amd>
References: <1430138889-3310-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42985 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbD1HWy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 03:22:54 -0400
Content-Disposition: inline
In-Reply-To: <1430138889-3310-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sfi-devel@simplefirmware.org

On Mon 2015-04-27 21:48:07, Krzysztof Kozlowski wrote:
> The irq_domain_ops are not modified by the driver and the irqdomain core
> code accepts pointer to a const data.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
