From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 06/11] PM: Add user-space wake lock api.
Date: Fri, 30 Jan 2009 23:24:13 -0800
Message-ID: <20090131072413.GA13520@bulgaria.corp.google.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-6-git-send-email-arve@android.com>
	<1231896476-22445-7-git-send-email-arve@android.com>
	<200901301343.08604.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901301343.08604.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[Uli Luckas <u.luckas@road.de>]
> On Wednesday, 14. January 2009, Arve Hj=F8nnev=E5g wrote:
> > This adds /sys/power/wake_lock and /sys/power/wake_unlock.
> > Writing a string to wake_lock creates a wake lock the
> > first time is sees a string and locks it. Optionally, the
> > string can be followed by a timeout.
> > To unlock the wake lock, write the same string to wake_unlock.
>
> What happens if a process takes a lock and then dies?
> Instead of using sysfs, how about using a device for this purpose which t=
he =

> caller has to keep open as long as they want to hold the lock.

On the android platform this is not a concern since only the system
server manages wakelocks directly and processes use a higher level
wakelock api in userspace that is remoted and handles this situation
(the system server knows when a process dies and can clean up).

For more general usage, the fd model does sound nicer, allowing
cleanup-on-exit, etc.  Arve -- is there a reason we went with sysfs?

Brian
