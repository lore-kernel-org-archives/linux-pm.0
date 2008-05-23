From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] SCSI: remove dev->power.power_state
	from	mesh driver
Date: Fri, 23 May 2008 18:02:11 -0400
Message-ID: <1211580131.8297.320.camel__8468.44938719205$1211580300$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0805231651440.3106-100000@iolanthe.rowland.org>
	<1211576826.11477.46.camel@localhost.localdomain>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1211576826.11477.46.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Paul Mackerras <paulus@au.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Fri, 2008-05-23 at 16:07 -0500, James Bottomley wrote:
> On Fri, 2008-05-23 at 16:53 -0400, Alan Stern wrote:
> > There hasn't been any comment on the patch below, and it hasn't been 
> > applied yet.  Do I need to submit it somewhere else?
> 
> Well, it looks plausible to me, but I'd really like one of the ppc
> people to ack it.

Paul, can you have a quick look, I'm about to head out...

Cheers,
Ben.
