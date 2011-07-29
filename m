From: Oliver Neukum <oliver@neukum.org>
Subject: Re: better oopsing when frozen
Date: Fri, 29 Jul 2011 23:17:42 +0200
Message-ID: <201107292317.42737.oliver__27227.468256797$1311974233$gmane$org@neukum.org>
References: <201107251043.19932.oneukum@suse.de>
	<201107292304.10738.oliver@neukum.org>
	<201107292309.44877.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107292309.44877.rjw@sisk.pl>
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

Am Freitag, 29. Juli 2011, 23:09:44 schrieb Rafael J. Wysocki:
> On Friday, July 29, 2011, Oliver Neukum wrote:
> > Am Freitag, 29. Juli 2011, 22:27:54 schrieb Rafael J. Wysocki:
> > > However, there's another problem I didn't think of before.  Namely,
> > > we cannot thaw tasks before resuming devices in case we've already
> > > suspended them, because that will defeat the very purpose of the
> > > freezing in the first place.
> > 
> > That purpose is already defeated. The machine cannot be deader than dead.
> 
> OK, so what exactly is the purpose of the thawing, then?

We may be lucky enough to get the oops written out to disk. The oops may happen
in a driver rarely used and be late in the sequence.

	Regards
		Oliver
