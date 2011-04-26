From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Tue, 26 Apr 2011 21:45:11 +0200
Message-ID: <20110426194511.GA27140@elf.ucw.cz>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426132224.GC13597@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110426132224.GC13597@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2011-04-26 06:22:24, Greg KH wrote:
> On Tue, Apr 26, 2011 at 05:43:21PM +0900, MyungJoo Ham wrote:
> > With OPPs, a device may have multiple operable frequency and voltage
> > sets. However, there can be multiple possible operable sets and a system
> > will need to choose one from them. In order to reduce the power
> > consumption (by reducing frequency and voltage) without affecting the
> > performance too much, a DVFS scheme may be used.
> 
> What is "DVFS"?  A new filesystem?

Dynamic voltage & frequency scaling ... very probably. But yes, the
naming sucks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
