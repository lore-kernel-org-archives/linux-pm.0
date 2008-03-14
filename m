From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] PM: Remove legacy PM
Date: Fri, 14 Mar 2008 08:33:07 +0100
Message-ID: <20080314073307.GB9465__15871.4302270257$1205480146$gmane$org@elf.ucw.cz>
References: <200803132351.19794.rjw@sisk.pl> <47DA0DDB.7010403@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47DA0DDB.7010403@davidnewall.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Newall <davidn@davidnewall.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-03-14 16:02:11, David Newall wrote:
> Rafael J. Wysocki wrote:
> > The first of the following two patches removes the legacy PM infrastructure
> > and the second one removes some of its remnants from the MIPS tree.
> 
> What does "legacy PM" mean?  Is it APM, which most assuredly needs to
> remain?

No, it is not APM. It issome obsolete code noone uses.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
