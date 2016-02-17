From: Oliver Neukum <oneukum@suse.com>
Subject: Re: suspend resume query
Date: Wed, 17 Feb 2016 10:10:41 +0100
Message-ID: <1455700241.7626.10.camel@suse.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44512 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965115AbcBQJNR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Feb 2016 04:13:17 -0500
In-Reply-To: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On Tue, 2016-02-16 at 22:36 +0530, Ryan wrote:
> Hello,
> 
> what is the role of bootloaders and bootrom code when system during
> linux suspend-resume?

Your question is imprecise. I am now assuming you are talking
about ACPI and S3.

bootloader - none at all. It isn't used.

bootrom - Well, that depends on the vendor.
The system is suspended in the sense that the CPU is powered
down by the firmware. The kernel calls an ACPI method. The
firmware also gets control of the system as a resume from S3
means a full reset for the CPU and the bootstrap code in the
firmware runs.

I am afraid you need to give more details for a better answer.

	Regards
		Oliver


