From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Tue, 17 Aug 2010 13:29:05 +0200
Message-ID: <4C6A7281.3030804@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008171132.56431.stephan.diestelhorst@amd.com> <4C6A6145.7020707@gmail.com> <201008171319.25080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008171319.25080.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/17/2010 01:19 PM, Rafael J. Wysocki wrote:
> Well, I wonder what the real reason for doing the link power management
> thing at this particular point in the suspend code path is.  It just seems to
> disable the link power management, but then the controller is put into a
> low-power state and is reset from scratch during resume, so I'm not quite
> sure how skipping that code could possibly lead to any problems.

Stranger things have happened in the ATA la-la land. :-) Also, it
makes non-lpm and lpm cases leave the controller and device in
different states when it goes to sleep, which _really_ bothers me.
Combined with the timing dependent nature of DIPM, I worry this might
lead to very obscure issues and would much prefer to make sure
everything is in fixed, known, fully powered state before committing
to any major operations.  I might be paranoid tho.  I'll think more
about it.

> Perhaps we could move the link PM manipulation to the prepare stage
> of suspend?

Yeah, one possibility is that the devices misbehave if they receive
LPM commands while suspended.  Does commenting out sd_suspend resolve
the issue too?

Thanks.

-- 
tejun
