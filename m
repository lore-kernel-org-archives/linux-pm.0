From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 6 Jul 2006 16:51:57 -0700
Message-ID: <200607061651.57803.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<20060706232710.GG30500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060706232710.GG30500@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 July 2006 4:27 pm, Dave Jones wrote:
> On Thu, Jul 06, 2006 at 03:27:28PM -0700, David Brownell wrote:
>  > The only other new behaviors of note are that the console changes now
>  > prevent diagnostics during suspend (sigh)
> =

> That's the biggest step backwards we've made in power management
> in the last few years IMO.  What was the reasoning behind this change?

Linus gave more details somewhere earlier in this thread, before
it veered seriously off-topic.

Short version:  console shutdown was being done incorrectly, and
in a way that prevented STR from working on Linus' x86-Apple.
He was using netconsole.

Likely a better fix is available (e.g. suspending console device
and its ancestors at the latest possible point), but nobody has
yet made the time to produce one.

- Dave
