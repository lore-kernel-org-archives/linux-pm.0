From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : [HELP] Power management for embedded system
Date: Fri, 25 Aug 2006 13:18:43 +0000 (GMT)
Message-ID: <20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
References: <20060824162034.GB19753@srcf.ucam.org>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751270AbWHYNSq@vger.kernel.org>
In-Reply-To: <20060824162034.GB19753@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> Triggering suspend/resume is already generic in the form of the 
> /sys/power/state interface. There's been discussion of producing a 
> generic battery class lately. There's some trend towards tying suspend 
> requests into the input layer, but how appropriate that is may depend on 
> the hardware in question. I think most of the pieces are in place to 
> provide an interface that isn't tied to looking like APM, and there's

what about suspend/resume event handling ? Is there something already in
place ?
 
Francis
