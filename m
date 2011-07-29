From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: better oopsing when frozen
Date: Fri, 29 Jul 2011 23:09:44 +0200
Message-ID: <201107292309.44877.rjw__17340.3361499824$1311973860$gmane$org@sisk.pl>
References: <201107251043.19932.oneukum@suse.de>
	<201107292227.54948.rjw@sisk.pl>
	<201107292304.10738.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107292304.10738.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 29, 2011, Oliver Neukum wrote:
> Am Freitag, 29. Juli 2011, 22:27:54 schrieb Rafael J. Wysocki:
> > However, there's another problem I didn't think of before.  Namely,
> > we cannot thaw tasks before resuming devices in case we've already
> > suspended them, because that will defeat the very purpose of the
> > freezing in the first place.
> 
> That purpose is already defeated. The machine cannot be deader than dead.

OK, so what exactly is the purpose of the thawing, then?

Rafael
