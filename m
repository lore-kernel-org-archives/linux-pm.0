From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 15:17:27 -0400
Message-ID: <20060614191727.GC23238@redhat.com>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614180959.GD13105@redhat.com>
	<Pine.LNX.4.64.0606141121040.5498@g5.osdl.org>
	<1150312438.21941.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1150312438.21941.10.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Peter Jones <pjones@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 14, 2006 at 03:13:58PM -0400, Peter Jones wrote:
 > On Wed, 2006-06-14 at 11:29 -0700, Linus Torvalds wrote:
 > > =

 > > On Wed, 14 Jun 2006, Dave Jones wrote:
 > > > =

 > > > I bet you're not using slab debug are you? :)
 > > =

 > > Actually, I am:
 > > =

 > > 	..
 > > 	CONFIG_DEBUG_SLAB=3Dy  =

 > > 	CONFIG_DEBUG_SLAB_LEAK=3Dy =

 > > 	CONFIG_DEBUG_MUTEXES=3Dy
 > > 	CONFIG_DEBUG_SPINLOCK=3Dy
 > > 	CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
 > > 	..
 > > =

 > > > Peter is hitting this with his mini on resume...
 > > =

 > > I'm not sure why I'm not, but we probably have different configuration=
s in =

 > > other respects.
 > =

 > Yes, we do -- this traceback was from the MacBook Pro, and on the
 > suspend-to-disk case, not suspend-to-ram.

Ah my bad. That's what I get for middle-man'ing bug reports :)

		Dave
-- =

http://www.codemonkey.org.uk
