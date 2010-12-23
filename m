From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 23 Dec 2010 11:03:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012231055440.5617-100000__29640.3140797795$1293120315$gmane$org@netrider.rowland.org>
References: <AANLkTi=9kjmb3evOON3WMoGjqadDHqqBKVH4viT02Qf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=9kjmb3evOON3WMoGjqadDHqqBKVH4viT02Qf9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Dec 2010, Ohad Ben-Cohen wrote:

> On Sun, Dec 19, 2010 at 12:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > That said, I think we may do something different that perhaps will make your
> > life somewhat easier.
> ...
> > So, I think we can add a "runtime only" flag working as described above.
> 
> That will definitely solve the suspend/resume issue we're having.
> 
> But due to /sys/devices/.../power/control, we will still have to
> bypass runtime PM for this particular device.
> 
> We need a way to unconditionally power down the device, and as long as
> runtime PM can be disabled by the user, we can't use it.

I'm still not aware of the details of your situation.  Nevertheless, it
shouldn't be hard to set up a suspend() routine that would do whatever
was needed to power down the device, whether this means calling the 
runtime_suspend() routine directly or something else.  That's basically 
what every other driver does.

By definition, system sleep transitions require bypassing runtime PM.  
There's nothing odd or unusual about it.

Alan Stern
