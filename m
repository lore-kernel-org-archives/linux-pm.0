From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 02 Sep 2010 22:25:13 +0200
Message-ID: <4C800829.9040802@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7F6931.4050707@gmail.com> <4C7F7649.3010409@gmail.com> <201009022216.45303.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201009022216.45303.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 09/02/2010 10:16 PM, Rafael J. Wysocki wrote:
> Putting the issue at hand aside, I'm not really sure if using SCSI EH for
> suspending the controller is a good idea.  It seems overly complicated and
> it doesn't match the new PCI suspend model with separate ->suspend(),
> ->freeze() and ->poweroff() callbacks.  Moreover, the passing of pm_message_t
> back and forth doesn't make things clear either.
> 
> Would it be possible to rework this thing entirely at one point?

Well, I think I would need more than that to rework the whole thing.
There are a lot of benefits in sharing the same path between probing /
error handling and suspend/resuming.  ATA has a lot of quirks which
have to be dealt with and it will be very fragile to scatter handling
logics over multiple separate paths.  We definitely can try to make
the plumbing from power management easier to follow.

Thanks.

-- 
tejun
