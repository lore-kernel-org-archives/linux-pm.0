From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH -mm 5/5] b43: Avoid unregistering device
	objects during suspend
Date: Fri, 25 Jan 2008 11:13:30 +0100
Message-ID: <200801251113.31325.mb__6065.33016912198$1201256261$gmane$org@bu3sch.de>
References: <200801250127.21966.rjw@sisk.pl> <200801250137.34275.rjw@sisk.pl>
	<20080125074746.GC4134@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080125074746.GC4134@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, bcm43xx-dev@lists.berlios.de, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 25 January 2008 08:47:46 Pavel Machek wrote:
> On Fri 2008-01-25 01:37:33, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Modify the b43 driver to avoid deadlocking suspend and resume,
> > which happens as a result of attempting to unregister device objects
> > locked by the PM core during suspend/resume cycles.  Also, make it
> > use a suspend-safe method of unregistering device object in the
> > resume error path.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Michael Buesch <mb@bu3sch.de>
> 
> Maybe we should have global suspend_in_progress (or maybe system_state
> == suspending?) and automatically switch to schedule_removal() while
> it is set?
> 

That would be great, from my perspective :)

-- 
Greetings Michael.
