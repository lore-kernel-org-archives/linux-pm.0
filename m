From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Thu, 19 Aug 2010 21:11:02 +1000
Message-ID: <1282216262.17635.127.camel@shrek.rexursive.com>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<201008190102.04474.rjw@sisk.pl>
	<1282174881.17635.93.camel@shrek.rexursive.com>
	<1282211375.17635.96.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282211375.17635.96.camel@shrek.rexursive.com>
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

On Thu, 2010-08-19 at 19:49 +1000, Bojan Smojver wrote:
> I still have to see about Kconfig selects. Will
> get back to you on this 

For instance, we have this:
---------------------
config JFFS2_LZO
        bool "JFFS2 LZO compression support" if JFFS2_COMPRESSION_OPTIONS
        select LZO_COMPRESS
        select LZO_DECOMPRESS
        depends on JFFS2_FS
        default n
        help
          minilzo-based compression. Generally works better than Zlib.

          This feature was added in July, 2007. Say 'N' if you need
          compatibility with older bootloaders or kernels.
---------------------

And this:
---------------------
config ZRAM
        tristate "Compressed RAM block device support"
        depends on BLOCK
        select LZO_COMPRESS
        select LZO_DECOMPRESS
        default n
        help
          Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
          Pages written to these disks are compressed and stored in memory
          itself. These disks allow very fast I/O and compression provides
          good amounts of memory savings.

          It has several use cases, for example: /tmp storage, use as swap
          disks and maybe many more.

          See zram.txt for more information.
          Project home: http://compcache.googlecode.com/
---------------------

And this:
---------------------
config CRYPTO_LZO
        tristate "LZO compression algorithm"
        select CRYPTO_ALGAPI
        select LZO_COMPRESS
        select LZO_DECOMPRESS
        help
          This is the LZO algorithm.
---------------------

And finally, we have this:
---------------------
#
# compression support is select'ed if needed
#
config ZLIB_INFLATE
        tristate

config ZLIB_DEFLATE
        tristate

config LZO_COMPRESS
        tristate

config LZO_DECOMPRESS
        tristate
---------------------

Which would suggest to me that selecting it is the right thing to do.

-- 
Bojan
