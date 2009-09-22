From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH] make refrigerator cold
Date: Tue, 22 Sep 2009 14:09:14 -0700
Message-ID: <20090922140914.041b7328__28685.4084734388$1253653853$gmane$org@s6510>
References: <20090921210416.1982bcab@nehalam> <200909222154.09726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909222154.09726.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Sep 2009 21:54:09 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 22 September 2009, Stephen Hemminger wrote:
> > By marking it cold, then the code path in kernel thread 
> > usage of try_to_freeze() that is normally used be
> > selected.
> 

In the code for try_to_freeze(), for optimization, it might
help to tell the compiler to not favor the code path where
the refigrator is being called.

Another way to do the same thing would be to do.
   if (unlikely(freezing(current))) {
	refrigerator();
	return 1;
   } else
	return 0;

or build unlikely into the freezing function (see need_resched).

I saw this by trying to minimize the number of intstructions
in pktgen which is a special case.
