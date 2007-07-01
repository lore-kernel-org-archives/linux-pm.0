From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [-mm patch] kernel/power/main.c: make code static
Date: Mon, 2 Jul 2007 01:12:03 +0200
Message-ID: <200707020112.04013.rjw__7000.10803198001$1183331157$gmane$org@sisk.pl>
References: <20070628034321.38c9f12b.akpm@linux-foundation.org>
	<20070701202336.GV10869@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070701202336.GV10869@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 1 July 2007 22:23, Adrian Bunk wrote:
> On Thu, Jun 28, 2007 at 03:43:21AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.22-rc4-mm2:
> >...
> > +pm-reduce-code-duplication-between-mainc-and-userc.patch
> >...
> >  PM updates
> >...
> 
> 
> Some code can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

This clashes and partially overlaps with some patches that I have in the works.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
