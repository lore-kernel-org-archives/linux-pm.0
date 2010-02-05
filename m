From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
 disabling device run-time PM (rev. 2)
Date: Fri, 5 Feb 2010 10:19:18 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002051014020.22829-100000__20307.9953826547$1265383310$gmane$org@netrider.rowland.org>
References: <20100205062718.GA1384@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100205062718.GA1384@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Feb 2010, Pavel Machek wrote:

> 
> > > > + *	The default for all devices is "auto", which means that devices may be
> > > > + *	subject to automatic power management, depending on their drivers.
> > > 
> > > Is it wise to specify 'auto' default value for devices without runtime
> > > pm?
> > 
> > Yes, it is.  It means the user space doesn't care whether or not the device is
> > power managed at run-time.
> 
> Well, defaulting to 'on' for drivers when runtime pm is experimental
> seems logical. and there will be such drivers...

It's really not very important what the default setting is.  Runtime PM
is always initially disabled, regardless of the "auto"/"on" setting,
until the driver explicitly enables it.  At that time the driver also
has the option of changing the setting from "auto" to "on".

So if a driver writer wants to support runtime PM but thinks that his
implementation (or the device!) may be buggy, he can easily arrange
things so the user has to change the sysfs setting to make anything
happen.

Alan Stern
