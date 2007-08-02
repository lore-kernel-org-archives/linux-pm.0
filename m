From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Re: Possible problem with device_move()
Date: Thu, 2 Aug 2007 10:06:33 +0200
Message-ID: <20070802100633.2bd6f72c@gondolin.boeblingen.de.ibm.com>
References: <200708012125.15755.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0708011619050.3174-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0708011619050.3174-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007 16:27:48 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> In fact, I would go even farther.  Let's document the ordering given by
> dpm_active (by default, in order of registration) so that drivers can
> depend on it, and let's add special routines to change the order for
> the few cases that require it -- under driver control.

Driver authors must definitely be made aware of this, and they can only
do something if they are given some control. Implicit assumptions mean
waiting for breakage to happen.

> 
> A "move to the end" routine would solve the EHCI issue.  It ought to 
> solve the problems associated with device_move() also, provided the 
> device being moved doesn't have any children.

The device drivers need to be given more control; they could just walk
the children list in this case then.

> 
> Cornelia and Marcel, is that the case?  When a ccw_device or RFCOMM TTY 
> is reparented under a new device, do any children get moved along with 
> it?

Hm, device_move() just drags around the children with it (and
ccw_devices may have children as added by the driver; zfcp does that,
for example).
