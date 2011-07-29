From: Oliver Neukum <oliver@neukum.org>
Subject: Re: better oopsing when frozen
Date: Fri, 29 Jul 2011 23:04:10 +0200
Message-ID: <201107292304.10738.oliver__37078.0803183608$1311973416$gmane$org@neukum.org>
References: <201107251043.19932.oneukum@suse.de>
	<20110729195430.GB1720@ucw.cz> <201107292227.54948.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107292227.54948.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 29. Juli 2011, 22:27:54 schrieb Rafael J. Wysocki:
> However, there's another problem I didn't think of before.  Namely,
> we cannot thaw tasks before resuming devices in case we've already
> suspended them, because that will defeat the very purpose of the
> freezing in the first place.

That purpose is already defeated. The machine cannot be deader than dead.
We could try to go through the device tree. But the machine just oopsed
quite likely doing just that, so this doesn't seem wise to me.

IMHO if we oops while frozen, chances are the system is going to die.
It certainly dies now. However, we must certainly not thaw if a valid
image is already on disk, lest we corrupt a filesystem.

	Regards
		Oliver
