From: Daniel Drake <dsd@laptop.org>
Subject: Re: Trying to understand new wakeup events architecture
Date: Thu, 13 Jan 2011 15:56:26 +0000
Message-ID: <1294934186.2244.38.camel@polyethylene>
References: <Pine.LNX.4.44L0.1101131012090.2022-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1101131012090.2022-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-01-13 at 10:14 -0500, Alan Stern wrote:
> On Thu, 13 Jan 2011, Daniel Drake wrote:
> 
> > As for contents, it will read back a string. One of:
> > 
> > rtc alarm
> > power button
> > lid
> > key press
> > battery
> > battery state changed
> > battery error
> > ebook
> > wlan packet
> > ac power
> > battery critical
> > gp timer
> > hda
> > usb
> > unknown
> 
> Wouldn't it be better to read back a device pathname when the wakeup
> source can be identified as a particular device?  Whoever uses this 
> field should be responsible for converting it to one of those more 
> generic forms.

It could be done, but might be ugly. The problem is that those
individual devices don't really know that they were woken up. It's done
by OLPC's EC driver. So the EC driver would have to either hardcode
device paths, or have a load of device-hunting code.

Another small problem is that it doesn't encode the difference between
"battery state changed" and "battery error", for example.

If it's really disliked as a string, perhaps it would be OK just to
stash it within the sysfs directory of our device, not polluting the
global namespace.

I'm hoping this can all be a temporary measure anyway, as future closer
integration with Rafael's wakeup events architecture plus the ability
for that architecture to export wakeup source info should make it go
away.

Daniel
