From: Greg KH <greg@kroah.com>
Subject: Re: Use of parallel init threads for slow devices start
	ups?
Date: Mon, 19 Feb 2007 16:48:57 -0800
Message-ID: <20070220004857.GB9922@kroah.com>
References: <3B6D69C3A9EBCA4BA5DA60D9130274295B9D66@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274295B9D66@dlee13.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 19, 2007 at 11:50:38AM -0600, Woodruff, Richard wrote:
> Hi,
> =

> While doing some startup time profiling it is noticed we spend a lot of
> time in the idle loop.  As there is only one thread initializing devices
> there is no one to schedule during device start ups.  So for example an
> external sensor might need a couple seconds to power up.
> =

> Does anyone want to give an opinion on forking off a parallel thread to
> handle slower devices which are not dependent?

I've added options to the kernel to do just this, and in the end, it
wasn't really worth it.  Yes, it does save some time for some machines,
but the number of errors it added was quite large as most drivers and
bus subsystems are not ready to handle such multi-threaded probing.

But you can try it out yourself if you want, look at the patches in the
previous few kernel releases that enable this functionality.

thanks,

greg k-h
