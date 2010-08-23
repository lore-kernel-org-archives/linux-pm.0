From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Tue, 24 Aug 2010 09:20:47 +1000
Message-ID: <1282605647.23359.7.camel@shrek.rexursive.com>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282516434.23359.0.camel@shrek.rexursive.com>
	<1282520861.23359.1.camel@shrek.rexursive.com>
	<201008232343.10665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008232343.10665.rjw@sisk.pl>
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

On Mon, 2010-08-23 at 23:43 +0200, Rafael J. Wysocki wrote:
> OK, so changelog please?
> 
> Or should I use the original one? 

Yeah, the old one should be good enough, I guess. Here it is once again:

Compress hibernation image with LZO in order to save on I/O and
therefore time to hibernate/thaw.

-- 
Bojan
