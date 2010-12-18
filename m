From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 16:29:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012181622460.7965-100000__457.528691231524$1292707852$gmane$org@netrider.rowland.org>
References: <1292690407.3653.2.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292690407.3653.2.camel@jlt3.sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-wireless@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Dec 2010, Johannes Berg wrote:

> Sounds to me like the difference isn't really in the driver, but the
> core PM subsystem. Why does it care when powering off a device whether
> it's during suspend, or during runtime?

The two operations are quite different.  One involves preparing the
device to have its power removed (when the system goes to sleep), and
the other involves actually reducing the device's power.  (In other
words, system suspend involves telling the driver "The computer is
going to sleep in a moment, so get ready", whereas runtime suspend
involves telling the driver "Your device isn't being used now so feel
free to reduce its power".)  There also are differences with regard to
how wakeup events are signalled.  Obviously there's a great deal of
similarity and overlap, but they are _not_ the same in general.

Now these differences don't matter so much to the PM core, but they
should matter to subsystems and drivers.  The PM core cares just enough 
to know that it has to invoke different callbacks for the different 
operations.

Alan Stern
