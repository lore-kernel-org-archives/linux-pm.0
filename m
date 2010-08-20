From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sat, 21 Aug 2010 01:32:58 +0200
Message-ID: <201008210132.58393.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282211375.17635.96.camel@shrek.rexursive.com>
	<1282216262.17635.127.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282216262.17635.127.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 19, 2010, Bojan Smojver wrote:
> On Thu, 2010-08-19 at 19:49 +1000, Bojan Smojver wrote:
> > I still have to see about Kconfig selects. Will
> > get back to you on this 
> 
> For instance, we have this:
> ---------------------
> config JFFS2_LZO
>         bool "JFFS2 LZO compression support" if JFFS2_COMPRESSION_OPTIONS
>         select LZO_COMPRESS
>         select LZO_DECOMPRESS
>         depends on JFFS2_FS
>         default n
>         help
>           minilzo-based compression. Generally works better than Zlib.
> 
>           This feature was added in July, 2007. Say 'N' if you need
>           compatibility with older bootloaders or kernels.
> ---------------------

Actually I think it's preferable to select CRYPTO_LZO that will then select
everything as necessary.

Thanks,
Rafael
