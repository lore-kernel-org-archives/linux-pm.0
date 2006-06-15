From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 13:04:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606151303280.5807-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Jun 2006, Linus Torvalds wrote:

> In order for this to actually _work_, you need to have
> =

> 	device_save_state();
> 		.. calls down to each device, saving their      ..
> 		.. state BUT NOT SUSPENDING THEM!               ..
> 		.. This phase can return an error, and can do   ..
> 		.. things like memory allocations.              ..
> =

> 		.. If an error happens here, we just return. We ..
> 		.. do NOT "restore" any state, because there IS ..
> 		.. NO STATE TO RESTORE - we've not actually     ..
> 		.. _changed_ anything ..
> =

> 		.. In other words, for a regular PCI device     ..
> 		.. this function does "pci_save_state()". Not   ..
> 		.. _anything_ else!                             ..
> =

> 	save_image_to_disk();
> 		.. NONE OF THE DEVICES ARE SUSPENDED! So all the  ..
> 		.. idiotic crap about trying to keep the "suspend ..
> 		.. device" alive would be the obvious crap it is! ..

How can you create a consistent memory image if devices are doing DMA into =

memory while the snapshot is in progress?

Alan Stern
