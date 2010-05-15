From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Fri, 14 May 2010 22:32:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005142231390.11498-100000__15487.766339402$1273890891$gmane$org@netrider.rowland.org>
References: <AANLkTimBxoCCeT_ns30JTIGKqgkiRIvKTf4LfE3mopkS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimBxoCCeT_ns30JTIGKqgkiRIvKTf4LfE3mopkS@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Reimer <mattjreimer@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 May 2010, Matt Reimer wrote:

> > I don't see anything wrong with the patch itself, but I dislike the
> > description. =A0Devices can come and go from any hotpluggable bus, not
> > just MMC/SD. =A0That just happens to be the first place the problem was
> > observed.
> =

> Good point. How about this?
> =

> Matt
> =

> From 813bd223e5a2fa577b9e64ddf12654a93d0aab8b Mon Sep 17 00:00:00 2001
> From: Matt Reimer <mreimer@sdgsystems.com>
> Date: Thu, 13 May 2010 14:36:54 -0700
> Subject: [PATCH] fs: prevent hang on suspend/resume when MMC/SD card pres=
ent
> =

> Devices can come and go bus during suspend or resume, when the
> writeback thread is frozen, resulting in a hang. Prevent the hang
> by thawing the writeback thread in del_gendisk().

I would have said "the block layer's writeback thread", but this is =

okay.

Alan Stern
