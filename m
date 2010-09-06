From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bisected Regression in 2.6.35] A full tmpfs
	filesystem causeshibernation to hang
Date: Mon, 6 Sep 2010 20:46:43 +0200
Message-ID: <201009062046.43513.rjw__3951.00440732694$1283798983$gmane$org@sisk.pl>
References: <20100903105216.B65C.A69D9226@jp.fujitsu.com>
	<201009040344.42342.rjw@sisk.pl>
	<20100906090528.C8A9.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100906090528.C8A9.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, "M. Vefa Bicakci" <bicave@superonline.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, September 06, 2010, KOSAKI Motohiro wrote:
> > > ok, thanks. probably I've catched your point. please feel free to use my reviewed-by
> > > for your fix.
> > 
> > Thanks.
> > 
> > In the meantime, though, I prepared a patch that should address the issue
> > entirely.  The patch is appended and if it looks good to you, I'd rather use it
> > instead of the previous one (it is still untested).
> 
> Yeah, this one looks nicer to me :)
> 
> Thanks, rafael!

OK, I'll put it into my linux-next branch, then.

Probably, though, I should modify the changelog, because what it really does
is to check if it makes sense to try to allocat from non-highmem pages, but it
doesn't really prevent the OOM from occuring.

Thanks,
Rafael
