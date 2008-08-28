From: Pavel Machek <pavel@suse.cz>
Subject: Re: autosuspend for SCSI devices
Date: Thu, 28 Aug 2008 10:04:27 +0200
Message-ID: <20080828080427.GD15474__28763.8670336039$1219955585$gmane$org@elf.ucw.cz>
References: <20080822105626.GA9475@elf.ucw.cz>
	<200808251055.45582.oneukum@suse.de>
	<20080826094355.GA30062@elf.ucw.cz>
	<200808261301.45167.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808261301.45167.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, teheo@novell.com, stefanr@s5r6.in-berlin.de, Martin.Leisner@xerox.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2008-08-26 13:01:43, Oliver Neukum wrote:
> Am Dienstag 26 August 2008 11:43:55 schrieb Pavel Machek:
> > > firstly, it doesn't consider error handling before suspending.
> > 
> > What problems do you see with error handling? This patch does not
> > touch the error handling, and I do not think it needs to touch it.
> 
> You'd make scsi driver writers' life easier if you made sure no autosuspends
> happen while they recover from errors. After all, you have no idea which
> commands will get through while the bus is in disarray.

Well, they have to handle other commands while bus has problems,
anyway, right? So I'm not creating any _new_ problems for them. 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
