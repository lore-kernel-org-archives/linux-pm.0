From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] SCSI: remove dev->power.power_state from
	mesh	driver
Date: Sat, 24 May 2008 20:21:31 +1000
Message-ID: <18487.60459.472964.51725__41927.5729371749$1211624661$gmane$org@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44L0.0803071118040.4398-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803071118040.4398-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> power.power_state is scheduled for removal.  This patch (as1055)
> removes all uses of that field from the SCSI mesh driver.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Paul Mackerras <paulus@samba.org>
