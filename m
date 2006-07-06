From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 19:59:52 -0400
Message-ID: <20060706235952.GK30500@redhat.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<20060706232710.GG30500@redhat.com>
	<Pine.LNX.4.64.0607061642290.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607061642290.3869@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 06, 2006 at 04:43:13PM -0700, Linus Torvalds wrote:
 > =

 > =

 > On Thu, 6 Jul 2006, Dave Jones wrote:
 > >
 > > On Thu, Jul 06, 2006 at 03:27:28PM -0700, David Brownell wrote:
 > >  > The only other new behaviors of note are that the console changes n=
ow
 > >  > prevent diagnostics during suspend (sigh)
 > > =

 > > That's the biggest step backwards we've made in power management
 > > in the last few years IMO.  What was the reasoning behind this change?
 > =

 > Now suspend actually _works_ for me with netconsole. Before, it very =

 > fundamentally wouldn't, it would panic left and right.

No, that's something else.  I used to get text on the console, then
it went away[1]. some time later, you came along and did the fixes you
refer to.

		Dave

[1] I think it was commit 94c188d32996beac00426740974310e32f162c14
which implies userspace can make it come back. That's great, but
what if userspace has crashed?

-- =

http://www.codemonkey.org.uk
