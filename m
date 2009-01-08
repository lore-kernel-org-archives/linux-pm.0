From: Frans Pop <elendil@planet.nl>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Thu, 8 Jan 2009 19:55:09 +0100
Message-ID: <200901081955.12021.elendil@planet.nl>
References: <200901080835.39639.rjw@sisk.pl> <200901081736.12926.rjw@sisk.pl>
	<200901081748.58962.oliver@neukum.org>
	<200901081748.58962.oliver@neukum.org>
	<200901081803.49632.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-To: <200901081803.49632.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday 08 January 2009, Oliver Neukum wrote:
>> Am Thursday 08 January 2009 17:36:12 schrieb Rafael J. Wysocki:
>> You are making a very persuasive argument for reverting it.
>> But what about laptops that only have a USB keyboard?
> 
> Well, up to and including 2.6.28 they needed to echo 'enable' to the USB
> controllers' /sys/devices/.../power/wakeup files, so if the patch is
> reverted, they won't be worse off than they were day before
> yesterday. :-) 
> 
> Perhaps we can choose the default depending on whether or not any HID
> devices are attached to given controller?

Is "resume on keyboard activity" really all that needed? Both my laptops 
and my desktop resume fine after pressing the power button.

Also consider the following cases:
- laptop has been suspended with external USB mouse connected
  - mouse is moved (accidentally or because it is in the way of a coffee
    cup)
  - mouse cable is removed before putting the laptop in a bag for
    transport
- laptop is in docking station with USB mouse/kbd connected to that
  - again, mouse gets moved for some reason
  - laptop is undocked while suspended
  - or the reverse: laptop gets docked

IMO it is not desirable that the system gets resumed as a result of any of 
those actions. I'm not complete sure that it would in all those cases, 
but have they been considered?

And in general I've always been in favor of things only happening 
automagically if I've explicitly asked for that, and not by default.

My 2 cents,
FJP
