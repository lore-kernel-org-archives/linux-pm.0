From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 02 Sep 2010 22:33:53 +0200
Message-ID: <4C800A31.3050401@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <201009022216.45303.rjw@sisk.pl> <4C800829.9040802@gmail.com> <201009022228.07626.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201009022228.07626.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 09/02/2010 10:28 PM, Rafael J. Wysocki wrote:
> That would be very nice.  In particular, I'd like to get rid of the
> pm_message_t thing if possible.  And I'd like to avoid putting the
> controller into D3 before creating hibernation image. :-)

Oh, yeah, things like that can definitely be changed, but I think it
would still need to be piped through EH.  That's how the queue gets
quiesced for those special operations and resume is basically probing,
so it doesn't make much sense to split them.  Please let me know how
it should work from power management POV and I'll be happy to convert
libata to fit the new behavior.

Thanks.

-- 
tejun
