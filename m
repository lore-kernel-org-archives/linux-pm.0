From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 10:33:05 +0200
Message-ID: <20070731103305.39b76a5d@gondolin.boeblingen.de.ibm.com>
References: <20070730084229.1df8757c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0707301330040.9339-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707301330040.9339-100000@iolanthe.rowland.org>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Jul 2007 13:34:35 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> As long as you never hold the device semaphores of both the parent and 
> the child there shouldn't be any problem.  Could this happen when a 
> subchannel structure is deallocated?

This is indeed what happens, since we unregister the child ccw_device
from the (io_)subchannel's remove function.

(We used to do unregistering of the ccw_device via a workqueue (in
order to avoid livelocks on a no longer existing bus semaphore), but
removed it since it seemed to be needlessly complicated code.)
