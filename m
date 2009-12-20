From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 22:59:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912192253200.6618-100000__22662.270817864$1261281666$gmane$org@netrider.rowland.org>
References: <200912200040.18944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912200040.18944.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:

> So, seriously, do you think it makes sense to do asynchronous suspend at all?
> I'm asking, because we're likely to get into troubles like this during suspend
> for other kinds of devices too and without resolving them we won't get any
> significant speedup from asynchronous suspend.
> 
> That said, to me it's definitely worth doing asynchronous resume with the
> "start asynch threads upfront" modification, as the results of the tests show
> that quite clearly.  I hope you agree.

It's too early to come to this sort of conclusion (i.e., that suspend
and resume react very differently to an asynchronous approach).  Unless
you have some definite _reason_ for thinking that resume will benefit
more than suspend, you shouldn't try to generalize so much from tests
on only two systems.

Alan Stern
