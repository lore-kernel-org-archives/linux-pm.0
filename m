From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Wed, 2 Jan 2008 21:17:07 +0100
Message-ID: <20080102201707.GD3985__7456.39787423915$1199305162$gmane$org@elte.hu>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
	<200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu>
	<20080102172625.CE0C2F6DFE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080102172625.CE0C2F6DFE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: a.zummo@towertech.it, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org


* David Brownell <david-b@pacbell.net> wrote:

> > shouldnt we provide a Kconfig way of replacing dev 10:135 with the 
> > new driver's 254:0 device? (while keeping all the current modes of 
> > operation as well, of course.)
> 
> The major number 254 is not statically allocated, ISTR; that should be 
> managed only by udev.

sorry, i meant a .config option that would cause 10:135 to be managed by 
the new RTC code too. (Config option can be default-off.)

	Ingo
