From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Patch 0/2: Add compression support to swsusp.
Date: Tue, 7 Jul 2009 00:16:46 +0200
Message-ID: <200907070016.47162.rjw__33134.5635735945$1246918733$gmane$org@sisk.pl>
References: <4A518BA5.3060900@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A518BA5.3060900@crca.org.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Monday 06 July 2009, Nigel Cunningham wrote:
> Hi Rafael.

Hi,

> Sorry that I've been so slow to send anything after our recent
> discussion about merging TuxOnIce. Too much on my plate, as usual.

No problem, I've been quite busy recently too.

> Here are a couple of patches for your consideration. The first one adds
> support for combining partial pages together when writing the image
> proper, and breaking them apart again when reading the image back. The
> second patch builds on the first one, adding support for compressing the
> data that is written in an image.
> 
> The net effect should be a good boost in the speed of writing the image,
> but a slowdown (for now) in the speed of reading the image, because we
> can't decompress data that hasn't been read yet, and so currently need
> to do the reads synchronously. I'm a bit under the weather at the
> moment, and am going to go to bed now. I hope, though, to get another
> patch or two prepared reasonably quickly, which will implement an
> algorithm for doing readahead.

Thanks for the patches, I'll have a look at them shortly, but I need to prepare
some slides for the Linux Symposium, so please be patient. :-)

Best,
Rafael
