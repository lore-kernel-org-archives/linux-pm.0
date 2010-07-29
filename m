From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [stable] Stable inclusion request - NVS changes from
	Matthew
Date: Fri, 30 Jul 2010 00:34:55 +0200
Message-ID: <201007300034.55730.rjw__26417.2702133239$1280443151$gmane$org@sisk.pl>
References: <201006291128.44099.rjw@sisk.pl> <20100729220431.GI17470@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100729220431.GI17470@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 30, 2010, Greg KH wrote:
> On Tue, Jun 29, 2010 at 11:28:43AM +0200, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > Please include
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd4c4f17d722ffeb2515bf781400675a30fcead7
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a6b69765ad794389f2fc3e14a0afa1a995221c2
> > 
> > (in this order) into the next 2.6.34.y release (and possibly older maintained
> > -stable kernels where they apply).
> > 
> > The first one requires a little fixup in kernel/power/Makefile , but apart from
> > this they apply to 2.6.34 just fine.
> 
> Now queued up.

Well, please drop these two.  They introduced regressions for people and
IMO -stable will be better off without them.

Rafael
