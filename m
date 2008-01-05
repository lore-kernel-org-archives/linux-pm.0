From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sat, 5 Jan 2008 22:13:38 +0100
Message-ID: <200801052213.39891.rjw__22820.9242727191$1199567579$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801051537450.26040-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801051537450.26040-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 of January 2008, Alan Stern wrote:
> On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:
> 
> > > Another thing to watch out for: Just in case somebody ends up calling
> > > destroy_suspended_device(dev) from within dev's own resume method, you 
> > > should interchange the resume_device() and the list_move_tail() 
> > > calls in dpm_resume().
> > 
> > However, if we unregister them all at once after releasing pm_sleep_rwsem,
> > that shouldn't be necessary, right?
> 
> It's still necessary, because destroy_suspended_device() still has to
> move the device from one list to another.  You don't want it to end up 
> on the dpm_locked list.

Hmm.  That means we'd have to do the same thing in dpm_power_up() in case
someone calls destroy_suspended_device() from resume_device_early(dev).

Still, even doing that is not enough, since someone can call
destroy_suspended_device() from a .suspend() routine and then the device
will end up on a wrong list just as well.

Greetings,
Rafael
