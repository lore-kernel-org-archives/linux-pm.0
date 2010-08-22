From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sun, 22 Aug 2010 21:23:16 +0200
Message-ID: <201008222123.16826.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<201008210136.27065.rjw@sisk.pl>
	<1282365609.2671.9.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282365609.2671.9.camel@shrek.rexursive.com>
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

On Saturday, August 21, 2010, Bojan Smojver wrote:
> On Sat, 2010-08-21 at 01:36 +0200, Rafael J. Wysocki wrote:
> > As I wrote, I think it's better to select CRYPTO_LZO here.
> 
> This does a different thing, as I understand it. It brings in a crypto 
> API, which we neither need nor use (we just use compress/decompress from
> LZO library).
> 
> All the other systems I quoted in the other e-mail select this directly,
> because they don't need the crypto API either. So, I reckon we should do
> the same - it is simpler and brings in less stuff, which is always
> better.
> 
> But, if you say this is how it has to be, then we'll do that.

Well, I looked at the code in the meantime and it apparently is sufficient to
select LZO_COMPRESS and LZO_DECOMPRESS.

Thanks,
Rafael
