From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 11:33:39 +0200
Message-ID: <200707241133.40287.rjw__29425.3907319673$1185269283$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707231124590.3545-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707231124590.3545-100000@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 23 July 2007 22:05, Alan Stern wrote:
> [Note changed $SUBJECT]
[--snip--]
> =============================
> 
> 
> Now here's an idea which might work.  Can we require every caller of
> device_add() to hold some existing device's semaphore?  Normally it
> would be the semaphore of the new device's parent, but it could be a
> higher ancestor.  There even could be a single "root" semaphore for
> drivers registering a top-level device with no parent.
> 
> (Some testing shows that during startup things like ACPI and IDE don't 
> fulfill this requirement, so maybe we should require it only after 
> userspace has begun running.  After all, the system can't suspend 
> until then.)
> 
> It seems like a reasonable sort of thing to do.  Hotplugged devices
> tend to be registered as they are discovered by their parent's driver,
> so it shouldn't be too much to ask that the parent's semaphore be held
> when the new device is registered.  Static devices generally aren't
> quite so nice; the serial and floppy drivers in particular would need a
> little work (and probably some other drivers too).
> 
> If we do this, then once the PM core has acquired the semaphore for 
> every device it will be guaranteed that no new devices can be added.  
> It would be a simple solution to a rather nasty problem.

Hmm, in device_pm_add() and device_pm_remove() we acquire dpm_list_mtx which
also is acquired by device_suspend() and device_resume().  Thus, every attempt
to register a new device or unregister an existing one will be blocked while
either device_suspend() or device_resume() is running.

If we arrange things so that dpm_list_mtx is acquired, but not released, by
device_suspend() and released, but not acquired, by device_resume(), then it
won't be possible to register/unregister a device during a suspend-resume
cycle.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
