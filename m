From: Oliver Neukum <oneukum@suse.de>
Subject: Re: autosuspend for SCSI devices
Date: Tue, 26 Aug 2008 13:01:43 +0200
Message-ID: <200808261301.45167.oneukum__25558.2229853191$1219748587$gmane$org@suse.de>
References: <20080822105626.GA9475@elf.ucw.cz>
	<200808251055.45582.oneukum@suse.de>
	<20080826094355.GA30062@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080826094355.GA30062@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: James.Bottomley@hansenpartnership.com, linux-kernel@vger.kernel.org, teheo@novell.com, stefanr@s5r6.in-berlin.de, Martin.Leisner@xerox.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag 26 August 2008 11:43:55 schrieb Pavel Machek:
> > firstly, it doesn't consider error handling before suspending.
> 
> What problems do you see with error handling? This patch does not
> touch the error handling, and I do not think it needs to touch it.

You'd make scsi driver writers' life easier if you made sure no autosuspends
happen while they recover from errors. After all, you have no idea which
commands will get through while the bus is in disarray.

	Regards
		Oliver
