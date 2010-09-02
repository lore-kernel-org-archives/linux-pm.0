From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 2 Sep 2010 22:11:26 +0200
Message-ID: <201009022211.26783.rjw@sisk.pl>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7F7649.3010409@gmail.com> <201009021633.22869.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201009021633.22869.stephan.diestelhorst@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: Tejun Heo <htejun@gmail.com>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 02, 2010, Stephan Diestelhorst wrote:
> On Thursday 02 September 2010, 12:02:49 Tejun Heo wrote:
> > For some mysterious reason, certain hardware reacts badly to usual EH
> > actions while the system is going for suspend.  As the devices won't
> > be needed until the system is resumed, ask EH to skip usual autopsy
> > and recovery and proceed directly to suspend.
> 
> Thanks Tejun for this patch. Will test in a second!

I'll wait, then, because it takes a couple of days to reproduce it on my machine.

Thanks,
Rafael
