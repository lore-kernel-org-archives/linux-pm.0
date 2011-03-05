From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.38-rc6+: oops while hibernating, pcmcia?
Date: Sat, 5 Mar 2011 12:26:57 +0100
Message-ID: <201103051226.58032.rjw__13154.2754978456$1299324546$gmane$org@sisk.pl>
References: <20110305054426.GA2096@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110305054426.GA2096@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, March 05, 2011, Pavel Machek wrote:
> Hi!
> 
> Unfortunately it did not made it do disk. Thinkpad x60. PCMCIA was in
> the backtrace, and yes, I had CF card in the PCMCIA slot. Certainly
> not 100% repeatable, as it was 3rc hibernate or so...

I'd say it's a PCMCIA bug.  Is it reproducible without PCMCIA being in use?

Rafael
