From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 2 Sep 2010 22:16:45 +0200
Message-ID: <201009022216.45303.rjw@sisk.pl>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7F6931.4050707@gmail.com> <4C7F7649.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C7F7649.3010409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 02, 2010, Tejun Heo wrote:
> For some mysterious reason, certain hardware reacts badly to usual EH
> actions while the system is going for suspend.  As the devices won't
> be needed until the system is resumed, ask EH to skip usual autopsy
> and recovery and proceed directly to suspend.

Putting the issue at hand aside, I'm not really sure if using SCSI EH for
suspending the controller is a good idea.  It seems overly complicated and
it doesn't match the new PCI suspend model with separate ->suspend(),
->freeze() and ->poweroff() callbacks.  Moreover, the passing of pm_message_t
back and forth doesn't make things clear either.

Would it be possible to rework this thing entirely at one point?

Rafael
