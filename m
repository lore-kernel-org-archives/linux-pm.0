From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level?handler
Date: Tue, 25 Nov 2008 13:57:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811251351360.2457-100000@iolanthe.rowland.org>
References: <20081125180744.GA4184@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081125180744.GA4184@trantor.hsd1.or.comcast.net>
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

On Tue, 25 Nov 2008, Deepak Saxena wrote:

> > > Just thought of something. Not all the devices we can wakeup on are
> > > platform devices. The WLAN specifically is an on-board USB device with
> > > a sideband wakeup signal connected to the EC. So instead I'll make the
> > > set_wakeup() ptr a member of struct device and call it in device_suspend().
> > 
> > No, don't do that.  If the device has a sideband wakeup signal then the 
> > device's driver should be aware of that signal.  So the driver should 
> > be modified, not the device core.  The driver can ask the platform code 
> > to do whatever is necessary.
> 
> What is the method to connect between the driver's WOL code and the platform
> code in this situation? 

It depends on the hardware and the driver.  Is this a specialized sort 
of USB WLAN device with features specific to the XO?  How is the 
sideband wakeup signal implemented?  Does the driver know that it is 
running on an XO?  Does the driver know that this sideband signal 
exists?

The easiest answer is for the driver to call directly into the platform
code.

Alan Stern
