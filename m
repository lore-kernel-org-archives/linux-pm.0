From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/23] Hibernation: Split compression support
	out.
Date: Sat, 2 Oct 2010 00:15:10 +0200
Message-ID: <201010020015.10749.rjw__46603.6516511396$1285971498$gmane$org@sisk.pl>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<201010012328.09892.rjw@sisk.pl> <4CA65684.1050500@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CA65684.1050500@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Friday, October 01, 2010, Nigel Cunningham wrote:
> Hi Rafael.

Hi,

> On 02/10/10 07:28, Rafael J. Wysocki wrote:
> > On Monday, September 27, 2010, Nigel Cunningham wrote:
> >> Hi.
> >>
> >> On 28/09/10 06:27, Rafael J. Wysocki wrote:
> >>> On Monday, September 27, 2010, Nigel Cunningham wrote:
> > ...
> >>> This one doesn't really good to me.  What I'd prefer would be to have a
> >>> structure of "swap operations" pointers like ->start(), ->write_data(),
> >>> ->read_data(), and ->finish() that will point to the functions in this file
> >>> (if compression is to be used) or to the "old" swap_write_page()/swap_read_page()
> >>> otherwise.  That would reduce the number of the
> >>> (flags&   SF_NOCOMPRESS_MODE) checks quite substantially and will likely result
> >>> in code that's easier to follow.
> >>
> >> Me too. I was heading in that direction, but not doing it in one step.
> >> I'll happily change that.
> >
> > I'm still waiting for the reworked patch.  If you can submit it in a few days
> > and it looks good, I'll include it into the pull request for 2.6.37.
> 
> Sorry for the delay.

No biggie.

> Would you be happy if, rather than reworking that patch and modifying 
> other patches that are affected, I added a new patch to the end of the 
> series?

Not really.  That would make it difficult for other people to follow the
changes.  Let's do things in the right order from the start. :-)

Thanks,
Rafael
