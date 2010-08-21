From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sat, 21 Aug 2010 16:15:27 +1000
Message-ID: <4C6F6EFF.3040308@tuxonice.net>
References: <1281407348.2618.52.camel@shrek.rexursive.com>	<201008190102.04474.rjw@sisk.pl>	<1282174881.17635.93.camel@shrek.rexursive.com>
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
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

Sorry for being slow to reply, but to my mind, having two copies of the 
whole save and load routines is just plain ugly and makes 
maintainability a nightmare.

Every time I've thought there's been a problem with compression or 
decompression, it has turned out to be a problem in my code instead. 
Let's not waste time and effort duplicating code unnecessarily.

Nigel's 2c.
