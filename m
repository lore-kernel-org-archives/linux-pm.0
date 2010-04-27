From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 28 Apr 2010 00:03:31 +0200
Message-ID: <201004280003.31668.rjw__37555.0749050037$1272405804$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1004271432280.1850-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004271432280.1850-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 27 April 2010, Alan Stern wrote:
> On Mon, 26 Apr 2010, Arve Hj=F8nnev=E5g wrote:
> =

> > > If you insist on using ioctl for init, you should use the standard
> > > convention for passing variable-length data.  The userspace program
> > > sets up a fixed-size buffer containing a pointer to the name and the
> > > name's length, and it passes the buffer's address as the ioctl
> > > argument.
> > =

> > Are you sure that is the standard? I searched for ioctls with NAME in
> > their name and only found one that passed the name that way. The rest
> > used fixed length string buffers, or passed the buffersize to _IOC
> > like I do. For instance, input.h has ioctls to read string and
> > bitmasks where user space specify the buffer size as an argument to
> > the ioctl macro. These pass data from the kernel to user space, but I
> > don't passing a string length is any worse than passing a buffer size.
> =

> You're right.  Okay, I withdraw my objection.

In the meantime, though, I thought that the suspend blocker might be created
by _open() if we found a way to automatically choose a name for it.  That'd=
 be
kind of logical, since it's later destroyed by _release().

So, what about using the name of the process that opened the special device
file (or that name with'0' appended, or generally with a number appended) as
the suspend blocker name?

Rafael
