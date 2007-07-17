From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 15:37:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707171535350.2467@asgard.lang.hm>
References: <Pine.LNX.4.44L0.0707171835560.8690-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707171835560.8690-100000@iolanthe.rowland.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007, Alan Stern wrote:

> On Tue, 17 Jul 2007 david@lang.hm wrote:
>
>>> But what about the freezer?  The original reason for using kexec was to
>>> avoid the need for the freezer.  With no freezer, while the original
>>> kernel is busy powering down its devices, user tasks will be free to
>>> carry out I/O -- which will make the memory snapshot inconsistent with
>>> the on-disk data structures.
>>
>> no, user tasks just don't get scheduled during shutdown.
>
> But a user task may be holding a lock which is needed for putting some
> device into low-power mode.  It can't release that lock if it doesn't
> get scheduled.

then you can't suspend that box. if you schedule it, it could get another 
lock (or another process gets another lock)

if you can't power down or put hardware into low-power mode without the 
approval of userspace, you are in serious trouble.

David Lang
