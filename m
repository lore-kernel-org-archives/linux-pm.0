From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: LPC2011 Power Management Micro Conf
Date: Fri, 12 Aug 2011 09:01:37 +0200
Message-ID: <201108120901.37632.rjw__30853.4218966544$1313132472$gmane$org@sisk.pl>
References: <201105011353.44809.rjw@sisk.pl> <201107030929.28555.rjw@sisk.pl>
	<20110812033221.GA5671@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110812033221.GA5671@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>, Stephen Boyd <sboyd@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Jean Pihet <j-pihet@ti.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, August 12, 2011, Mark Brown wrote:
> On Sun, Jul 03, 2011 at 09:29:28AM +0200, Rafael J. Wysocki wrote:
> 
> > If there's anything you'd like to discuss or give a presentation on related to
> > Power Management, please let me know, preferably by replying to this message.
> 
> The issue of cross-bus sequencing within suspend has come up again - we
> really need to work out how we make sure that dependencies between
> devices that aren't accounted for in the control bus sorting we do as
> standard.  This may be worth bringing up a KS also as it's device model
> related.

I agree, I'll add it to the agenda of the LPC microconf.

Thanks,
Rafael
