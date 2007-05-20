From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.22-rc2 built on ppc (1)
Date: Sun, 20 May 2007 13:36:04 +0200
Message-ID: <200705201336.05205.rjw@sisk.pl>
References: <20070520110625.GC3253@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070520110625.GC3253@aragorn.home.lxtec.de>
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
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 20 May 2007 13:06, Elimar Riesebieter wrote:
> Hi,
> 
> FYI, building 2.6.22-rc2 with
> gcc (GCC) 4.1.3 20070514 (prerelease) (Debian 4.1.2-7)
> on my powerbook (PPC) gives:
> 
> ...
> kernel/power/swsusp.c: In function 'swsusp_show_speed':
> kernel/power/swsusp.c:193: warning: comparison of distinct pointer types lacks a cast

Well, this warning doesn't make sense.  In 2.6.22-rc2 line 193 of swsusp.c is

do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);

where elapsed_centisecs64 is s64.

Greetings,
Rafael
