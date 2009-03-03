From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][Patch 0/3] Fix device_move() vs. dpm_list
 issues.
Date: Tue, 3 Mar 2009 09:55:27 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0903030953310.3274-100000@iolanthe.rowland.org>
References: <d82e647a0903030602i3937f8fbq3c2e93573b7714a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d82e647a0903030602i3937f8fbq3c2e93573b7714a8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 3 Mar 2009, Ming Lei wrote:

> 2009/3/3 Cornelia Huck <cornelia.huck@de.ibm.com>:
> > Hi,
> >
> > in thread [1], we discussed the issue of device_move() causing a
> > reordering of devices without adapting the ancestral order in dpm_list.
> > If a device is moved to a new parent that was registered after the
> > device itself, it would still be after its new parent in dpm_list, thus
> > causing the parent to be suspended before its child.
> >
> > This patchset attempts to remedy this situation by introducing an
> > interface for a driver to manipulate dpm_list with the dpm_list_mtx
> > held. (device_move() does not have enough information to do this
> > manipulation itself.) The calling sequence for a driver would be:
> >
> > - lock the dpm_list
> > - call device_move()
> > - if device_move() succeeded, fix up dpm_list
> > - unlock the dpm_list
> 
> IMHO, It is better to fix up dpm_list inside device_move() , like device_add(),
> which may let s390, bluetooth or other possible users more happy with
> device_remove().

I agree; it would be cleaner if device_move() could fix up dpm_list 
directly.  If it doesn't have enough information to do so then change 
the interface so that it does.  That should be pretty easy since there 
are only a handful of callers.

Alan Stern
