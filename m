From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
 registrations concurrent with suspend/hibernation
Date: Wed, 5 Mar 2008 17:16:29 +0100
Message-ID: <20080305171629.6853c454__11007.4222473942$1204733991$gmane$org@gondolin.boeblingen.de.ibm.com>
References: <200803042252.51440.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0803051050310.4621-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803051050310.4621-100000@iolanthe.rowland.org>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 5 Mar 2008 11:03:52 -0500 (EST),
Alan Stern <stern@rowland.harvard.edu> wrote:

> There might still be logical problems, of course...  We need to add a
> mechanism for reordering the dpm_active list when device_move() is
> called.  But first we need to get in touch with the people using
> device_move() -- basically just Marcel and Cornelia -- and see what
> sort of mechanism they will need.

On s390 we currently don't do anything suspend related at all - I'd
need to think about that. (I use device_move() to reflect topology
changes on the (virtual) hardware, so I'd guess the "don't suspend
parent before child rule" should still apply afterwards. But of course,
that also depends on what we actually need to do on the parent's bus and
what on the child's bus.)
