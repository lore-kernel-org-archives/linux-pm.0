From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm 5/5] b43: Avoid unregistering device
 objects during suspend
Date: Fri, 25 Jan 2008 09:58:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801250955210.4190-100000__33341.0082771026$1201273224$gmane$org@iolanthe.rowland.org>
References: <20080125074746.GC4134@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080125074746.GC4134@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, bcm43xx-dev@lists.berlios.de, Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jan 2008, Pavel Machek wrote:

> Maybe we should have global suspend_in_progress (or maybe system_state
> == suspending?) and automatically switch to schedule_removal() while
> it is set?

:-)  There was a time a couple of years ago when you objected violently 
to the mere suggestion of such a global variable!

It's not a bad idea IMO.  But if it does get implemented, a global
function would be better than a global variable.  It would provide
more encapsulation.

Alan Stern
