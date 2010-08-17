From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Tue, 17 Aug 2010 17:04:47 +0200
Message-ID: <4C6AA50F.3090801@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C6A6145.7020707@gmail.com> <201008171229.28917.stephan.diestelhorst@amd.com> <201008171251.29441.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008171251.29441.stephan.diestelhorst@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/17/2010 12:51 PM, Stephan Diestelhorst wrote:
> I *think* I have applied the patch correctly. Please find a copy of
> "git show" in the build directory attached. This should be the right
> thing, shouldn't it?

Yeah, looks right to me but if you have enabled IPM, there gotta be
at least some XXX messages in the log.  Weird.

> Maybe I forgot to speify a particular debug option / verbosity?

Hmmm... all messages are at KERN_INFO level and they don't have any
switch.

> I've also confirmed that the "XXX ahci_set_ipm" is present in
> libahci.ko. So either I've screwed up badly when compiling the initrd,
> the code is not executed or the printout does not make it into any
> logfile anymore.

Yeah, that's weird.  You're enabling IPM, right?

Thanks.

-- 
tejun
