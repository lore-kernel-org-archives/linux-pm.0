From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: power/level and power/control
Date: Fri, 12 Mar 2010 09:44:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003120941040.1771-100000__4714.91044522754$1268405403$gmane$org@iolanthe.rowland.org>
References: <201003112300.11761.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003112300.11761.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Mar 2010, Rafael J. Wysocki wrote:

> On Thursday 11 March 2010, Alan Stern wrote:
> > Greg & Rafael:
> > 
> > In 2.6.34-rc1 we have the new /sys/devices/.../power/control attribute, 
> > which does exactly the same thing as USB's existing power/level 
> > attribute.
> > 
> > There's no reason to keep both.  I'd remove power/level entirely, 
> > except that it has been in existence for a while and people may be 
> > using it.
> > 
> > The best solution may be to replace "level" with a symbolic link to 
> > "control", and possibly also to deprecate it.  Does that seem like the 
> > right thing to do?
> 
> Sounds reasonable to me.

On Thu, 11 Mar 2010, Greg KH wrote:

> Sounds good to me.

Alas, it turns out that sysfs doesn't provide any way to create 
symlinks to attribute files (and especially not to attribute files in 
group directories).

I could add such a thing, but maybe it will be better to keep the
existing attribute code for a year or so and add a WARN_ONCE to let
people know it's going to be removed.

Alan Stern
