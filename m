From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM status sysfs attribute
Date: Thu, 1 Jul 2010 23:13:41 +0200
Message-ID: <201007012313.41826.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1007011621190.1303-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007011621190.1303-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 01, 2010, Alan Stern wrote:
> On Thu, 1 Jul 2010, Dominik Brodowski wrote:
> 
> > Alan,
> > 
> > On Thu, Jul 01, 2010 at 01:16:31PM -0400, Alan Stern wrote:
> > > As runtime PM becomes more and more popular, it seems likely that 
> > > people will want to know whether or not their devices are getting 
> > > suspended.  Or if not people, then programs like powertop.
> > > 
> > > For that reason, it seems to make sense to build the runtime_status
> > > sysfs attribute even when CONFIG_PM_ADVANCED_DEBUG isn't enabled.  Do
> > > you agree?
> > 
> > good idea; haven't looked at any dependencies yet, though...
> 
> Reading through the code shows there is a drawback: For subsystems that
> don't implement runtime PM, devices will always show up as "suspended".  
> That's not going to be very useful, unfortunately.
> 
> Still, for subsystems that _do_ implement runtime PM, there doesn't 
> seem to be any other way to learn the current status of a device.

Perhaps we can rework the attribute to show "unknown" for devices that
have power.disable_depth > 0 ?

Rafael
