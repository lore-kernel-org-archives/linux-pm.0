From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Tue, 16 Nov 2010 06:32:36 +0100
Message-ID: <20101116053236.GA30605__39564.8934682415$1289885631$gmane$org@elf.ucw.cz>
References: <20101114052138.GB2189@elf.ucw.cz> <201011152326.44357.rjw@sisk.pl>
	<20101116052634.GA30449@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101116052634.GA30449@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2010-11-16 06:26:34, Pavel Machek wrote:
> Hi!
> 
> > > ...but there's enough -- or at least it was enough to fit previous
> > > versions. 32-bit machine, so it has highmem.
> > > 
> > > System is in console mode, very lightly loaded.
> > > 
> > > Mem:   2054716k total,   736548k used,  1318168k free,    15368k buffers
> > > Swap:   779148k total,     2360k used,   776788k free,   546388k cached
> > 
> > Well, the swap is rather in short supply.  Below the 50% of RAM recommendation.
> 
> Well, but the biggest image we can write is not 50% of RAM, but 50% of
> lowmem... and swap is nearly as big as lowmem in this case -- so this
> machine is not misconfigured.

BTW swsusp.txt may need updating, it says:

echo N > /sys/power/image_size

before suspend (it is limited to 500 MB by default).

...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
