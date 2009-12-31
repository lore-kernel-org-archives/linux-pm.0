From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: kernel 2.6.32 much slower than 2.6.31 on s2disk
Date: Thu, 31 Dec 2009 12:01:25 +0100
Message-ID: <200912311201.25162.rjw@sisk.pl>
References: <hgb0q7$u8a$1@ger.gmane.org> <200912282356.26815.rjw@sisk.pl>
	<4B3C74E9.3020806@wm1.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B3C74E9.3020806@wm1.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Willi Mann <foss-ml@wm1.at>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 31 December 2009, Willi Mann wrote:
> 
> >> Note that when I reported the issue first I used Debian kernel 2.6.32-1,
> >> (probably plain 2.6.32), while I'm now using Debian kernel 2.6.32-2
> >> (according to the changelog 2.6.32.1)
> > 
> > So, is it still a problem for you?
> 
> No, but I'm not sure why it is no longer a problem (kernel or userland
> change?).

Hard to say for sure, but since s2disk hasn't changed for a long time, I guess
it's a result of the kernel change.

Rafael
