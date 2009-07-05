From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM interface to suspend/resume individual/specific
	device
Date: Sun, 5 Jul 2009 23:30:48 +0200
Message-ID: <200907052330.48382.rjw@sisk.pl>
References: <F12CE1A68F023D498A2691C7B539311503655A9A@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <F12CE1A68F023D498A2691C7B539311503655A9A@ZMY16EXM66.ds.mot.com>
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
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 05 July 2009, HU TAO-TGHK48 wrote:
> Below command would suspend all of devices and system
> # echo mem > /sys/power/state  
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

No, and you can't suspend individual devices in general.  There is such a
mechanism for USB devices.

The problem is that suspend while entering a system sleep state is generally
a different operation from a suspend done at run time and the latter wouldn't
be suitable for testing the former.

If you need to test the suspend-resume of a driver, please use the
/sys/power/pm_test interface (it works on the entire system, but it doesn't
complete the suspend, so it's suitable for testing).

Thanks,
Rafael
