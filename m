From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Thu, 29 Jan 2009 14:04:24 +0100
Message-ID: <20090129130424.GA1425@ucw.cz>
References: <d6200be20901142042n5aa6384al936e49f5bce8256e@mail.gmail.com>
	<Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0901151005240.2490-100000@iolanthe.rowland.org>
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
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-01-15 10:08:51, Alan Stern wrote:
> 6~On Wed, 14 Jan 2009, Arve Hj?nnev?g wrote:
> 
> > On Wed, Jan 14, 2009 at 1:01 AM, Nigel Cunningham
> > <ncunningham@crca.org.au> wrote:
> > > Would you be able to provide some more documentation?
> > 
> > Would something like this help:
> > Documentation/power/wakelocks.txt
> > 
> > Wakelocks
> > =========
> > 
> > A wake_lock prevents the system from entering suspend or other low power
> > states when active. If the type is set to WAKE_LOCK_SUSPEND, the wake_lock
> > prevents a full system suspend. If the type is WAKE_LOCK_IDLE, low power
> > states that cause large interrupt latencies or that disable a set of
> > interrupts will not entered from idle until the wake_locks are released.
> 
> Apart from the grammatical errors in this document and the
> over-engineering it describes, the writeup is terribly ambiguous.  
> What do you mean by "prevents a full system suspend"?  Does it mean
> that attempts to suspend the system will fail?  Or will they just
> block until all these locks are released?
 
AFAICT, this is something very different. It is attempt to do
autosuspend right. Imagine burning cd... right now you can suspend,
and it will just stop the burn.

Wakelocks code allows you to tell the machine 'feel free to suspend
when you have nothing to do'... so the machine will burn the cd and
then suspend.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
