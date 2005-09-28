From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with PM_FREEZE
Date: Wed, 28 Sep 2005 21:09:24 +0200
Message-ID: <200509282109.25419.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0509281451010.5193-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509281451010.5193-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 28 of September 2005 20:54, Alan Stern wrote:
> On Wed, 28 Sep 2005, Rafael J. Wysocki wrote:
> 
> > IMO if the driver is a module it should not make any assumptions
> > on the state of the device when its resume routine is called.  Instead,
> > it should assume the device can be in an arbitrary state and proceed
> > in the safest way possible.  Which is 3.
> 
> That's what it should do when resuming from disk.
> 
> But that's not what it should do when it's being resumed just after the
> memory image was created, in order to write out the image.  In this case
> the device is known to be in FREEZE, not SUSPEND, and to save time we
> would like the driver not to go through a full resume procedure.
> 
> The problem is that currently the driver has no way to tell the difference
> between the two types of resume.  What's needed is a way for driver to 
> tell, and that can be added easily enough.

Yes, I've been thinking about it for some time.  It seems to me we could do
this with the help of an additional field in pm_message_t.

Greetings,
Rafael
