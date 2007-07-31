From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Suspend without the freezer
Date: Tue, 31 Jul 2007 11:05:40 +0200
Message-ID: <200707311105.40449.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707301634250.2546-100000@iolanthe.rowland.org>
	<200707302352.56033.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707302352.56033.dtor@insightbb.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 31 July 2007 05:52, Dmitry Torokhov wrote:
> Hi Alan,
> 
> On Monday 30 July 2007 16:48, Alan Stern wrote:
> > Dmitry:
> > 
> > I'm trying to help eliminate the need for the freezer during suspend.  
> > For it to work, we have to prevent threads which otherwise would have 
> > been frozen from trying to bind drivers to suspended devices or trying 
> > to register new devices whose parents are already suspended.
> > 
> > To help accomplish this, the PM core can acquire the device semaphores
> > for all existing devices before suspending any of them.  That will
> > prevent attempts at binding.  It would also prevent registration of new
> > children, _if_ the driver doing the registration had to acquire the
> > parent's semaphore first.  But many drivers don't do this.
> > 
> > One thought was to have the PM core acquire and hold the dpm_list_mutex 
> > throughout the suspend.  This would block registration attempts at the 
> > point where the new device is added to the PM core's device-list.
> >
> 
> I think blocking at this point is too late - many drivers muck with
> the device in different ways before registering the "result" with
> driver core. The device may be half-awaken by then.
>   
> > Unfortunately it creates several lockdep violations.  For example, the 
> > serio core holds serio->drv_mutex while input_register_device is 
> > called (which acquires dpm_list_mutex), and it acquires 
> > serio->drv_mutex in serio_suspend and serio_resume (which would be 
> > called while the PM core holds dpm_list_mutex).
> > 
> > I'm having trouble coming up with a way to block registrations during 
> > suspend that won't create a possibility for deadlock.  Do you have any 
> > suggestions?  A scheme that would work for the input layer ought to be 
> > generally applicable.
> >
> 
> One option would be to have a separate thread running registration/binding/
> unbinding (like serio core does). You can stop this thead during suspend
> and resume so that requests are queued up and you process them later, when
> you are ready...

Sounds good.

An alternative could be to have a rwsem taken for writing by the PM core and
for reading by registration/binding/unbinding (and other suspend-sensitive code
paths).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
