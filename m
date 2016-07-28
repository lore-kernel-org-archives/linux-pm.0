From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM-wakeup: Delete unnecessary checks before three
 function calls
Date: Thu, 28 Jul 2016 21:33:34 +0200
Message-ID: <20160728193334.GB11657@amd>
References: <5307CAA2.8060406@users.sourceforge.net>
 <5786434.e97HVzPjpI@vostro.rjw.lan>
 <b243d2ba-a359-998d-1dd8-43ff444074a8@users.sourceforge.net>
 <1722549.jyvuK0dZRm@vostro.rjw.lan>
 <88d6d524-c093-4fcd-35ba-ff19f7b21fe2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88d6d524-c093-4fcd-35ba-ff19f7b21fe2@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Sat 2016-07-23 17:14:00, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 23 Jul 2016 17:04:00 +0200
> 
> The following functions test whether their argument is NULL
> and then return immediately.
> * dev_pm_arm_wake_irq
> * dev_pm_disarm_wake_irq
> * wakeup_source_unregister
> 
> Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
