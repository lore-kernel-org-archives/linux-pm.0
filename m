From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC Disable suspend on a specific device] This is a
	little	change in linux power scheme
Date: Tue, 7 Apr 2009 22:40:07 +0200
Message-ID: <20090407204007.GD3278@elf.ucw.cz>
References: <20090407102914.GA25796@gandalf.sssup.it>
	<200904071545.03167.rjw@sisk.pl>
	<49DB73C7.2090406@gandalf.sssup.it>
	<200904072055.08322.rjw@sisk.pl>
	<49DBA319.3030008@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49DBA319.3030008@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

>>> I works on an hardware that have the gsm connect to wm8753 and the  
>>> bluetooth subsystem
>>> too direct connected. So I would like that a phone call for example  
>>> remains on during
>>> system suspend. With this approch I can disable suspend of an entire  
>>> subtree of device,
>>> that can be used by other hardware component. This change avoid any  
>>> specific change to the
>>> driver.
>>
>> Why do you want to avoid changing the driver, actually?
>>   
> Because, the driver may be connected to other device and you must change  
> the entire
> set. This simple modification can help to share devices on an embedded  
> board and control
> suspend/resume enable from user space. I don't know if it can be usefull  
> on broken board/device too. Do you see any possible risk with this  
> change? 

Yes. Most devices (on a PC for example) will not like this being
enabled, right? So you are basically introducing a "break me" sysfs
variable.

I guess you should audit the drivers you are interested in to see if
they can survive with the hardware alive while the rest of system is
suspended, then add the option to the ones that can.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
