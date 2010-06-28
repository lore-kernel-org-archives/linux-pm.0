From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
	from being lost
Date: Mon, 28 Jun 2010 16:28:29 -0700 (PDT)
Message-ID: <53596.65110.qm__7805.49947307936$1277767761$gmane$org@web180310.mail.gq1.yahoo.com>
References: <201006280159.10885.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006280159.10885.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mark gross <640e9920@gmail.com>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Did someone post the canonical driver changes
to make use of this?  Something like

  suspend() { /* if wake-enabled, up count */ }
  resume() { /* if upcounted, downcount */ }

is what first comes to mind.. expecting that
the suspend/resume methods in the driver are
already doing the right things for enabling
and later disabling the "system wake" behavior
on the various relevant hardware events...
