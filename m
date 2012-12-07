From: Ming Lei <ming.lei@canonical.com>
Subject: Re: Race condition between driver_probe_device and device_shutdown
Date: Sat, 8 Dec 2012 00:27:34 +0800
Message-ID: <CACVXFVPLTHZkveghRc+sp6Fid=Mft5FKW1Yk1Stmj+EEpZwYwQ@mail.gmail.com>
References: <CACVXFVMOxQEJ-nrvGQ-PkevqKkLnXu+QjHgeswkbzFjqOVYCdQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1212071023090.1565-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1212071023090.1565-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 7, 2012 at 11:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 7 Dec 2012, Ming Lei wrote:
>> device_pm_lock() can prevent device_move() from being running.
>
> That wouldn't prevent problems during unbinding.  Wedson is right; the

Right.

> places that lock dev->parent must save a local copy of dev->parent.

One simple fix is to remove acquiring/releasing dev->parent lock
and get/put the parent reference, because holding the device lock only
may avoid the race between probe/remove and shutdown.

But __driver_attach and __device_release_driver need
save the local copy of dev->parent.

Thanks,
--
Ming Lei
