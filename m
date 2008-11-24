From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to platform-level
 handler
Date: Mon, 24 Nov 2008 16:34:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811241627560.6702-100000@iolanthe.rowland.org>
References: <20081124210949.GA28085@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081124210949.GA28085@trantor.hsd1.or.comcast.net>
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

> Ack. This is what we are already doing.  The decision on whether or 
> not a device should wake us up from suspend is handle via OHM on the 
> XO and we set the OLPC-specific flags in /sys/power/wakeup_events as 
> there is no standard way to specify wakeup events from userland.
> 
> My proposal uses the existing sysfs interface to connect into a platform 
> level handler that can set the appropriate low-level HW bits. The
> decision of whether or not to enable the device's wakeup capability
> would still be left to user space. 

Then I must have misunderstood the point of your earlier message.  Are
you saying that the real problem is to tie the existing
/sys/devices/.../power/wakeup flags into your platform handler?

The sources you listed (ac_power, battery_state, and so on) are all 
pretty much platform-level entities to begin with.  Their drivers must 
already contain or communicate with a fair amount of platform-level 
code.  So why should there be any trouble about adding a new 
communication channel for wakeup settings?

Alan Stern
