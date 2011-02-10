From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [Xen-devel] Re: [PATCH 0/2] Fix hangup after
 creating checkpoint on Xen.
Date: Thu, 10 Feb 2011 11:31:13 +0000
Message-ID: <1297337473.20491.144.camel__21312.3436239131$1297337563$gmane$org@zakaz.uk.xensource.com>
References: <Pine.LNX.4.44L0.1102081143470.2100-100000@iolanthe.rowland.org>
	<1297186554.9388.248.camel@zakaz.uk.xensource.com>
	<20110209231659.GB249@zanzibar.kublai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110209231659.GB249@zanzibar.kublai.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brendan Cully <brendan@cs.ubc.ca>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-02-09 at 23:16 +0000, Brendan Cully wrote:
> I'd like to keep the fast resume option, and expect that it can be
> contained entirely in Xen-specific code. I'll try to get someone to
> look into it here.

Thanks, please put them in contact with Kazuhiro who has already been
looking into this.

> I think fast resume is somewhat orthogonal to the problem of hanging
> on resume, which just sounds like a xen-specific bug in the slow
> path.

The bug on the Xen side is taking the slow path when the suspend was
actually cancelled, which is what the original patch tries to fix.

Or should/could the slow path be able cope either way?

Ian.

-- 
Ian Campbell
Current Noise: Neil Young - Love And War

For every complex problem, there is a solution that is simple, neat, and wrong.
		-- H. L. Mencken
