From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re: Remove page flags for software suspend)
Date: Thu, 8 Mar 2007 23:10:14 +0100
Message-ID: <200703082310.15297.rjw@sisk.pl>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703041450.02178.rjw@sisk.pl>
	<1173366543.3248.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1173366543.3248.1.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, pm list <linux-pm@lists.osdl.org>, Christoph Lameter <clameter@engr.sgi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 8 March 2007 16:09, Johannes Berg wrote:
> =

> > Okay, the next three messages contain patches that should do the trick.
> > =

> > They have been tested on x86_64, but not very thoroughly.
> =

> Works on my powerbook as well. Never mind that usb is broken again with
> suspend to disk. And my own patches break both str and std right now.

Ouch.

> But these (on top of wireless-dev which is currently about 2.6.21-rc2)
> work fine as long as I assume they don't break usb ;)

Well, on my boxes they don't. ;-)

Rafael
