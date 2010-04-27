From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Tue, 27 Apr 2010 14:33:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004271432280.1850-100000__5097.05822119049$1272394836$gmane$org@iolanthe.rowland.org>
References: <y2nd6200be21004262104mb81ba7d6xe5c8f35689ca20a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <y2nd6200be21004262104mb81ba7d6xe5c8f35689ca20a0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Apr 2010, Arve Hj=F8nnev=E5g wrote:

> > If you insist on using ioctl for init, you should use the standard
> > convention for passing variable-length data. =A0The userspace program
> > sets up a fixed-size buffer containing a pointer to the name and the
> > name's length, and it passes the buffer's address as the ioctl
> > argument.
> =

> Are you sure that is the standard? I searched for ioctls with NAME in
> their name and only found one that passed the name that way. The rest
> used fixed length string buffers, or passed the buffersize to _IOC
> like I do. For instance, input.h has ioctls to read string and
> bitmasks where user space specify the buffer size as an argument to
> the ioctl macro. These pass data from the kernel to user space, but I
> don't passing a string length is any worse than passing a buffer size.

You're right.  Okay, I withdraw my objection.

Alan Stern
