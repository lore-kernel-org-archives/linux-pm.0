From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: Re: PM interface to suspend/resume individual/specific
	device
Date: Mon, 6 Jul 2009 19:01:01 +0800
Message-ID: <F12CE1A68F023D498A2691C7B539311503655C1B@ZMY16EXM66.ds.mot.com>
References: <F12CE1A68F023D498A2691C7B539311503655A9A@ZMY16EXM66.ds.mot.com>
	<200907052330.48382.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200907052330.48382.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 
Hi, Rafael

Thank for the answer.

2 more things
A) The suspend/resume API assumes that  all user space process/kthread
access to driver will be frozen first
    This avoids race condition that processes/threads  are accessing
driver while suspend()/resume() of the driver is called at the same
time.
    
    Is my understanding correct?

B) I noticed your "Run-time PM framework" patch was submitted recently
    Do you think it is fair to allow user space to trigger run-time
suspend/resume for specific device?
    Sine the run-time suspend/resume would be system independent per my
understanding.
    


-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Monday, July 06, 2009 5:31 AM
To: HU TAO-TGHK48
Cc: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] PM interface to suspend/resume
individual/specific device

On Sunday 05 July 2009, HU TAO-TGHK48 wrote:
> Below command would suspend all of devices and system # echo mem > 
> /sys/power/state
> 
> How to just suspend/resume one specific devices? E.g.
> /sys/devices/platform/serial8250
> 
> It would be useful to test the stability of PM interface of individual

> driver.
> If drivers called earlier refuse to suspend then not able to reach the

> suspend/resume function of the specific driver.
> 
> And it would be useful for automatic testing since a script can 
> suspend/resume the specific device for many times without manual 
> operation.
> 
> Is it possible to add "state" for each device?
> E.g. 
> # echo mem > /sys/devices/platform/serial8250/power/state

No, and you can't suspend individual devices in general.  There is such
a mechanism for USB devices.

The problem is that suspend while entering a system sleep state is
generally a different operation from a suspend done at run time and the
latter wouldn't be suitable for testing the former.

If you need to test the suspend-resume of a driver, please use the
/sys/power/pm_test interface (it works on the entire system, but it
doesn't complete the suspend, so it's suitable for testing).

Thanks,
Rafael
