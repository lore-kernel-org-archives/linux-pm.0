From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Tue, 17 Aug 2010 12:15:33 +0200
Message-ID: <4C6A6145.7020707@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201008170951.26073.stephan.diestelhorst@amd.com> <4C6A4395.8080804@gmail.com> <201008171132.56431.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008171132.56431.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/17/2010 11:32 AM, Stephan Diestelhorst wrote:
> Indeed. Like I said, I have similar issues on a another Samsung HDD in
> an AMD system. I have not yet got around to try the fix there, but I
> suspect it is the same thing.
> 
> I have attached the full /var/log/messages and /var/log/kern.log with
> multiple suspend-to-ram runs and the last one failing.

Hmm... are you sure the patch is applied?  There's no debug message
outputs in the log which the patch added.

> Would it make sense to add Rafael's workaround upstream, maybe enabling
> it only for particular platforms / HDDs / with a parameter?

Yeah, maybe.  The problem is that I'm a bit reluctant to do that for
all cases as it may cause other obscure failures and we don't know
whether the problem is controller or device specific at this point,
so...

Thanks.

-- 
tejun
