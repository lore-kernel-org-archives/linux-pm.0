From: Oliver Neukum <oneukum@suse.de>
Subject: Re: better oopsing when frozen
Date: Wed, 27 Jul 2011 12:23:43 +0200
Message-ID: <201107271223.43874.oneukum__42625.750861089$1311762226$gmane$org@suse.de>
References: <201107251043.19932.oneukum@suse.de>
	<20110726154502.14c7b51b.akpm@linux-foundation.org>
	<201107271121.21348.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107271121.21348.rjw@sisk.pl>
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

Am Mittwoch, 27. Juli 2011, 11:21:21 schrieb Rafael J. Wysocki:
> > mm...  The patch as proposed is very simple, direct, explicit.  I
> > suspect that trying to embed this operation within some other one would
> > end up producing a less clear result.  Sometimes we do exceptional and
> > weird things, and leaving the code exceptional and weird-looking is
> > better than hiding it in some framework, if you follow what I mean.
> =

> My point is that instead of using the oom_killer_disabled variable in
> page_alloc.c, we could use a oom_killer_disabled() function returning
> the value of the new tasks_are_frozen variable.  Then,
> oom_killer_disable/enable() won't be necessary any more.

Well, if we do this, it'll be a separate change. Not that I disagree. =


	Regards
		Oliver
-- =

- - - =

SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffe=
r, HRB 16746 (AG N=FCrnberg) =

Maxfeldstra=DFe 5                         =

90409 N=FCrnberg =

Germany =

- - - =
