From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Thu, 19 Aug 2010 09:41:21 +1000
Message-ID: <1282174881.17635.93.camel@shrek.rexursive.com>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<201008190102.04474.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008190102.04474.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-08-19 at 01:02 +0200, Rafael J. Wysocki wrote:

> I'm not a big fan of select in Kconfig.  It ususally causes one to be surprised
> with the final choice of options in .config.
> 
> Does that work at all if CRYPTO_ALGAPI is not set?

My understanding is that these (LZO_COMPRESS/LZO_DECOMPRESS) do not
depend on anything. But, I can test, just to be sure.

> I'd rather wouldn't like the above to be unconditional.  If not for anything
> else, I think it would be nice to be able to switch the compression off for
> debugging purposes (like when we're not sure why the image is corrupted or
> similar).  A kernel command line switch would suffice for that IMO.

OK. I think the cleanest way may be to have a set of two "real"
save_image()/load_image() functions. One set with compression, the other
without, which are then called by save_image()/load_image(). OK?

> > +		if (!i)
> >  			break;
> 
> This statement is profoundly hard to decode.  Perhaps there's a better name for 'i'?
> Like 'size' or similar?

Right. Maybe I'm a bit too economical with names. Usually things like
'i' stand for a generic counter, which this is. I'll use something else
if you don't like it.

> Also please make it possible to switch the compression off here too.
> 
> The comments above seem to apply to the remaining code too.

OK, I'll prepare a patch that has compression/decompression as optional,
using kernel command line switch. Obviously, if one attempts to thaw
from an image that is not in an expected state (compressed/not
compressed), this will wreak havoc. But, I guess that's understandable.

-- 
Bojan
