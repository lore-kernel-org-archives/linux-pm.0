From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Fri, 18 May 2007 18:59:49 +0200
Message-ID: <464DDB85.7080203__41173.4504079961$1179507681$gmane$org@s5r6.in-berlin.de>
References: <200705181207.45868.marcus@better.se>
	<20070518082821.230dd4c5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070518082821.230dd4c5.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?ISO-8859-1?Q?g?= <krh@redhat.com>, =?ISO-8859-1?Q?Kristian_H=F8gsber?=@smtp2.linux-foundation.org, linux1394-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

Andrew Morton wrote:
> On Fri, 18 May 2007 12:07:40 +0200 Marcus Better <marcus@better.se> wrote:
>> the fw-ohci driver breaks suspend to RAM on my Thinkpad R60, Intel Core 2 Duo, 
>> kernel 2.6.22-rc1 (x86_64, SMP). It does suspend but hangs on resume if the 
>> fw-ohci module is loaded. (See also the original report [1]).
...
>> [1] http://permalink.gmane.org/gmane.linux.power-management.general/5819

Marcus, thanks for the report.  I will try to reproduce and fix it
unless Kristian is faster.
-- 
Stefan Richter
-=====-=-=== -=-= =--=-
http://arcgraph.de/sr/
