From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Mon, 09 Jul 2007 11:36:13 -0400
Message-ID: <87tzsdvbbm.fsf__25838.2553853609$1183995429$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707091043480.3851-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707091043480.3851-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon\, 9 Jul 2007 10\:45\:56 -0400 \(EDT\)")
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 9 Jul 2007, Jeremy Maitin-Shepard wrote:
>> Pavel Machek <pavel@ucw.cz> writes:
>> 
>> [snip]
>> 
>> > I don't know how to do that mechanism... but if we knew where to trap
>> > filesystem writes, we could simply freeze at that point, and at that
>> > point only, no?
>> 
>> Any operation at all that has an external effect must not occur after
>> the snapshot is made; otherwise, there will be random hard-to-find
>> corruptions and other problems occurring as a result.  Thus, for
>> example, any writes (either directly or indirectly through e.g. a
>> filesystem) to non-volatile storage, any network traffic, any
>> communication with hardware like a printer must be prevented after the
>> snapshot.

> You have forgotten one critical point: The writes to save the snapshot 
> image must be allowed.  That's what makes it really hard.

Well, I didn't forget about that, although my language may have been a
bit ambiguous.  I was referring only to the operations that are done by
normal (i.e. non-hibernate) portions of the system and which are not
explicitly for the purpose of hibernating the system.  It is very
difficult to maintain this guarantee while also attempting to reuse the
same infrastructure that is supposed to not be processing any "normal"
requests in order to write the snapshot.  The kdump approach handily
avoids this problem by *not* reusing the same infrastructure while still
allowing complete flexibility (i.e. not depending on a
drivers/suspend/ide-simple).

-- 
Jeremy Maitin-Shepard
