From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 11:03:12 +0100
Message-ID: <20100603110312.48a508dc__7638.7066430927$1275559108$gmane$org@lxorguk.ukuu.org.uk>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
	<AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t@mail.gmail.com>
	<1275451342.21962.1777.camel@mulgrave.site>
	<AANLkTilRcFZyYa-0HlaM-6IEZSyar3S9S_cCWSFax2Zo@mail.gmail.com>
	<1275491111.2799.110.camel@mulgrave.site>
	<20100602214748.7742e3ae@schatten.dmk.lab>
	<1275511271.2799.516.camel@mulgrave.site>
	<20100603010607.5baf82a6@schatten.dmk.lab>
	<CA1BBBBC9359F04AA639128AC0D5D1E9692ABC92@orsmsx502.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CA1BBBBC9359F04AA639128AC0D5D1E9692ABC92@orsmsx502.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Gross, Mark" <mark.gross@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "tytso@mit.edu" <tytso@mit.edu>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

> [mtg: ] This has been a pain point for the PM_QOS implementation.  They change the constrain back and forth at the transaction level of the i2c driver.  The pm_qos code really wasn't made to deal with such hot path use, as each such change triggers a re-computation of what the aggregate qos request is.

That should be trivial in the usual case because 99% of the time you can
hot path

	the QoS entry changing is the latest one
	there have been no other changes
	If it is valid I can use the cached previous aggregate I cunningly
		saved in the top QoS entry when I computed the new one

(ie most of the time from the kernel side you have a QoS stack)

> We've had a number of attempts at fixing this, but I think the proper fix is to bolt a "disable C-states > x" interface into cpu_idle that bypases pm_qos altogether.  Or, perhaps add a new pm_qos API that does the equivalent operation, overriding whatever constraint is active.

We need some of this anyway for deep power saving because there is
hardware which can't wake from soem states, which in turn means if that
device is active we need to be above the state in question.
