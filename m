From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Thu, 02 Sep 2010 11:06:57 +0200
Message-ID: <4C7F6931.4050707@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7376BE.5040006@gmail.com> <201008242239.43249.rjw@sisk.pl> <201008270109.36687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008270109.36687.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On 08/27/2010 01:09 AM, Rafael J. Wysocki wrote:
> Well, no luck.  I was able to reproduce the issue on my box with this patch
> applied on top of 2.6.32-rc2.
> 
> Which probably means that the link power management is not really involved
> here and seems to turn up this statement:
> 
> rc = ata_host_request_pm(host, mesg, 0, ATA_EHI_QUIET, 1);
> 
> in ata_host_suspend() as the culprit.
> 
> Does it make sense?

So, LPM doesn't have anything to do with the problem.  The fact that
this only happens on specific machines is strange.  Maybe the BIOS is
doing something fishy to the controller on disk spindown during
suspend.  Can the BIOS tell that the system is going for suspend by
the time sd suspend is called?  I'll prep another patch which will
make EH skip certain steps and ignore failures during suspend, which
basically mimics what your patch does but in safer way.

Thanks.

-- 
tejun
