From: Dave Jones <davej@redhat.com>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 18:06:12 -0400
Message-ID: <20060706220612.GC30500@redhat.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060706210101.GU13168@redhat.com>
	<200607061407.56004.david-b@pacbell.net>
	<200607062318.55787.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607062318.55787.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 06, 2006 at 11:18:55PM +0200, Rafael J. Wysocki wrote:
 > On Thursday 06 July 2006 23:07, David Brownell wrote:
 > > On Thursday 06 July 2006 2:01 pm, Dave Jones wrote:
 > > =

 > > > Why not just use __memcpy instead? Which should be safe on all archs
 > > > to do the simplest possible memcpy.
 > > =

 > > Or __constant_memcpy(...PAGE_SIZE) ?  :)
 > =

 > Is __memcpy() defined on all architectures?  Eg. ppc?

Seems not.  __constant_memcpy is a gcc built-in though isn't it ?

		Dave

-- =

http://www.codemonkey.org.uk
