From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level?handler
Date: Tue, 25 Nov 2008 10:09:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811251007460.2457-100000@iolanthe.rowland.org>
References: <20081125042311.GA30965@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081125042311.GA30965@trantor.hsd1.or.comcast.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Nov 2008, Deepak Saxena wrote:

> > So the platform code could initialize the "can_wakeup" setting when it
> > first detects and registers the device.  And you could add a
> > "set_wakeup" function pointer to struct platform_device, which the
> > bus-level suspend and resume routines would invoke to enable or disable
> > remote wakeup, as appropriate.  In the static structures these function 
> > pointers would point to routines that set or clear the appropriate bits 
> > in your Embedded Controller.
> 
> Just thought of something. Not all the devices we can wakeup on are
> platform devices. The WLAN specifically is an on-board USB device with
> a sideband wakeup signal connected to the EC. So instead I'll make the
> set_wakeup() ptr a member of struct device and call it in device_suspend().

No, don't do that.  If the device has a sideband wakeup signal then the 
device's driver should be aware of that signal.  So the driver should 
be modified, not the device core.  The driver can ask the platform code 
to do whatever is necessary.

Alan Stern
