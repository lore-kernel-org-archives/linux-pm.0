From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 15:23:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912191521180.3712__3245.82066755301$1261265054$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912192233.44575.rjw@sisk.pl>
	<A37A0A6F-3662-40C9-BE1F-B9F6A38CD80B@gmail.com>
	<200912200010.19899.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912200010.19899.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> 
> Well, I guess this is the example of the off-tree dependencies that actually
> matter Linus wanted. :-)

It's also the kind of dependency where I say "if we get into these kinds 
of messes, then the whole async crap isn't worth it".

Really. Having to try to match things up with ACPI and PnP is a nightmare. 
Especially since I doubt Windows does anything like this, which means that 
there's no reason for BIOS vendors to do the tables so that we'd even 
know.

			Linus
