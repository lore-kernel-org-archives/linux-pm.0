From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sat, 21 Aug 2010 14:40:09 +1000
Message-ID: <1282365609.2671.9.camel@shrek.rexursive.com>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282211375.17635.96.camel@shrek.rexursive.com>
	<1282306269.3120.9.camel@shrek.rexursive.com>
	<201008210136.27065.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008210136.27065.rjw@sisk.pl>
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

On Sat, 2010-08-21 at 01:36 +0200, Rafael J. Wysocki wrote:
> As I wrote, I think it's better to select CRYPTO_LZO here.

This does a different thing, as I understand it. It brings in a crypto 
API, which we neither need nor use (we just use compress/decompress from
LZO library).

All the other systems I quoted in the other e-mail select this directly,
because they don't need the crypto API either. So, I reckon we should do
the same - it is simpler and brings in less stuff, which is always
better.

But, if you say this is how it has to be, then we'll do that.

-- 
Bojan
