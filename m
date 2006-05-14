From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
Date: Sun, 14 May 2006 08:51:26 -0700
Message-ID: <200605140851.29221.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz>
	<200605120652.55658.david-b@pacbell.net>
	<1147565632.21291.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============044269506956564397=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1147565632.21291.15.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============044269506956564397==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 13 May 2006 5:13 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2006-05-12 at 06:52 -0700, David Brownell wrote:
> > On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> > > 
> > > What will be impacted by this?
> > 
> > Driver suspend/resume testing ... impact is strongly negative.
> > ...
> > Which IMO makes removing this a Bad Thing.  It needs to have some
> > kind of replacement in place before the "magic numbers" go away.
> 
> And that's why Pavel is not proposing to remove it right away... but to
> schedule it's removal so that developpers know right now that building a
> whole new kernel<->user interface based on that is not the smartest
> thing to do.

How could we schedule the removal before we have even had a couple
releases to fine-tune its replacement, and verify that the main issues
with the current thing are fully resolved?

... plus, removing the whole power/* directory is clearly wrong.  The
issue that's been acknowledged is only with the contents of a single
file, power/state, not the whole directory.

There may be a bit of a gap in the process here.  "July 2007" is a
date that's not backed up by anything more than agreement that the
current approach is a lose.  Deprecation is not the same as removal.



--===============044269506956564397==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============044269506956564397==--
