From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrinking memory for suspend?
Date: Mon, 30 Apr 2007 17:10:42 +0200
Message-ID: <200704301710.43329.rjw@sisk.pl>
References: <1177943076.5102.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177943076.5102.83.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 30 April 2007 16:24, Johannes Berg wrote:
> Hi,
> 
> Paul Mackerras noticed that even for suspend to ram we currently free
> some memory in suspend_prepare. Is that necessary because we freeze
> userspace so devices can allocate a bit of memory for suspend?

I don't think it's related to the freezing of user space.  You can allocate
memory with all of the user space frozen just fine.  I'd say it's related to
the freezing of kernel threads, rather.

> Why do we freeze userspace anyway?

Well, let me quote Linus:

"I _do_ realize the IO request queue issues, and that we cannot actually do 
s2ram with some devices in the middle of a DMA. So we want to be able to 
avoid *that*, there's no question about that. And I suspect that stopping 
user threads and then waiting for a sync is practically one of the easier 
ways to do so."

Greetings,
Rafael
