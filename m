From: bgamari.foss@gmail.com
Subject: (no subject)
Date: Tue, 20 Apr 2010 19:00:56 -0700
Message-ID: <201004210200.o3L20uTU016700@smtp1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

>From nobody Tue Apr 20 22:00:38 2010
From: Ben Gamari <bgamari.foss@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
Subject: Re: [REGRESSION 2.6.34] Suspend fails in pm_test=processor on Dell
	laptop
In-Reply-To: <201004200533.13219.rjw@sisk.pl>
References: <4bcb1cf2.116bdc0a.2008.6f5a@mx.google.com>
	<201004200533.13219.rjw@sisk.pl>
Date: Tue, 20 Apr 2010 15:11:52 -0400
Message-ID: <87633mey6f.fsf@ben-laptop.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Apr 2010 05:33:13 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> On Sunday 18 April 2010, Ben Gamari wrote:
[snip]
> > It seems that something in the 2.6.34 merge cycle has broken suspend to RAM on
> > my Dell Latitude D830. While suspend has been rock solid for several release
> > cycles, as of 2.6.34-rc4 it locks up on suspend. All of the pm_test options up
> > to processor work fine, precluding a driver issue.
> 
> Hmm, does the "processors" work?

Nope. Processors is the first failing phase.

I'm still working on getting a bisection, but it'll be a few more days
due to various school-related delays.

- Ben
