From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc7: oops on hibernate
Date: Sat, 5 Mar 2011 21:39:14 +0100
Message-ID: <201103052139.15012.rjw@sisk.pl>
References: <20110305194027.GA6582@laptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110305194027.GA6582@laptop.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Nezhevenko <dion@inhex.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, March 05, 2011, Dmitry Nezhevenko wrote:
> Hi,

Hi,

> I've just hit oops on hibernate. Unfortunately there is no
> info in syslog, however I've created a photo with call stack:
> http://dion.org.ua/tmp/20110305_210225.jpg
> 
> It looks like I can't reproduce it anymore. Both hibernate and s2ram works
> on this machine (Asus F6A laptop).

Unfortunately, if it's not reproducible it's almost impossible to find
the root cause.  The symptom is that we try to access a bit in one of the
hibernate code's memory bitmaps, but it turns out that the address it is
supposed to correspond to is not present in those bitmaps.

The code probably may be reworked to avoid triggering a bug on in such
cases, but that's about the only idea I have at the moment.

Thanks,
Rafael
