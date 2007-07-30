From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Possible problem with device_move()
Date: Mon, 30 Jul 2007 08:42:29 +0200
Message-ID: <20070730084229.1df8757c@gondolin.boeblingen.de.ibm.com>
References: <Pine.LNX.4.44L0.0707281123080.16987-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707281123080.16987-100000@netrider.rowland.org>
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

On Sat, 28 Jul 2007 11:36:42 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> Can you tell whether this will ever cause a problem?  Or is it known to
> be safe because whenever you call device_move(), the new parent was
> registered before the device being moved?

Unfortunately, we can't make any assumptions in cio whether the new
parent was registered before the moving device.

(A little background: We have each ccw_device as parent of a subchannel
as discovered during initial sense. In the case of z/VM (a hypervisor),
all subchannels are always consecutively numbered. Now the following
may happen: A dasd on subchannel 0 is detached and a new device, say a
ctc, is defined. As subchannel 0 was free from z/VMs perspective, the
ctc ccw_device now sits on subchannel 0 and the dasd ccw_device is
moved to the artificial 'defunct' subchannel. When the dasd is attached
again, z/VM will hand out the next free subchannel, which we allocate a
subchannel structure for and move the dasd ccw_device to. And here's
the case where the child is older than the parent...)

While we don't do suspend/resume yet on s390, I don't want to rule it
out for the future...
