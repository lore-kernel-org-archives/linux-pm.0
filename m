From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 20:34:49 +0100
Message-ID: <201101132034.49522.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1101131154350.2022-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101131154350.2022-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 13, 2011, Alan Stern wrote:
> On Thu, 13 Jan 2011, Daniel Drake wrote:
> 
> > On Thu, 2011-01-13 at 10:14 -0500, Alan Stern wrote:
> > > On Thu, 13 Jan 2011, Daniel Drake wrote:
> > > 
> > > > As for contents, it will read back a string. One of:
> > > > 
> > > > rtc alarm
> > > > power button
> > > > lid
> > > > key press
> > > > battery
> > > > battery state changed
> > > > battery error
> > > > ebook
> > > > wlan packet
> > > > ac power
> > > > battery critical
> > > > gp timer
> > > > hda
> > > > usb
> > > > unknown
> > > 
> > > Wouldn't it be better to read back a device pathname when the wakeup
> > > source can be identified as a particular device?  Whoever uses this 
> > > field should be responsible for converting it to one of those more 
> > > generic forms.
> > 
> > It could be done, but might be ugly. The problem is that those
> > individual devices don't really know that they were woken up. It's done
> > by OLPC's EC driver. So the EC driver would have to either hardcode
> > device paths, or have a load of device-hunting code.

Alternatively, it could store the information somewhere and have some special
code down the resume code path turn it into the info available from sysfs.

> > Another small problem is that it doesn't encode the difference between
> > "battery state changed" and "battery error", for example.
> > 
> > If it's really disliked as a string, perhaps it would be OK just to
> > stash it within the sysfs directory of our device, not polluting the
> > global namespace.
> > 
> > I'm hoping this can all be a temporary measure anyway, as future closer
> > integration with Rafael's wakeup events architecture plus the ability
> > for that architecture to export wakeup source info should make it go
> > away.

Well, if that's supposed to be temporary, it shouldn't be there in
/sys/power/, so please put it somewhere else in that case.

> You can do whatever is best for you on the OLPC platform; I was just 
> offering a suggestion.

It looks like Daniel wants the wakeup events framework to store the last
active wakeup source information somewhere (eg. in a file in /sys/power).
I'm a little bit worried about that, because potentially there may be many
wakeup events occuring at run time, in which case it would be a significant
performance overhead to update the "last active wakeup source" info every
time (and a scalability issue, because every code path handling a wakeup
source would want to update the same sysfs file).  Also, collecting that
information at run time doesn't seem to be particularly useful.

It may be useful to know what device has actually woken up the system from
suspend.  To that end, I think the only really valid approach is to retrieve
this information from the platform firmware early during resume and export
it through a sysfs attribute afterwards.  We can develop a generic helper
code for that second part, but the first one has to be platform-specific.

Daniel, what exactly does your user space use this information for?

Thanks,
Rafael
