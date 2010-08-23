From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Mon, 23 Aug 2010 14:03:40 +0200
Message-ID: <4C72639C.6090108@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <AANLkTin2XPHXL_o9hHz9f4beTYEx+isX+PaFRkMMiYHQ@mail.gmail.com> <4C6B79C8.7080602@gmail.com> <201008191823.57915.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008191823.57915.stephan.diestelhorst@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello, sorry about the delay.

On 08/19/2010 06:23 PM, Stephan Diestelhorst wrote:
> It says "max_performance", I have not touched anyhting. So it has been
> like that all the time. Would this explain why your patch did not show
> the debug printout?

Hmm... okay.  Yeah, if you haven't been using IPM at all, there won't
be any debug messages but at the same time the posted patch should
have had the same effect as Rafael's patch as IPM path isn't traveled
at all.  Can you please check the followings?

* You're actually running the correct patched kernel and modules.  It
  probably is a good idea to add a printk message.  ie. Apply the
  patch and add a printk() in ata_host_request_pm() in libata-core.c
  and make sure the debug messages appears.

* Rafael's patch actually fixes the problem.  If you haven't been
  using IPM at all, Rafael's patch and mine should behave exactly the
  same (ie. no IPM operation at all during suspend/resume).  It could
  be that you're seeing a different issue.

Rafael, can you please test my patch and see how your case behaves?

Thanks.

-- 
tejun
