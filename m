From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 12:57:16 +0200
Message-ID: <200608091257.16663.rjw@sisk.pl>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl>
	<20060809103120.GI3308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060809103120.GI3308@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 09 August 2006 12:31, Pavel Machek wrote:
> > Introduce the memory bitmap data structure and make swsusp use in the s=
uspend
> > phase.
> > =

> > The current swsusp's internal data structure is not very efficient from=
 the
> > memory usage point of view, so it seems reasonable to replace it with a=
 data
> > structure that will require less memory, such as a pair of bitmaps.
> =

> Well, 500 lines of code  for what... 0.25% bigger image? I see it
> enables you to do some cleanups... but could we get those cleanups
> without those 500 lines? :-).

Out of the 500 lines, something like 100 are comments and other 50 are
definitions of structures. ;-)

Seriously speaking, I could do that without the bitmaps, but the code would=
n't
be that much shorter.  Apart from this, I would need to introduce yet anoth=
er
type of PBEs (for storing pfns) and try not to get lost in the resulting me=
ss.

Instead of doing this I prefer to add some extra code to set up a decent da=
ta
structure and just use it.

Rafael
