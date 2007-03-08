From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re: Remove page flags for software suspend)
Date: Fri, 9 Mar 2007 00:34:57 +0100
Message-ID: <200703090034.57978.rjw@sisk.pl>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<20070308231512.GB1977@elf.ucw.cz>
	<1173396094.3831.42.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1173396094.3831.42.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 9 March 2007 00:21, Johannes Berg wrote:
> On Fri, 2007-03-09 at 00:15 +0100, Pavel Machek wrote:
> =

> > That's a no-no. ATOMIC alocations can fail, and no, WARN_ON is not
> > enough. It is not a bug, they just fail.
> =

> But like I said in my post, there's no way we can disable suspend to
> disk when they do, right now anyway. Also, this can't be called any
> later than a late initcall or such since it's __init, and thus there
> shouldn't be memory pressure yet that would cause this to fail.

Exactly.  If an atomic allocation fails at this stage, there is a bug IMHO
(although not necessarily in our code).

Still, the patch is not sufficient, so that's just a theoretical thing.

> In any case, I'd be much happier with having a "disable suspend"
> variable so we could print a big warning and set that flag.

Well, I think that if we can't get so little memory at this early stage, the
kernel will have much more trouble anyway. ;-)

Rafael
