From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 2.6.35 Regression: Ages spent discarding blocks that
	weren't used!
Date: Wed, 04 Aug 2010 14:02:10 -0400
Message-ID: <yq17hk6qmsd.fsf__33658.3769917071$1280956833$gmane$org@sermon.lab.mkp.net>
References: <4C58C528.4000606@tuxonice.net> <4C5960B0.7020003@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C5960B0.7020003@teksavvy.com> (Mark Lord's message of "Wed, 04
	Aug 2010 08:44:32 -0400")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <kernel@teksavvy.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>>>>> "Mark" == Mark Lord <kernel@teksavvy.com> writes:

Mark> Looks to me like more and more things are using the block discard
Mark> functionality, and as predicted it is slowing things down
Mark> enormously.

Mark> The problem is that we still only discard tiny bits (a single
Mark> range still??)  per TRIM command, rather than batching larger
Mark> ranges and larger numbers of ranges into single TRIM commands.

Mark> That's a very poor implementation, especially when things start
Mark> enabling it by default.  Eg. the swap code, mke2fs, etc..

I'm working on aggregation.  But it's harder than we initially
thought...

-- 
Martin K. Petersen	Oracle Linux Engineering
