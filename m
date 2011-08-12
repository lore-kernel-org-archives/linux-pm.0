From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: LPC2011 Power Management Micro Conf
Date: Fri, 12 Aug 2011 04:32:21 +0100
Message-ID: <20110812033221.GA5671__25416.7340267033$1313120021$gmane$org@sirena.org.uk>
References: <201105011353.44809.rjw@sisk.pl> <201107030929.28555.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107030929.28555.rjw@sisk.pl>
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
Cc: tytso@mit.edu, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>, Stephen Boyd <sboyd@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, Jean Pihet <j-pihet@ti.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 03, 2011 at 09:29:28AM +0200, Rafael J. Wysocki wrote:

> If there's anything you'd like to discuss or give a presentation on related to
> Power Management, please let me know, preferably by replying to this message.

The issue of cross-bus sequencing within suspend has come up again - we
really need to work out how we make sure that dependencies between
devices that aren't accounted for in the control bus sorting we do as
standard.  This may be worth bringing up a KS also as it's device model
related.
