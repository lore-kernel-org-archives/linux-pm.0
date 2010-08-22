From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sun, 22 Aug 2010 21:47:22 +0200
Message-ID: <201008222147.22784.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282211375.17635.96.camel@shrek.rexursive.com>
	<4C6F6EFF.3040308@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C6F6EFF.3040308@tuxonice.net>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, August 21, 2010, Nigel Cunningham wrote:
> Hi.
> 
> Sorry for being slow to reply, but to my mind, having two copies of the 
> whole save and load routines is just plain ugly and makes 
> maintainability a nightmare.

Well, how much code is actually duplicated by having separate
routines for with and without compression?  I don't think it's too much.

> Every time I've thought there's been a problem with compression or 
> decompression, it has turned out to be a problem in my code instead. 
> Let's not waste time and effort duplicating code unnecessarily.

Having two separate functions for image saving/restoring, depending on cartain
condition, is not wrong in principle as long as they are sufficiently different.
So going back to the previous question, aren't they?

An alternative is to put several conditionals into a sensitive piece of code,
which I'd rather prefer to avoid.

Thanks,
Rafael
