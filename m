From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION 2.6.34] Suspend fails in
	pm_test=processor on Dell laptop
Date: Tue, 20 Apr 2010 05:33:13 +0200
Message-ID: <201004200533.13219.rjw__15739.3179405064$1271734422$gmane$org@sisk.pl>
References: <4bcb1cf2.116bdc0a.2008.6f5a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4bcb1cf2.116bdc0a.2008.6f5a@mx.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 18 April 2010, Ben Gamari wrote:
> Hey all,
> 
> It seems that something in the 2.6.34 merge cycle has broken suspend to RAM on
> my Dell Latitude D830. While suspend has been rock solid for several release
> cycles, as of 2.6.34-rc4 it locks up on suspend. All of the pm_test options up
> to processor work fine, precluding a driver issue.

Hmm, does the "processors" work?

> Unfortunately, I've been unable to get any useful output from the serial
> console during suspend. I'll try bisecting and report back when I have more
> details. Let me know what else I can do to help.

I can't reproduce this, so it looks hardware or BIOS-related.  Or it's an
obscure x86 bug.

Rafael
