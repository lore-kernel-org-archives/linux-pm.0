From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Date: Wed, 05 Sep 2007 19:43:29 +0200
Message-ID: <46DEEAC1.7020900@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>	<20070827065246.GA21220@ime.usp.br>	<46D279E8.10001@edge.ping.de>	<46D72BC6.3020809@edge.ping.de>	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<20070905102824.a481060c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070905102824.a481060c.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: linux-pm@vger.kernel.org

Randy Dunlap wrote:
> On Wed, 5 Sep 2007 10:07:54 -0700 Andrew Morton wrote:
>>> So here is the output from dmesg that suggested to me that firewire 
>>> might be a problem:
>> Straightforward regression, two reporters, nothing happening.
> 
> (material for ksummit discussion, e.g.)

It's a simple thing in this incident:  I don't read all posts on LKML.
But I typically catch everything where I am in the CC list thanks to the
wonders of sieve.  Andrew, thanks for putting me in the CCs.
-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
