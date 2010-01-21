From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BRFC=5D=5BPATCH=5D_PM=3A_Force_GFP=5F?=
 =?iso-8859-1?q?NOIO_during=09suspend/resume_=28was=3A_Re=3A_Memory_alloca?=
 =?iso-8859-1?q?tions_in_=2Esuspend=09became_very_unreliable=29?=
Date: Thu, 21 Jan 2010 22:38:47 +0100
Message-ID: <201001212238.47471.rjw__31624.9007512399$1264109969$gmane$org@sisk.pl>
References: <20100120085053.405A.A69D9226@jp.fujitsu.com>
	<201001212121.50272.rjw@sisk.pl> <4B58BC31.1040406@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B58BC31.1040406@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 January 2010, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > On Thursday 21 January 2010, KOSAKI Motohiro wrote:
> >>  - Ask all drivers how much they require memory before starting suspend and
> >>    Make enough free memory at first?
> > 
> > That's equivalent to reworking all drivers to allocate memory before suspend
> > eg. with the help of PM notifiers.  Which IMHO is unrealistic.
> 
> What's unrealistic about it? I can see that it would be a lot of work,
> but unrealistic? To me, at this stage, it sounds like the ideal solution.

First, we'd need to audit the drivers which is quite a task by itself.
Second, we'd need to make changes, preferably test them or find someone with
suitable hardware to do that for us and propagate them upstream.

I don't really think we have the time to do it.

Rafael
