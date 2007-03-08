From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 0/3] swsusp: Do not use page flags (was:
	Re:	Remove page flags for software suspend)
Date: Thu, 08 Mar 2007 16:53:45 +0100
Message-ID: <1173369225.9438.32.camel@twins>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<45E6EEC5.4060902@yahoo.com.au> <200703011633.54625.rjw@sisk.pl>
	<200703041450.02178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703041450.02178.rjw@sisk.pl>
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
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Pavel Machek <pavel@ucw.cz>, linux-mm@kvack.org, Christoph Lameter <clameter@engr.sgi.com>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-03-04 at 14:50 +0100, Rafael J. Wysocki wrote:

> Okay, the next three messages contain patches that should do the trick.
> =

> They have been tested on x86_64, but not very thoroughly.

They look good to me, but what do I know about swsusp :-) =

I'll stick them in my laptop's kernel (boring i386-UP) and see what
happens.

I did notice you don't stick KERN_ prio markers in your printk()s not
sure what to think of that (or if its common practise and I'm just not
aware of it).

Thanks for doing this.

Peter
