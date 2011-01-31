From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] i2c: OMAP: fix static suspend vs. runtime
 suspend
Date: Mon, 31 Jan 2011 11:22:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101311119190.1931-100000__3434.2503677637$1296491515$gmane$org@iolanthe.rowland.org>
References: <877hdl9hsn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877hdl9hsn.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 31 Jan 2011, Kevin Hilman wrote:

> I understand how this works, but frankly I'm still a bit fuzzy on why.
> 
> I guess I'm still missing a good understanding of what "interfering with a
> system power transition" means, and why a runtime suspend qualifies as
> interfering but not a runtime resume.

These are good questions.  Rafael implemented this design originally; 
my contribution was only to warn him of the potential for problems.  
Therefore he should explain the rationale for the design.

> More specifically, the reason for $SUBJECT patch is precisely because a
> runtime resume is allowed, a runtime suspend is not, and thus a system
> power transititon is prevented.

Alan Stern
