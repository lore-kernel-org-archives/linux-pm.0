From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 12:01:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006211158200.1687-100000__24131.7472573884$1277136196$gmane$org@iolanthe.rowland.org>
References: <20100621061345.GF9735@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621061345.GF9735@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Jun 2010, mark gross wrote:

> Your confused about what problem this patch attempts to solve.

I don't think so.  Rafael's description was pretty clear.

>  There is
> a pm_qos patch in the works to address the suspend blocker
> functionality.
> http://lists.linux-foundation.org/pipermail/linux-pm/2010-June/026760.html

No.  That patch addresses something _similar_ to the suspend blocker
functionality.  The fact remains, though, that pm_qos is not used
during system suspend (the /sys/power/state interface), hence changes
to pm_qos won't solve the system-suspend problems that suspend blockers 
do solve.

Alan Stern
